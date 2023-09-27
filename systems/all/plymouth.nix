{ pkgs, config, ... }:

{
  boot.plymouth = {
    enable = true;
    #theme = "bgrt";
    theme = "catppuccin-mocha";
    themePackages = with pkgs; [
      (catppuccin-plymouth.override {
        variant = "${config.systemConfig.theme.flavour}";
      })
      #nixos-bgrt-plymouth
    ];
  };
}
