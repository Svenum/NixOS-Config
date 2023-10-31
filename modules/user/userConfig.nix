{ user, home-manager, lib, ... }:
{
  # Create user
  users.defaultUserShell = pkgs.zsh;
  users.users.${user.name} = {
    isNormalUser = true;
    description = user.name;
    # Add user to default groups
    extraGroups = [ "networkmanager" "libvirtd" "network" "video" "sys" "audio" "kvm" "optical" "scanner" "lp" ];
    # Enable sudo if wanted
    extraGroups = mkIf user.sudo ? false [ "wheel" ];
    useDefaultShell = true;
  };

  # Home-Manager config
  import home-manager.nixosModules.home-manager;
  home-manager.users.${user.name} = {
    home = {
      # Standard user config
      username = user.name;
      homeDirectory = "/home/${user.name}";
      stateVersion = "23.05";
    };

    # Git config
    programs.git = lib.mkIf user.git.enable ? false {
      enable = true;
      userName = user.git.userName;
      userEmail = user.git.userEmail;
      extraConfig = {
        safe.directory = "/etc/nixos";
      };
    };
    
    # Enable home-manager
    programs.home-manager.enable = true;

    # enable xdg userDirs
    xdg.userDirs = lib.mkIf user.gui ? false {
      enable = true;
      createDirectories = true;
      extraConfig = {
        XDG_GAMES_DIR = lib.mkIf user.gameDir "${config.home.homeDirectory}/Games";
        XDG_GITHUB_DIR = lib.mkIf user.githubDir "${config.home.homeDirectory}/GitHub";
      };
    };
  };
}
