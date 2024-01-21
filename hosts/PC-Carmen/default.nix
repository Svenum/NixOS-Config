{ lib, config, pkgs, solaar, ... }:

{
  # Import Modules
  imports = [
    # Import modules
    ../../modules/nixos
    ../../modules/user
    ../../modules/boot
    ../../modules/nvim
    ../../modules/locale
    ../../modules/desktop
    ../../modules/tmux 
    ../../modules/shell
    ../../modules/flatpak
    ../../modules/printer
    ../../modules/cliTools
    ../../modules/network
    ../../modules/bluetooth

    # Import flakes
    solaar.nixosModules.default
  ];

  # enable solaar
  programs.solaar.enable = true;

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
    device = "/dev/disk/by-uuid/29037497-4c3e-48ae-9c18-4b100cfcf90f";
    fsType = "ext4";
  };
   
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/D484-C573";
    fsType = "vfat";
  };
   
  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/9081fe75-7dec-4ca0-ad0d-aa13056751bb";
    fsType = "ext4";
  };

  # Nix config
  nixpkgs.config.allowUnfree = true;
}
