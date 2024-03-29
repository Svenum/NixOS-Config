{ lib, pkgs, settings, config, ... }:

let
  script = ''
    #!${pkgs.bash}
    list="${lib.strings.concatMapStrings (x: " " + x) settings.pciPassthrough.isolatedDevices}"

    for item in $list; do                                                           
      driver_in_use=$(lspci -d $item -k | grep "Kernel driver in use:" | awk '{print $NF}')
      kernel_module=$(lspci -d $item -k | grep "Kernel modules:" | awk '{print $NF}')
      pci_slot=$(lspci -d $item -D | awk '{print $1}')

      if [[ $driver_in_use == $kernel_module ]]; then
        echo "Bind $pci_slot to vfio-pci!"
        echo $pci_slot > /sys/bus/pci/drivers/$kernel_module/unbind
        echo $pci_slot > /sys/bus/pci/drivers/vfio-pci/bind
      elif [[ $driver_in_use == "vifo-pci" ]]; then
        echo "Bind $pci_slot to $kernel_module!"
        echo $pci_slot > /sys/bus/pci/drivers/vfio-pci/unbind
        echo $pci_slot > /sys/bus/pci/drivers/$kernel_module/bind
      elif [[ $driver_in_use == "" ]]; then
        echo "Bind $pci_slot to $kernel_module"
        echo $pci_slot > /sys/bus/pci/drivers/$kernel_module/bind
      else
        echo "Something is wront with $pci_slot. It uses not $kernel_module or vfio-pci!"
        exit 1
      fi
    done
  '';
  toggle_vfio = lib.mkIf settings.pciPassthrough.enable (
    pkgs.writeShellScriptBin "toggle_vfio" script
  );
in
{
  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };
  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    libguestfs
    toggle_vfio
  ];

  security.wrappers."toggle_vfio" = {
    owner = "root";
    group = "root";
    setuid = true;
    source = "${toggle_vfio}/bin/toggle_vfio";
    permissions = "g+rx,o+rx";
  };

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
