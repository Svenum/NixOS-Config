{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    newSession = true;
    keyMode = "vi";
    historyLimit = 5000;
    clock24 = true;
    terminal = "screen-256color";
    extraConfig = ''
      set -g mouse on
      set -g @catppuccin_host "on"
      set -g @catppuccin_user "on"
      set -g @catppuccin_date_time "%d-%m-%Y %H:%M"
      set -g @catppuccin_powerline_icons_theme_enabled "on"
      set -g @catppuccin_l_left_separator ""
      set -g @catppuccin_l_right_separator ""
      set -g @catppuccin_r_left_separator ""
      set -g @catppuccin_r_right_separator ""
    '';
    plugins = with pkgs.tmuxPlugins; [
      catppuccin
    ];
  };
}
