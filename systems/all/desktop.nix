{ pkgs, config, ... }:

{
  services.xserver = {
    enable = true;
    displayManager.sddm = {
      enable = true;
      theme = "catppuccin-mocha";
      settings = {
        General = {
          #DisplayServer = "wayland";
          InputMethod = "";
          #GreeterEnvironment = "QT_WAYLAND_SHELL_INTEGRATION=layer-shell";
        };
        #Wayland = {
        #  CompositorCommand = "${pkgs.libsForQt5.kwin}/bin/kwin_wayland --drm --no-lockscreen --no-global-shortcuts --locale1";
        #};
      };
    };
    desktopManager.plasma5 = {
      enable = true;
    };
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
      flavour = [ "mocha" "latte" ];
      accents = [ "${config.systemConfig.theme.accent}" ];
      winDecStyles = [ "modern" ];
    })
    # GTK Themes
    (catppuccin-gtk.override {
      variant = "mocha";
      accents = [ "${config.systemConfig.theme.accent}" ];
    })
    (catppuccin-gtk.override {
      variant = "latte";
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
