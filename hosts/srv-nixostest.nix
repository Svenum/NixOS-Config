{ ... }:

{
  # Import Modules
  imports = [
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

  # Configure Disk
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/9ad867b6-2386-4283-87be-6108191a82f8";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/8405-146C";
      fsType = "vfat";
    };

  # Nix config
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "23.05";
}
