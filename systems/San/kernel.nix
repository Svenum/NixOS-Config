{ ... }:

{
  boot.initrd = {
    availableKernelModules = [ "nvme" "xhci_pci" "ahci" "sd_mod" ];
    kernelModules = [];
  };
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [];
}
