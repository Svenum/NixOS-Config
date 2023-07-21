{ ... }:

{
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
      device = "/dev/disk/by-uuid/7526339f-7828-43e7-81e5-f19eec22f9e5";
      fsType = "btrfs";
      options = ["subvol=/@games" "auto" "defaults" "discard=async" "ssd"];
    };

    fileSystems."/home/sven/Games/HDD" = {
      device = "/dev/disk/by-uuid/6cd63ba0-39fc-40a6-9086-8ab45fb943d0";
      fsType = "btrfs";
      options = [ "subvol=/@games" "auto" "defaults" ];
    };

    fileSystems."/mnt/sven" = {
      device = "//srv-unraid.intra.holypenguin.net/sven";
      fsType = "cifs";
      options = let
        automount_opts = ["x-systemd.automount" "noauto" "echo_interval=10" "x-systemd.idle-timeout=10" "x-systemd.device-timeout=5s" "x-systemd.mount-timeout=5s"];
      in automount_opts ++ [ "uid=sven" "gid=users" "mfsymlinks" "soft" "rsize=8192" "wsize=8192" "_netdev" "credentials=${config.home-manager.users.sven.home.homeDirectory}/.smb"];
    };
  swapDevices = [ ];
}
