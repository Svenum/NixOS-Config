{ lib, config, pkgs, ... }:

let
  autoMountOpts = ["x-systemd.automount" "noauto" "echo_interval=10" "x-systemd.idle-timeout=10" "x-systemd.device-timeout=5s" "x-systemd.mount-timeout=5s"];
  smbMountOpts = autoMountOpts ++ [ "uid=martinn" "gid=users" "mfsymlinks" "soft" "rsize=8192" "wsize=8192" "_netdev" "credentials=${config.home-manager.users.martinn.home.homeDirectory}/.smb"];
in
{
  # Import Modules
  imports = [
    # Import modules
    ../modules/rdp
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

  # Enable ssh
  services.openssh.enable = true;

  # Enable fwupd
  services.fwupd.enable = true;

  # Intel CPU Driver
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Configure Kernel
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "firewire_ohci" "usb_storage" "sd_mod" "sr_mod" ];
  boot.kernelModules = [ "kvm-intel" "sg" ];
  # Maybe mds=full,nosmt
  boot.kernelParams = ["mds=full" "efi=runtime" "iommu=pt" "intel_iommu=on" ];

  # Configure RAID
  boot.swraid = {
    enable = true; 
    mdadmConf = ''
      # automatically tag new arrays as belonging to the local system
      HOMEHOST <system>

      # instruct the monitoring daemon where to send mail alerts
      MAILADDR root

      # definitions of existing MD arrays
      ARRAY /dev/md/1  metadata=1.2 UUID=b9c00b97:f6bcf7d4:d0660752:947755d1 name=Zeta:1
    '';
  };

  # Configure Filesystem
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/c7c3a6f4-f80a-4781-b295-a93c530cbea0";
      fsType = "ext4";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/a93fa4ba-e928-41c8-9ec8-1a20551893d5";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/971E-B902";
      fsType = "vfat";
    };


  # Mount Unraid Shares
  fileSystems."/mnt/martin" = {
    device = "//srv-unraid.intra.holypenguin.net/martin";
    fsType = "cifs";
    options = smbMountOpts;
  };

  fileSystems."/mnt/Dokumente" = {
    device = "//srv-unraid.intra.holypenguin.net/martin/Backup/Zeta/latest";
    fsType = "cifs";
    options = smbMountOpts;
  };

  fileSystems."/mnt/Bilder" = {
    device = "//srv-unraid.intra.holypenguin.net/Pictures/latest";
    fsType = "cifs";
    options = smbMountOpts;
  };

  fileSystems."/mnt/Musik" = {
    device = "//srv-unraid.intra.holypenguin.net/Music/latest";
    fsType = "cifs";
    options = smbMountOpts;
  };

  # Nix config
  system.autoUpgrade = {
    enable = true;
    dates = "daily";
  };
  system.stateVersion = "23.05";
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
