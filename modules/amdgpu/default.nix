{ pkgs, ... }:

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

  # install needed tools
  environment.systemPackages = with pkgs; [
    clinfo
    nvtopPackages.amd
  ];
}
