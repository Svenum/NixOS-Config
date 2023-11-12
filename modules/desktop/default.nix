{ lib, kbLayout, de, ... }:

{
  # Configure xserver keyboard
  services.xserver = {
    layout = kbLayout;
    xkbVariant = "";
  };

  # Configure sound
  sound.enable = true;
  sound.extraConfig = builtins.readFile ./config/asound.conf;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Import desktop environment
  imports = [ ./${de.name}.nix ];

  # Add Catppuccin wallpaper
  environment.etc.wallpaper.source = ./image;
}
