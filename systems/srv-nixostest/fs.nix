{ ... }:

{
  fileSystems."/" =
    { 
      label = "NixOS";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { 
      label = "EFI";
      fsType = "vfat";
    };

  swapDevices = [ ];
}
