{ pkgs, ... }:

{
  programs.tmux = {
    extraConfig = ''
      set -g mouse on
      set -g @catppuccin_flavour 'latte'
      set -g @catppuccin_date_time_text "%d.%m.%Y %H:%M"
      set -g @catppuccin_status_modules "application user date_time"
      
      set -g @catppuccin_window_right_separator " "
      set -g @catppuccin_window_middle_separator "█"
      
      set -g @catppuccin_status_left_separator " "
      set -g @catppuccin_status_right_separator "█"

      set -g @catppuccin_window_current_text "#{pane_current_path}"
      set -g @catppuccin_window_number_position "right"

      run-shell ${pkgs.tmuxPlugins.catppuccin}/share/tmux-plugins/catppuccin/catppuccin.tmux
    '';
  };
}
