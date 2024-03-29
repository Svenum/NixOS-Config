{ lib, pkgs, settings, config, ... }:

{
  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };
  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    libguestfs
  ];

  boot.extraModprobeConfig = lib.mkIf settings.pciPassthrough.enable ''
    options vfio_pci ids=${lib.strings.concatMapStrings (x: "," + x) settings.pciPassthrough.isolatedDevices}
    options vfio_iommu_type1 allow_unsafe_interrupts=1
    options vfio_pci disable_vga=1
    options vfio_pci enable_sriov=1
    options kvm ignore_msrs=1
    options kvm report_ignored_msrs=0
  '';

  boot.kernelModules = [ "vfio" "vfio_iommu_type1" "vfio_pci" "vfio_virqfd" ];
  boot.kernelParams = [ "iommu=pt" ] ++ (if config.hardware.cpu.amd.updateMicrocode == true then [ "amd_iommu=on" "kvm_amd.avic=1" "kvm_amd.npt=1" ] else (if config.hardware.cpu.intel.updateMicrocode == true then [ "intel_iommu=on" ] else []));
}
