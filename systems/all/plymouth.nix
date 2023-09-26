{ pkgs, ... }:

{
  boot.plymouth = {
    enable = true;
    #theme = "bgrt";
    theme = "catppuccin-mocha";
    themePackages = with pkgs; [
      (catppuccin-plymouth.override {
        variant = "mocha";
      })
      #nixos-bgrt-plymouth
    ];
  };
}
