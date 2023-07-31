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
      package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
    };
  };
  services.xserver.videoDrivers = [ "nvidia" ];

  #environment.systemPackages = with pkgs; [
    #cudaPackages.cudatoolkit
    #vaapiVdpau
  #];
}
