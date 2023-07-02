{ ... }:

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

  swapDevices = [ ];
}
