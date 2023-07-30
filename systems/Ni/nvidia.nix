{ pkgs, ... }:

{
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
        (nvidia_x11.override { enableGeforce1050Ti = true; };)
      ];
    };
    nvidia = {
      modesetting.enable = true;
      #powerManagement.enable = true;
      #package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
  };
  services.xserver.videoDrivers = [ "nvidia" ];

  #environment.systemPackages = with pkgs; [
  #  cudaPackages.cudatoolkit
  #];
}
