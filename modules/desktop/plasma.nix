{ pkgs, config, themeAccent, themeFlavour, userAttrs, ... }:

let
  # Get GUIUser
  users = (builtins.partition (x: builtins.isString x) (builtins.attrValues (builtins.mapAttrs (name: user: if((if builtins.hasAttr "isGuiUser" user then user.isGuiUser else false)) then "${name}" else null) userAttrs))).right;
in
{
  # Enable SDDM and Plasma
  services.xserver = {
    enable = true;
    displayManager = {
      sddm = {
        enable = true;
        theme = "breeze";
        wayland.enable = true;
      };
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
    kup
    libsForQt5.sddm-kcm
    (
      libsForQt5.konsole.overrideAttrs (old: {
        postInstall = ''
          cp ./config/plasma/konsole/* $out/share/konsole/
        '';
      })
    )
    # Other
    glxinfo
    vulkan-tools
    playerctl
    # Cursor
    catppuccin-cursors.latteTeal
    catppuccin-cursors.mochaTeal
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

  # Enable Numlock
  services.xserver.displayManager.sddm.autoNumlock = true;

  # Enable XWayland
  programs.xwayland.enable = true;
}
