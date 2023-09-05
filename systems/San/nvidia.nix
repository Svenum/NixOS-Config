{ config, pkgs, lib, ... }:

{
  hardware.nvidiaOptimus.disable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  specialisation = {
  enable-nvidia.configuration = {
    system.nixos.tags = [ "enable-nvidia" ];
    hardware = lib.mkForce {
      nvidiaOptimus.disable = false;
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
            enableOffloadCmd = true;
          };
          reverseSync.enable = true;
          amdgpuBusId = "PCI:5:0:0";
          nvidiaBusId = "PCI:1:0:0";
        };
      };
    };
    services.xserver.videoDrivers = lib.mkForce [ "nvidia" "amdgpu" ];
    };
  };
}
