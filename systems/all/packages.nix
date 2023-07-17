{ pkgs, flatpak, ... }:

let
  prepare_spotify = pkgs.writeShellScriptBin "prepare_spotify" (readFile ../../scripts/prepare_spotify.sh);
in
{
  system.autoUpgrade = {
    enable = true;
    dates = "daily";
  };

  nixpkgs.config.allowUnfree = true;
  environment = {
    systemPackages = with pkgs; [
      git
      wget
      tree
      (nnn.override { withNerdIcons = true; })
      nerdfonts
      kate
      pciutils
      clinfo
      glxinfo
      vulkan-tools
      neofetch
      killall
      spicetify-cli
      betterdiscordctl
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
