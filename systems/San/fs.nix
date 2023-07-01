{ ... }:

{
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/ac15d02e-692d-49ed-be80-17764460bc84";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/c29aff97-741f-4515-9617-29384227a21d";
      fsType = "btrfs";
      options = [ "subvol=@home" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/EA04-C389";
      fsType = "vfat";
    };

  swapDevices = [ ];
}
