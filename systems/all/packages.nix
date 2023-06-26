{ pkgs, ... }:

{
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
      fwupd
      clinfo
      glxinfo
      vulkan-tools
    ];
  };

  # Enable Flatpak
  services.flatpak.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
