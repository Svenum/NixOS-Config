{ pkgs, config, ... }:

{
  services.xserver = {
    displayManager.lightdm = {
      enable = true;
    };
    windowManager.i3 = {
      enable = true;
    };
  };
  programs.i3lock.enable = true;

  programs.dconf.enable = true;

  sound.enable = true;
  sound.extraConfig = builtins.readFile ../../configs/asound.conf;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # Cursor
    catppuccin-cursors.latteTeal
    catppuccin-cursors.mochaTeal
    # Icons
    (catppuccin-papirus-folders.override {
        flavor = "latte";
        accent = "${config.systemConfig.theme.accent}";
    })
    # KDE Themes
    (catppuccin-kde.override {
      flavour = [ "${config.systemConfig.theme.flavour}" ];
      accents = [ "${config.systemConfig.theme.accent}" ];
      winDecStyles = [ "modern" ];
    })
    # GTK Themes
    (catppuccin-gtk.override {
      variant = "${config.systemConfig.theme.flavour}";
      accents = [ "${config.systemConfig.theme.accent}" ];
    })
  ];

  # Add Catppuccin wallpaper
  environment.etc.wallpaper.source = ../../configs/wallpaper;

  # Enable XWayland
  programs.xwayland.enable = true;
}
