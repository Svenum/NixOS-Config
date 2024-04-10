{ lib, pkgs, settings, config, ... }:

let
  toggle_gpu = (import ./script/switch_amdgpu.nix {dgpuPCI = settings.pciPassthrough.isolatedDevices; inherit lib; inherit pkgs; });
in
{

  # Import required modules
  imports = [
    ./lookingGlass.nix
    ./virtManager.nix
  ];

  # Prepare Kernel
  boot.extraModprobeConfig = lib.mkIf settings.pciPassthrough.enable or false ''
    options vfio_pci ids=${lib.strings.concatMapStrings (x: "," + x) settings.pciPassthrough.isolatedDevices}
    options kvm ignore_msrs=1
    options kvm report_ignored_msrs=0
    ${if config.hardware.cpu.amd.updateMicrocode then "options kvm_amd nested=1" else ""}
  '';

  environment.systemPackages = [ toggle_gpu ];

  security.sudo.extraRules = [{
    groups = [
      "kvm"
      "libvirtd"
    ];
    runAs = "ALL:ALL";
    commands = [{
      command = toggle_gpu + /bin/toggle_gpu;
      options = [ "NOPASSWD" ];
    }];
  }];

  boot.kernelModules = [ "vfio" "vfio_iommu_type1" "vfio_pci" "pci_stub" ]
    ++ lib.lists.optionals config.hardware.cpu.amd.updateMicrocode [ "kvm-amd" ];
  boot.kernelParams = [ "iommu=pt" ]
    ++ lib.lists.optionals config.hardware.cpu.amd.updateMicrocode [ "amd_iommu=on" "kvm_amd.avic=1" "kvm_amd.npt=1"  ]
    ++ lib.lists.optionals config.hardware.cpu.intel.updateMicrocode [ "intel_iommu=on" ];

    boot.initrd.kernelModules = [
      "vfio"
      "vfio-pci"
    ]
    ++ lib.lists.optionals config.hardware.cpu.amd.updateMicrocode [ "amdgpu" ];
}
