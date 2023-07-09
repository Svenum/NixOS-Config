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
  programs.dconf.enable = true;

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
    catppuccin-cursors
    catppuccin-papirus-folders
    (catppuccin-kde.override {
      flavour = [ "mocha" "latte" ];
      accents = [ "teal" ];
      winDecStyles = [ "modern" ];
    })
    (catppuccin-gtk.override {
      variant = [ "mocha" "latte" ];
      accents = [ "teal" ];
    })
    #(catppuccin-gtk.override {
    #  variant = "latte";
    #  accents = [ "teal" ];
    #})
  ];

  # Enable Numlock
  services.xserver.displayManager.sddm.autoNumlock = true;
}
