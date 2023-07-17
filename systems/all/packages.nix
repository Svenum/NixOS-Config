{ pkgs, flatpak, ... }:

let
  prepare_spotify = pkgs.writeShellScriptBin "prepare_spotify" (builtins.readFile ../../scripts/prepare_spotify.sh);
in
{
  system.autoUpgrade = {
    enable = true;
    dates = "daily";
  };

  nixpkgs.config.allowUnfree = true;
  environment = {
    systemPackages = with pkgs; [
      # CLI Packages
      git
      wget
      tree
      unzip
      pciutils
      clinfo
      killall
      neofetch
      # Vim
      (nnn.override { withNerdIcons = true; })
      nerdfonts
      # Theming
      spicetify-cli
      betterdiscordctl
      prepare_spotify
      # GUI TOols
      kate
      # Other
      glxinfo
      vulkan-tools
    ];
  };
  # Enable partitionmanager
  programs.partition-manager.enable = true;

  # Enable fwupd
  services.fwupd.enable = true;

  # Enable Flatpak
  services.flatpak.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
