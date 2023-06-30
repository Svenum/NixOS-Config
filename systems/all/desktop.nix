{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
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

  services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [
    papirus-maia-icon-theme
    (catppuccin-kde.override {
      flavour = [ "mocha" ];
      accents = [ "teal" ];
      winDecStyles = [ "modern" ];
    })
    (catppuccin-kde.override {
      flavour = [ "latte" ];
      accents = [ "teal" ];
      winDecStyles = [ "modern" ];
    })
    (catppuccin-gtk.override {
      flavour = [ "mocha" ];
      accents = [ "teal" ];
      winDecStyles = [ "modern" ];
    })
    (catppuccin-gtk.override {
      flavour = [ "latte" ];
      accents = [ "teal" ];
      winDecStyles = [ "modern" ];
    })
  ];
}
