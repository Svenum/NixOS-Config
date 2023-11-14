{ lib, kbLayout, de, pkgs, ... }:

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

  # load alsaconfig at boot
    systemd.services.alsa-restore = {
      description = "Restore Sound Card State";
      wantedBy = [ "multi-user.target" ];
      unitConfig.RequiresMountsFor = "/var/lib/alsa";
      unitConfig.ConditionVirtualization = "!systemd-nspawn";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.alsa-utils}/sbin/alsactl restore ${./config/asound.conf}";
      };
    };

  # Import desktop environment
  imports = [ ./${de.name}.nix ];

  # Add Catppuccin wallpaper
  environment.etc.wallpaper.source = ./image;
}
