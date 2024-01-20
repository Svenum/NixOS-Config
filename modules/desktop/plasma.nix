{ pkgs, config, themeAccent, themeFlavour, userAttrs, de, lib, ... }:

let
  # Get GUIUser
  users = (builtins.partition (x: builtins.isString x) (builtins.attrValues (builtins.mapAttrs (name: user: if((if builtins.hasAttr "isGuiUser" user then user.isGuiUser else false)) then "${name}" else null) userAttrs))).right;

  # Plasmoids
  plasma-applet-shutdownorswitch = pkgs.callPackage ../../custom-nixpkgs/plasma-applet-shutdownorswitch {};
  plasma-applet-betterinlineclock = pkgs.callPackage ../../custom-nixpkgs/plasma-applet-betterinlineclock {};
  konsole-catppuccin = pkgs.callPackage ../../custom-nixpkgs/konsole-catppuccin {};

  cursor1 = pkgs.callPackage "${themeAccent}";
  cursor2 = pkgs.callPackage "${themeAccent}";
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
      defaultSession = lib.mkIf ( if builtins.hasAttr "waylandDefault" de then de.waylandDefault else false ) "plasmawayland";
    };
    desktopManager.plasma5.enable = true;
  };

  # Disable packages
  environment.plasma5.excludePackages = with pkgs; [
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
    # Cursor
    catppuccin-cursors.latteTeal
    catppuccin-cursors.mochaTeal
    catppuccin-cursors.latteRed
    catppuccin-cursors.mochaRed
    catppuccin-cursors.lattePeach
    catppuccin-cursors.mochaPeach
    # Icons
    (catppuccin-papirus-folders.override {
      flavor = "latte";
      accent = themeAccent;
      })
    # KDE Themes
    (catppuccin-kde.override {
      flavour = [ themeFlavour ];
      accents = [ themeAccent ];
      winDecStyles = [ "modern" ];
    })
    # GTK Themes
    (catppuccin-gtk.override {
      variant = themeFlavour;
      accents = [ themeAccent ];
    })
  ];

  # Enable partitionmanager
  programs.partition-manager.enable = true;

  # Enable KDEConnect
  programs.kdeconnect.enable = true;

  # Enable XWayland
  programs.xwayland.enable = true;
}
