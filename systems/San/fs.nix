{ config, ... }:

{
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
      automount_opts = ["noauto" "x-systemd.idle-timeout=60" "x-systemd.device-timeout=5s" "x-systemd.mount-timeout=5s"];
    in automount_opts ++ [ "uid=sven" "gid=users" "mfsymlinks" "soft" "rsize=8192" "wsize=8192" "users" "user" "_netdev" "credentials=${config.home-manager.users.sven.home.homeDirectory}/.smb"];
  };

  swapDevices = [ ];
}
