{ ... }:

{
  home.file = {
    # Zsh
    ".zshrc".source = ../../config_files/zshrc;
    ".p10k.zsh".source = ../../config_files/p10k.zsh;
    # KDE 
    ".config/kdedefaults/ksplashrc".source = ../../config_files/config/kdedefaults/ksplashrc;
    ".config/kdedefaults/kscreenlockerrc".source = ../../config_files/config/kdedefaults/kscreenlockerrc;
    ".config/kdedefaults/kdeglobals".source = ../../config_files/config/kdedefaults/kdeglobals;
    ".config/kdedefaults/plasmarc".source = ../../config_files/config/kdedefaults/plasmarc;
    ".config/kcminputrc".source = ../../config_files/config/kcminputrc;
    ".config/kwinrc".source = ../../config_files/config/kwinrc;
    ".config/kdeglobals".source = ../../config_files/config/kdeglobals;
    # Latte
    ".config/latte/custom_layout.layout.latte".source = ../../config_files/config/latte/Manjaro.layout.latte
    # Flatapk overrides
    ".local/share/flatpak/overrides".source = ../../config_files/local/share/flatpak/overrides;
  };
}
