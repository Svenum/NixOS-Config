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
      set @catppuccin_host "on"
      set @catppuccin_user "on"
      set @catppuccin_date_time "%d-%m-%Y %H:%M"
      set @catppuccin_powerline_icons_theme_enabled "on"
      set @catppuccin_l_left_separator ""
      set @catppuccin_l_right_separator ""
      set @catppuccin_r_left_separator ""
      set @catppuccin_r_right_separator ""

      run-shell ${pkgs.tmuxPlugins.catppuccin}/share/tmux-plugins/catppuccin/catppuccin.tmux
    '';
    plugins = with pkgs.tmuxPlugins; [
      catppuccin
    ];
  };
}
