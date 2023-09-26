{ pkgs, ... }:

{
  boot.plymouth = {
    enable = true;
    #theme = "bgrt";
    theme = "catppuccin-mocha";
    themePackages = with pkgs; [
      catppuccin-plymouth
      #nixos-bgrt-plymouth
    ];
  };
}
