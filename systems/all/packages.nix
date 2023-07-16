{ pkgs, flatpak, ... }:

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
      partition-manager
      pciutils
      clinfo
      glxinfo
      vulkan-tools
      neofetch
    ];
  };

  # Enable fwupd
  services.fwupd.enable = true;

  # Enable Flatpak
  services.flatpak.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
