{ pkgs, config, ... }:

{
  services.xserver = {
    enable = true;
    displayManager = {
      setupCommands = ''
        echo -e '[Genearl]\nbackground=/etc/wallpaper/catppuccin-${config.systemConfig.theme.flavour}.jpg' > ${pkgs.sddm}/share/sddm/themes/${config.services.xserver.displayManager.sddm.theme}/theme.conf.user
      '';
      sddm = {
        enable = true;
        theme = "breeze";
        settings = {
          General = {
            GreeterEnvironments = "QT_SCREEN_SCALE_FACTOR=2,QT_FONT_DPI=192";
            DisplayServer = "wayland";
          };
        };
      };
    };
    desktopManager.plasma5.enable = true;
  };
  environment.plasma5.excludePackages = with pkgs; [
    oxygen
    elisa
    khelpcenter
    kwrited
  ];   
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

  # Enable Numlock
  services.xserver.displayManager.sddm.autoNumlock = true;

  # Enable XWayland
  programs.xwayland.enable = true;
}
