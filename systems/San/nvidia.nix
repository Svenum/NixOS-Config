{ config, pkgs, lib, ... }:

{
  hardware.bumblebee = {
    enable = true;
  };
  #services.xserver.videoDrivers = [ "nvidia" ];
  #boot.extraModprobeConfig = ''
  #  blacklist vga16fb
  #  blacklist nouveau
  #  blacklist rivafb
  #  blacklist nvidiafb
  #  blacklist rivatv
  #'';

  #hardware = {
  #  opengl = {
  #    enable = true;
  #    driSupport = true;
  #    driSupport32Bit = true;
  #    extraPackages = with pkgs; [
  #      vaapiVdpau
  #      libvdpau-va-gl
  #    ];
  #    extraPackages32 = with pkgs.pkgsi686Linux; [
  #      vaapiVdpau
  #    ];
  #  };
  #  nvidia = {
  #    nvidiaSettings = true;
  #    open = false;
  #    modesetting.enable = true;
  #    powerManagement.enable = true;
  #    powerManagement.finegrained = true;
  #    prime = {
  #      offload = {
  #        enableOffloadCmd = true;
  #      };
  #      reverseSync.enable = true;
  #      amdgpuBusId = "PCI:5:0:0";
  #      nvidiaBusId = "PCI:1:0:0";
  #    };
  #  };
  #};
}
