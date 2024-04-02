{ pkgs, lib, ... }:

{
  # Enable opengl
  #hardware.opengl = {
  #  enable = true;
  #  driSupport = true;
  #  driSupport32Bit = true;
  #  extraPackages = with pkgs; [
  #    rocmPackages.clr.icd
  #    amdvlk
  #  ];
  #  extraPackages32 = with pkgs; [
  #    driversi686Linux.amdvlk
  #  ];
  #};

  services.xserver.videoDrivers = ["amdgpu-pro"];

  #boot.kernelPackages = lib.mkForce (pkgs.linuxKernel.packagesFor
  #(pkgs.linuxKernel.kernels.linux_6_8.override {
  #  structuredExtraConfig = {
  #    DEVICE_PRIVATE = lib.kernel.yes;
  #    KALLSYMS_ALL = lib.kernel.yes;
  #  };
  #}));


  # install needed tools
  environment.systemPackages = with pkgs; [
    clinfo
    nvtopPackages.amd
  ];
}
