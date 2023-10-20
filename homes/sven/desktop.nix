{ pkgs, ... }:

{
  gtk.theme.package = with pkgs; [
    # GTK Themes
    (catppuccin-gtk.override {
      variant = "${config.systemConfig.theme.flavour}";
      accents = [ "${config.systemConfig.theme.accent}" ];
    })
  ];
}
