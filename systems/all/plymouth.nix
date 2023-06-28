{ pkgs, ... }:

{
  boot.plymouth = {
    enable = true;
    theme = "bgrt";
    themePackages = with pkgs; [
      nixos-bgrt-plymouth
    ];
  };
}
