{ modulesPath, pkgs, ... }:

let
  home-backup = pkgs.writeShellScriptBin "home-backup" (builtins.readFile ../scripts/home-backup.sh);
in
{
  # Import Modules
  imports = [
    # Change kernel settings
    (modulesPath + "/profiles/qemu-guest.nix")

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
    ../modules/rdp
    ../modules/printer
    ../modules/cliTools
    ../modules/network
  ];

  # Install Custom Scripts and system specific packages
  environment.systemPackages = with pkgs; [
      home-backup
  ];

  # Enable fwupd
  services.fwupd.enable = true;

  # Configure Disk
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/9ad867b6-2386-4283-87be-6108191a82f8";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/8405-146C";
      fsType = "vfat";
    };

  boot.initrd.availableKernelModules = [ "uhci_hcd" "ehci_pci" "ahci" "virtio_pci" "sr_mod" "virtio_blk" ];
  boot.kernelModules = [ "kvm-amd" "vt.default_red=30,243,166,249,137,245,148,186,88,243,166,249,137,245,148,166" "vt.default_grn=30,139,227,226,180,194,226,194,91,139,227,226,180,194,226,173" "vt.default_blu=46,168,161,175,250,231,213,222,112,168,161,175,250,231,213,200" ];

  # Nix config
  system.stateVersion = "23.11";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
