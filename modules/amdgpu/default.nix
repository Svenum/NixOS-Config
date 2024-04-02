{ pkgs, lib, ... }:

with lib;
{
  # Enable opengl
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
      amdvlk
    ];
    extraPackages32 = with pkgs; [
      driversi686Linux.amdvlk
    ];
  };

  boot.kernelPackages = mkForce (pkgs.linuxKernel.packagesFor
  (pkgs.linuxKernel.kernels.linux_6_6.override {
    structuredExtraConfig = {
      DEVICE_PRIVATE = kernel.yes;
      KALLSYMS_ALL = kernel.yes;
    };
  }));

  services.xserver.videoDrivers = ["amdgpu-pro"];

  # install needed tools
  environment.systemPackages = with pkgs; [
    clinfo
    nvtopPackages.amd
  ];
}
