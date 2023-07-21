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

  swapDevices = [ ];
}
