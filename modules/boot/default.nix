{ pkgs, config, settings, ... }:

{
  # Filesystems
  boot.supportedFilesystems = [ "ntfs" ];

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Bootloader
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 15;
    };
    efi.canTouchEfiVariables = true;
    timeout = 1;
  };

  boot.initrd.systemd.enable = true;
  boot.kernelParams = [ "quiet" "udev.log_level=3" ];

  # Configure Plymouth
  boot.plymouth = {
    enable = true;
    theme = "catppuccin-${settings.theme.flavour}";
    themePackages = with pkgs; [
      (catppuccin-plymouth.override {
        variant = settings.theme.flavour;
      })
    ];
  };
}
