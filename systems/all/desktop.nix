{ pkgs, config, ... }:

{
  services.xserver = {
    enable = true;
    displayManager.sddm = {
      enable = true;
      #theme = "catppuccin-${config.systemConfig.theme.flavour}";
      settings = {
        General = {
          DisplayServer = "wayland";
          InputMethod = "";
          GreeterEnvironment="QT_WAYLAND_SHELL_INTEGRATION=layer-shell";
        };
        Wayland = {
          CompositorCommand = "kwin_wayland";
        };
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
      flavour = [ "${config.systemConfig.theme.flavour}" ];
      accents = [ "${config.systemConfig.theme.accent}" ];
      winDecStyles = [ "modern" ];
    })
    # GTK Themes
    (catppuccin-gtk.override {
      variant = "${config.systemConfig.theme.flavour}";
      accents = [ "${config.systemConfig.theme.accent}" ];
    })
    # Wayland
    weston
  ];

  # Add Catppuccin wallpaper
  environment.etc.wallpaper.source = ../../configs/wallpaper;

  # Enable Numlock
  services.xserver.displayManager.sddm.autoNumlock = true;

  # Enable XWayland
  programs.xwayland.enable = true;
}
