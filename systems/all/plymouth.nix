{ pkgs, ... }:

{
  boot.plymouth = {
    enable = true;
    #theme = "bgrt";
    theme = "catppuccin";
    themePackages = with pkgs; [
      catppuccin-plymouth
      #nixos-bgrt-plymouth
    ];
  };
}
