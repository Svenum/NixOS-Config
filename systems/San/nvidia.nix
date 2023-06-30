{ config, ... }:

{
  hardware = {
    #opengl.enable = true;
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
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
  services.xserver.videoDrivers = [ "nvidia", "amdgpu" ];
}
