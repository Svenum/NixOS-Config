{ pkgs, config, ... }:

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
      #powerManagement.enable = true;
      #package = config.boot.kernelPackages.nvidiaPackages.beta;
      open = true;
    };
  };
  services.xserver.videoDrivers = [ "nvidia" ];

  # Uncomment if system does boot to terminal
  boot.initrd.kernelModules = [ "nvidia" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
  
  #environment.systemPackages = with pkgs; [
    #cudaPackages.cudatoolkit
    #vaapiVdpau
  #];
}
