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
    ../../modules/wireguard
    ../../modules/tmux 
    ../../modules/shell
    ../../modules/flatpak
    ../../modules/printer
    ../../modules/cliTools
    ../../modules/network
    ../../modules/bluetooth
    ../../modules/kvm
    ../../modules/nvidia

    # Import flakes
    solaar.nixosModules.default
  ];
  # enable solaar
  programs.solaar.enable = true;

  # Enable fwupd
  services.fwupd.enable = true;

  # Steam
  hardware.steam-hardware.enable = true;

  # XBox Controller
  hardware.xpadneo.enable = true;
  
  hardware.xone.enable = true;

  # Intel CPU Driver
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Configure Kernel
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "sr_mod" ];
  boot.kernelModules = [ "kvm-intel" "sg" ];
  # Maybe mds=full,nosmt
  boot.kernelParams = ["mds=full" "efi=runtime" "iommu=pt" "intel_iommu=on" "vt.default_red=30,243,166,249,137,245,148,186,88,243,166,249,137,245,148,166" "vt.default_grn=30,139,227,226,180,194,226,194,91,139,227,226,180,194,226,173" "vt.default_blu=46,168,161,175,250,231,213,222,112,168,161,175,250,231,213,200" ];

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

  fileSystems."/home/sven/Games/SSD" = {
    device = "/dev/disk/by-uuid/0efe8c88-b10c-4ef8-8ca0-49df2c10d389";
    fsType = "btrfs";
    options = ["subvol=/@games" "auto" "defaults" "discard=async" "ssd"];
  };

  fileSystems."/home/sven/Games/HDD" = {
    device = "/dev/disk/by-uuid/6cd63ba0-39fc-40a6-9086-8ab45fb943d0";
    fsType = "btrfs";
    options = [ "subvol=/@games" "auto" "defaults" ];
  };

  # Nix config
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;
}
