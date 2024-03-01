{ pkgs, config, settings, lib, ... }:

let
  # Get GUIUser
  users = (builtins.partition (x: builtins.isString x) (builtins.attrValues (builtins.mapAttrs (name: user: if((if builtins.hasAttr "isGuiUser" user then user.isGuiUser else false)) then "${name}" else null) settings.userAttrs))).right;

  # Plasmoids
  plasma-applet-shutdownorswitch = pkgs.callPackage ../../custom-nixpkgs/plasma-applet-shutdownorswitch {};
  plasma-applet-betterinlineclock = pkgs.callPackage ../../custom-nixpkgs/plasma-applet-betterinlineclock {};
  konsole-catppuccin = pkgs.callPackage ../../custom-nixpkgs/konsole-catppuccin {};

  cursor1 = pkgs.callPackage "${settings.theme.accent}";
  cursor2 = pkgs.callPackage "${settings.theme.accent}";
in
{
  # Enable SDDM and Plasma
  services.xserver = {
    enable = true;
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
        autoNumlock = true;
      };
      defaultSession = lib.mkIf ( if builtins.hasAttr "waylandDefault" settings.de then settings.de.waylandDefault else false ) "plasma";
    };
    desktopManager.plasma6 = {
      enableQt5Integration = false;
      enable = true;
    };
  };

  # Disable packages
  environment.plasma6.excludePackages = with pkgs; [
    oxygen
    elisa
    khelpcenter
    kwrited
  ];   
  programs.dconf.enable = true;

  # Install Needed packages
  environment.systemPackages = with pkgs; [
    # Bup for kup
    bup
    # GUI Tools
    kate
    libsForQt5.skanlite
    kup
    libsForQt5.sddm-kcm
    # Add Konsole profiles and colorshcemes
    konsole-catppuccin
    # Add plasmoids
    plasma-applet-shutdownorswitch
    plasma-applet-betterinlineclock
    # Other
    glxinfo
    vulkan-tools
    playerctl
    wayland-utils

    # Icons
    (catppuccin-papirus-folders.override {
      flavor = "latte";
      accent = settings.theme.accent;
      })
    # KDE Themes
    (catppuccin-kde.override {
      flavour = [ settings.theme.flavour ];
      accents = [ settings.theme.accent ];
      winDecStyles = [ "modern" ];
    })
    # GTK Themes
    (catppuccin-gtk.override {
      variant = settings.theme.flavour;
      accents = [ settings.theme.accent ];
    })
  ] ++ (if settings.theme.accent == "teal" then [catppuccin-cursors.latteTeal catppuccin-cursors.mochaTeal] else
        if settings.theme.accent == "red" then [catppuccin-cursors.latteRed catppuccin-cursors.mochaRed] else
        if settings.theme.accent == "peach" then [catppuccin-cursors.lattePeach catppuccin-cursors.mochaPeach] else []);

  # Enable partitionmanager
  programs.partition-manager.enable = true;

  # Enable KDEConnect
  programs.kdeconnect.enable = true;

  # Enable XWayland
  programs.xwayland.enable = true;
}
