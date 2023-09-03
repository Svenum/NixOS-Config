{ config, pkgs, lib, ... }:

{
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
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        amdgpuBusId = "PCI:5:0:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };
  services.xserver.videoDrivers = [ "nvidia" "amdgpu" ];

  specification = {
    performance-mode.configuration = {
      system.nixos.tags = [ "performance-mode" ];
      hardware.nvidia = {
        prime = {
          sync.enable = lib.mkForce true;
        };
      };
    };
  };
}
