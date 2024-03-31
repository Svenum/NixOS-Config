{ pkgs, config, settings, lib, ... }:

let
  # Get GUIUser
  users = (builtins.partition (x: builtins.isString x) (builtins.attrValues (builtins.mapAttrs (name: user: if((if builtins.hasAttr "isGuiUser" user then user.isGuiUser else false)) then "${name}" else null) settings.userAttrs))).right;

  # Plasmoids
  plasma-applet-shutdown_or_switch = pkgs.callPackage ../../custom-nixpkgs/plasma-applet-shutdown_or_switch {};
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
        wayland = {
          enable = true;
          compositor = "kwin";
        };
        autoNumlock = true;
      };
      defaultSession = lib.mkIf ( if builtins.hasAttr "waylandDefault" settings.de then false else true ) "plasmax11";
    };
  };
  services.desktopManager.plasma6 = {
    enable = true;
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
    # KDE BACKUP wait for qt6 implementation
    #bup
    #kup
    # GUI Tools
    kdePackages.skanlite
    kdePackages.sddm-kcm
    # Add Konsole profiles and colorshcemes
    konsole-catppuccin
    # Add plasmoids
    plasma-applet-shutdown_or_switch
    # Other
    glxinfo
    vulkan-tools
    playerctl
    wayland-utils
    aha

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
  programs.kdeconnect = {
    enable = true;
    package = lib.mkForce pkgs.kdePackages.kdeconnect-kde;
  };

  # Enable XWayland
  programs.xwayland.enable = true;
}
