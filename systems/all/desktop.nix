{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    displayManager.sddm = {
      enable = true;
      settings = {
        General = {
          DisplayServer = "wayland";
          GreeterEnvironment = "QT_WAYLAND_SHELL_INTEGRATION=layer-shell";
        };
        #Wayland = {
        #  CompositorCommand = "kwin_wayland --drm --no-lockscreen --no-global-shortcuts --locale1";
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
        accent = "teal";
    })
    # KDE Themes
    (catppuccin-kde.override {
      flavour = [ "mocha" "latte" ];
      accents = [ "teal" ];
      winDecStyles = [ "modern" ];
    })
    # GTK Themes
    (catppuccin-gtk.override {
      variant = "mocha";
      accents = [ "teal" ];
    })
    (catppuccin-gtk.override {
      variant = "latte";
      accents = [ "teal" ];
    })
  ];

  # Add Catppuccin wallpaper
  environment.etc.wallpaper.source = ../../configs/wallpaper;

  # Enable Numlock
  services.xserver.displayManager.sddm.autoNumlock = true;

  # Enable XWayland
  programs.xwayland.enable = true;
}
