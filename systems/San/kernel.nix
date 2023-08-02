{ config, ... }:

{
  boot.initrd = {
    availableKernelModules = [ "nvme" "xhci_pci" "ahci" "sd_mod" ];
    kernelModules = [ "nvidia" ];
  };
  boot.kernelModules = [ "kvm-amd" "sg" ];
  boot.kernelParams = [ "amd_iommu=pt" "vt.default_red=239,210,64,223,30,234,23,108,172,210,64,223,30,234,23,76" "vt.default_grn=241,15,160,142,102,118,146,111,176,15,160,142,102,118,146,79" "vt.default_blu=245,57,43,29,245,203,153,133,190,57,43,29,245,203,153,105" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
}
