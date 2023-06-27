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
      clinfo
      glxinfo
      vulkan-tools
    ];
  };

  # Enable fwupd
  services.fwupd.enable = true;

  # Enable Flatpak
  services.flatpak.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
