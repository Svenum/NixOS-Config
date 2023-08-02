{ modulesPath, pkgs, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "sr_mod" ];
  boot.kernelModules = [ "kvm-intel" "sg" ];
  boot.kernelParams = ["mds=full,nosmt" "efi=runtime" "iommu=pt" "intel_iommu=on" ];

}
