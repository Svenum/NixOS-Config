{ ... }:

{
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
}
