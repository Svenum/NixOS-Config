{ pkgs, ... }:

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
      libsForQt5.qt5.qtwebsockets
      python311Packages.docopt
      python311Packages.numpy
      python311Packages.pyaudio
      python311Packages.cffi
      python311Packages.websockets
    ];
  };

  # Enable fwupd
  services.fwupd.enable = true;

  # Enable Flatpak
  services.flatpak.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
