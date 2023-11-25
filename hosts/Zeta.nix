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
    ../modules/kvm
  ];
  # Enable fwupd
  services.fwupd.enable = true;

  # Intel CPU Driver
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Configure Kernel
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "sr_mod" ];
  boot.kernelModules = [ "kvm-intel" "sg" ];
  # Maybe mds=full,nosmt
  boot.kernelParams = ["mds=full" "efi=runtime" "iommu=pt" "intel_iommu=on" ];

  # Configure Filesystem
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/9d369d41-4c3f-4ec7-8b67-b14e99893fc3";
      fsType = "ext4";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/a247be30-1246-42f4-bc92-292e550afc0e";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/3A0D-81B1";
      fsType = "vfat";
    };

  # Nix config
  system.autoUpgrade = {
    enable = true;
    dates = "daily";
  };
  system.stateVersion = "23.05";
  nixpkgs.config.allowUnfree = true;
}
