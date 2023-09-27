{ pkgs, ... }:

{
  programs.tmux = {
    extraConfig = ''
      set -g mouse on
      set -g @catppuccin_flavour 'latte'
      set -g @catppuccin_date_time "%d.%m.%Y %H:%M"
      set -g @catppuccin_status_modules_right "application directory date_time "
      set -g @catppuccin_powerline_icons_theme_enabled on
      #set -g @catppuccin_window_left_separator ""
      #set -g @catppuccin_window_right_separator ""
      set -g @catppuccin_status_left_separator ""
      set -g @catppuccin_status_right_separator ""

      run-shell ${pkgs.tmuxPlugins.catppuccin}/share/tmux-plugins/catppuccin/catppuccin.tmux
    '';
  };
}
