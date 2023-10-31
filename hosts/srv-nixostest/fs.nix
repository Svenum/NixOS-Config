{ ... }:

{
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/9ad867b6-2386-4283-87be-6108191a82f8";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/8405-146C";
      fsType = "vfat";
    };

  swapDevices = [ ];
}
