{ config, pkgs, ... }:

{
  hardware = {
    #opengl = {
    #  enable = true;
    #  driSupport = true;
    #  driSupport32Bit = true;
    #  extraPackages = with pkgs; [
    #    vaapiVdpau
    #    libvdpau-va-gl
    #  ];
    #  extraPackages32 = with pkgs.pkgsi686Linux; [
    #    vaapiVdpau
    #  ];
    #};
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        reverseSync.enable = true;
        amdgpuBusId = "PCI:5:0:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };
  services.xserver.videoDrivers = [ "nvidia" ];
}
