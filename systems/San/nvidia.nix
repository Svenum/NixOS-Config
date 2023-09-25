{ config, pkgs, lib, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];
  boot.kernelParams = [ "module_blacklist=amdgpu,nouveau" ];

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        vaapiVdpau
      ];
    };
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = true;
      prime = {
        offload = {
          enableOffloadCmd = true;
        };
        reverseSync.enable = true;
        amdgpuBusId = "PCI:5:0:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };
}
