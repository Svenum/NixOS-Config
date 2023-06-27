{ lib, ... }:

{
  boot.initrd = {
    availableKernelModules = [ "nvme" "xhci_pci" "ahci" "sd_mod" ];
    kernelModules = [];
  };
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;  
}
