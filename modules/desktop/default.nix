{ lib, settings, pkgs, ... }:

{
  # Configure xserver keyboard
  services.xserver.xkb = {
    layout = settings.kbLayout;
    variant = "";
  };

  # Configure sound
  sound.enable = true;
  #sound.extraConfig = builtins.readFile ./config/asound.conf;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # load alsaconfig at boot
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="sound", KERNEL=="controlC*", KERNELS!="card*", TEST="${pkgs.alsa-utils}", TEST="/var/lib/alsa/asound.state, GOTO="alsa_restore_go", GOTO="alsa_restore_end"

    LABEL="alsa_restore_go"
    TEST!="/etc/alsa/state-daemon.conf",RUN+="${pkgs.alsa-utils}/bin/alsactl restore $attr{device/number}"
    TEST=="/etc/alsa/state-daemon.conf",RUN+="${pkgs.alsa-utils}/bin/alsactl nrestore $attr{device/number}"

    LABEL="alsa_restore_end"
    '';

  # Import desktop environment
  imports = [ ./${settings.de.name}.nix ];

  # Add Catppuccin wallpaper
  environment.etc.wallpaper.source = ./image;
}
