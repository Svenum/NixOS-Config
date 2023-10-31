{ pkgs, config, themeFlavour, ... }:

{
  boot.plymouth = {
    enable = true;
    #theme = "bgrt";
    theme = "catppuccin-${themeFlavour}";
    themePackages = with pkgs; [
      (catppuccin-plymouth.override {
        variant = themeFlavour;
      })
      #nixos-bgrt-plymouth
    ];
  };
}
