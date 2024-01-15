{ userAttrs, lib, config, home-manager, pkgs, de, plasma-manager, themeAccent, themeFlavour, ... }:

let
  mkUser = name: user: {
    isNormalUser = true;
    description = name;
    shell = lib.mkIf (if builtins.hasAttr "shell" user then true else false) pkgs.${user.shell};
    extraGroups = [ "networkmanager" "libvirtd" "network" "video" "sys" "audio" "kvm" "optical" "scanner" "lp" (lib.mkIf (if builtins.hasAttr "isSudoUser" user then user.isSudoUser else false) "wheel")];
    useDefaultShell = true;
    uid = lib.mkIf (if builtins.hasAttr "uid" user then true else false) user.uid;
    openssh.authorizedKeys.keys = lib.mkIf (if builtins.hasAttr "authorizedKeys" user then true else false) user.authorizedKeys;
  };

  mkUserConfig = name: user: {
    # Home-Manager Config
    home = {
      username = name;
      homeDirectory = "/home/${name}";
      stateVersion = "23.11";
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
        XDG_GAMES_DIR = "${config.home-manager.users.${name}.home.homeDirectory}/Games";
        XDG_GITHUB_DIR = "${config.home-manager.users.${name}.home.homeDirectory}/GitHub";
      };
    };

    # Import user specific modues if needed
    imports = if (builtins.pathExists ../../users/${name}/default.nix ) then [ ../../users/${name} ] ++ (if de.name == "plasma" then [ plasma-manager.homeManagerModules.plasma-manager ] else []) else [];
  };
in
{
  # Create user
  users.users = lib.mkMerge [ (lib.mapAttrs mkUser userAttrs) { root.hashedPassword = "!"; } ];

  # Configure user
  imports = [ home-manager.nixosModules.home-manager ];
  home-manager.users = lib.mapAttrs mkUserConfig userAttrs;
  home-manager.extraSpecialArgs = {
    systemConfig = config;
    inherit themeAccent;
    inherit themeFlavour;
  };
}
