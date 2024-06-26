{ solaar, home-manager, nixVirt, lanzaboote,
  lib, config, pkgs, nixos-hardware, ...
}:

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
    ../../modules/controller
    ../../modules/powerManagement
    ../../modules/secureBoot

    # Import system flakes
    nixVirt.nixosModules.default
    home-manager.nixosModules.home-manager
    solaar.nixosModules.default
    lanzaboote.nixosModules.lanzaboote
    nixos-hardware.nixosModules.framework-16-7040-amd

    # Import specific modules
    ./kvm.nix
  ];
  # enable solaar
  programs.solaar.enable = true;

  # Enable fwupd
  services.fwupd.enable = true;
  hardware.keyboard.qmk.enable = true;
  
  # Enable Waydroid
  virtualisation.waydroid.enable = true;

  # Fix Wlan after suspend or Hibernate
  environment.etc."systemd/system-sleep/fix-wifi.sh".source =
    pkgs.writeShellScript "fix-wifi.sh" ''
      case $1/$2 in
        pre/*)
          ${pkgs.kmod}/bin/modprobe -r mt7921e mt792x_lib mt76
          echo 1 > /sys/bus/pci/devices/0000:04:00.0/remove
          ;;

        post/*)
          ${pkgs.kmod}/bin/modprobe mt7921e
          echo 1 > /sys/bus/pci/rescan
          ;;
      esac
    '';

  # Add AMD CPU driver
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.enableRedistributableFirmware = true;

  boot = {
    initrd= {
      availableKernelModules = [
        "xhci_pci"
        "nvme"
        "usbhid"
        "usb_storage"
        "sd_mod"
        "thunderbolt"
      ];
    };
    kernelModules = [ "sg" ];
    kernelParams = [
      "mem_sleep_default=deep"

      "vt.default_red=30,243,166,249,137,245,148,186,88,243,166,249,137,245,148,166"
      "vt.default_grn=30,139,227,226,180,194,226,194,91,139,227,226,180,194,226,173"
      "vt.default_blu=46,168,161,175,250,231,213,222,112,168,161,175,250,231,213,200"
    ];
  };
  # Maybe mds=full,nosmt
  #boot.kernelParams = [ "mem_sleep_default=deep" "amdgpu.sg_display=0" "amdgpu.reset_method=4" "mds=full" "efi=runtime" "vt.default_red=30,243,166,249,137,245,148,186,88,243,166,249,137,245,148,166" "vt.default_grn=30,139,227,226,180,194,226,194,91,139,227,226,180,194,226,173" "vt.default_blu=46,168,161,175,250,231,213,222,112,168,161,175,250,231,213,200" ];

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
    swapDevices = [
      {
        label = "Swap";
      }
    ];

  # Nix config
  nixpkgs.config.allowUnfree = true;
}
