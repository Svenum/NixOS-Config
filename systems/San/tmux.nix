{ pkgs, ... }:

let
  catppuccin-tmux = pkgs.callPackage ../../custom-nixpkgs/catppuccin-tmux {};
{
  programs.tmux = {
    extraConfig = ''
      set -g mouse on
      set -g @catppuccin_flavour 'latte'
      set -g @catppuccin_date_time "%d.%m.%Y %H:%M"
      set -g @catppuccin_powerline_icons_theme_enabled on
      set -g @catppuccin_l_left_separator ""
      set -g @catppuccin_l_right_separator ""
      set -g @catppuccin_r_left_separator ""
      set -g @catppuccin_r_right_separator ""

      run-shell ${catppuccin-tmux}/share/tmux-plugins/catppuccin/catppuccin.tmux
    '';
  };
}
