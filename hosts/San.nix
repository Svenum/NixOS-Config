{ lib, config, pkgs, solaar, ... }:

{
  # Import Modules
  imports = [
    # Import modules
    ../modules/user
    ../modules/boot
    ../modules/nvim
    ../modules/locale
    ../modules/desktop
    ../modules/wireguard
    ../modules/tmux 
    ../modules/shell
    ../modules/flatpak
    ../modules/printer
    ../modules/cliTools
    ../modules/network
    ../modules/bluetooth
    ../modules/tlp
    ../modules/kvm
    ../modules/nvidia

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

  # Add AMD CPU driver 
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;  
  hardware.enableRedistributableFirmware = lib.mkDefault true;

  # Configure Kernel
  boot.initrd = {
    availableKernelModules = [ "nvme" "xhci_pci" "ahci" "sd_mod" ];
  };
  boot.kernelModules = [ "kvm-amd" "sg" ];
  boot.kernelParams = [  "amd_pstate=active" "amd_iommu=pt" "vt.default_red=239,210,64,223,30,234,23,108,172,210,64,223,30,234,23,76" "vt.default_grn=241,15,160,142,102,118,146,111,176,15,160,142,102,118,146,79" "vt.default_blu=245,57,43,29,245,203,153,133,190,57,43,29,245,203,153,105" ];

  # Configure Filesystem
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/fedb4e6c-ce61-4d4c-b213-7c2d14444cba";
      fsType = "ext4";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/a4b2f370-b508-4a30-8e5d-fd3651e809c5";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/EA04-C389";
      fsType = "vfat";
    };

  fileSystems."/mnt/sven" = {
    device = "//srv-unraid.intra.holypenguin.net/sven";
    fsType = "cifs";
    options = let
      automount_opts = ["x-systemd.automount" "noauto" "echo_interval=10" "x-systemd.idle-timeout=10" "x-systemd.device-timeout=5s" "x-systemd.mount-timeout=5s"];
    in automount_opts ++ [ "uid=sven" "gid=users" "mfsymlinks" "soft" "rsize=8192" "wsize=8192" "_netdev" "credentials=${config.home-manager.users.sven.home.homeDirectory}/.smb"];
  };

  # enable mount cifs for normal user
  security.wrappers."mount.cifs" = {
    setuid = true;
    owner = "root";
    group = "root";
    source = "${pkgs.cifs-utils}/bin/mount.cifs";
  };

  # Nix config
  system.autoUpgrade = {
    enable = true;
    dates = "daily";
  };
  system.stateVersion = "23.05";
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
