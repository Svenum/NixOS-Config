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
    ../../modules/amdgpu

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

  # Enable Fingerprintreader
  services.fprintd.enable = lib.mkDefault true;
  
  # Bind amdgpu on sddm start
  services.xserver.displayManager.setupCommands = ''
    echo 0000:03:00.0 > /sys/bus/pci/drivers/vfio-pci/unbind
    echo 0000:03:00.0 > /sys/bus/pci/drivers/amdgpu/bind
  '';

  # Add AMD CPU driver
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.enableRedistributableFirmware = lib.mkDefault true;

  # Configure Kernel
  boot.extraModprobeConfig = ''
    #softdep amdgpu pre: vfio-pci
    #options vfio-pci ids=1002:7480,1002:ab30
    options kvm ignore_msrs=1
  '';
  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usbhid" "usb_storage" "sd_mod" "thunderbolt" ];
  boot.kernelModules = [ "kvm-amd" "sg" ];
  # Maybe mds=full,nosmt
  boot.kernelParams = ["mds=full" "efi=runtime" "kvm_amd.avic=1" "kvm_amd.npt=1" "iommu=pt" "amd_iommu=on" "vt.default_red=30,243,166,249,137,245,148,186,88,243,166,249,137,245,148,166" "vt.default_grn=30,139,227,226,180,194,226,194,91,139,227,226,180,194,226,173" "vt.default_blu=46,168,161,175,250,231,213,222,112,168,161,175,250,231,213,200" ];

  # Configure Filesystem
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/0abec576-e226-4276-8e4f-deabb395bf65";
      fsType = "ext4";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/59dfb4d5-9964-4797-84a1-342adc189e94";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/142B-16BD";
      fsType = "vfat";
    };

  # Nix config
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;
}
