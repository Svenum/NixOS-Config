{ config, pkgs, ... }:

{
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    nvidia = {
      modesetting.enable = true;
      #powerManagement.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
  };
  services.xserver.videoDrivers = [ "nvidia" ];

  #environment.systemPackages = with pkgs; [
  #  cudaPackages.cudatoolkit
  #];
}
