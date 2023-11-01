{ userAttrs, lib, config, home-manager, ... }:

let
  mkUser = name: user: {
    isNormalUser = true;
    description = name;
    extraGroups = [ "networkmanager" "libvirtd" "network" "video" "sys" "audio" "kvm" "optical" "scanner" "lp" (lib.mkIf (if builtins.hasAttr "isSudoUser" user then user.isSudoUser else false) "wheel")];
    useDefaultShell = true;
  };

  mkUserConfig = name: user: {
    # Home-Manager Config
    home = {
      username = name;
      homeDirectory = "/home/${name}";
      stateVersion = "23.05";
    };
    programs.home-manager.enable = true;

    # Git Config
    programs.git = lib.mkIf (if builtins.hasAttr "git" user then true else false) {
      enable = true;
      userName = user.git.userName;
      userEmail = user.git.userEmail;
      extraConfig = {
        safe.directory = "/etc/nixos";
      };
    };

    # XDG Config
    xdg.userDirs = lib.mkIf (if builtins.hasAttr "isGuiUser" user then user.isGuiUser else false) {
      enable = true;
      createDirectories = true;
      extraConfig = {
        XDG_GAMES_DIR = "${config.home.homeDirectory}/Games";
        XDG_GITHUB_DIR = "${config.home.homeDirectory}/GitHub";
      };
    };
  };
in
{
  # Create user
  users.users = lib.mkMerge [ (lib.mapAttrs mkUser userAttrs) { root.hashedPassword = "!"; } ];

  # Configure user
  imports = [ home-manager.nixosModules.home-manager ];
  home-manager.users = lib.mapAttrs mkUserConfig userAttrs;
}
