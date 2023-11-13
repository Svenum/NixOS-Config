{ pkgs, config, themeFlavour, ... }:

{
  # Kernel
  #boot.kernelPackages = pkgs.linuxPackages_latest;

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
  boot.kernelParams = [ "quiet" ];

  # Configure Plymouth
  boot.plymouth = {
    enable = true;
    theme = "catppuccin-${themeFlavour}";
    themePackages = with pkgs; [
      (catppuccin-plymouth.override {
        variant = themeFlavour;
      })
    ];
  };
}
