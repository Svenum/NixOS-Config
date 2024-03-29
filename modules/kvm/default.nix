{ lib, pkgs, settings, config, ... }:

let
  script = ''
    #!${pkgs.bash}
    gpu="0000:03:00.0"
    aif="0000:03:00.1"

    gpu_driver=$(lspci -s $gpu -k | grep "Kernel driver in use:" | awk '{print $NF}')
    aif_driver=$(lspci -s $aif -k | grep "Kernel driver in use:" | awk '{print $NF}')

    if [[ $gpu_driver == "vfio-pci" ]]; then
      echo "Switching GPU to amdgpu!"
      echo $gpu > /sys/bus/pci/drivers/vfio-pci/unbind
      echo $gpu > /sys/bus/pci/drivers/amdgpu/bind
    elif [[ $gpu_driver == "amdgpu" ]]; then 
      echo "Switching GPU to vfio-pci!"
      echo $gpu > /sys/bus/pci/drivers/amdgpu/unbind
      echo $gpu > /sys/bus/pci/drivers/vfio-pci/bind
    else
      echo "GPU: Driver $gpu_driver not known!"
      exit 1
    fi

    if [[ $aif_driver == "vfio-pci" ]]; then
      echo "Switching audio interface to snd_hda_intel!"
      echo $aif > /sys/bus/pci/drivers/vfio-pci/unbind
      echo $aif > /sys/bus/pci/drivers/snd_hda_intel/bind
    elif [[ $aif_driver == "snd_hda_intel" ]]; then 
      echo "Switching audio interface to vfio-pci!"
      echo $aif > /sys/bus/pci/drivers/snd_hda_intel/unbind
      echo $aif > /sys/bus/pci/drivers/vfio-pci/bind
    else
      echo "audio interface: Driver $aif_driver not known!"
      exit 1
    fi
  '';
in
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
