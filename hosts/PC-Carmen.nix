{ lib, config, pkgs, ... }:

{
  # Import Modules
  imports = [
    # Import modules
    ../modules/user
    ../modules/boot
    ../modules/nvim
    ../modules/locale
    ../modules/desktop
    ../modules/tmux 
    ../modules/shell
    ../modules/flatpak
    ../modules/printer
    ../modules/cliTools
    ../modules/network
    ../modules/bluetooth
  ];

  # Enable ssh
  services.openssh.enable = true;

  # Enable fwupd
  services.fwupd.enable = true;

  # Intel CPU Driver
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Configure Kernel
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" ];
  boot.kernelModules = [ "kvm-intel" ];

  # Configure Filesystem
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/43beedfd-02d6-4865-8d2f-342848d7377e";
    fsType = "vfat";
  };
   
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/140A-391A";
    fsType = "ext4";
  };
   
  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/f78f8a4b-3c88-4166-85b1-724081956528";
    fsType = "ext4";
  };

  # Nix config
  system.stateVersion = "23.11";
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
