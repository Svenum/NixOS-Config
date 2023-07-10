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
    '';
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g catppuccin_powerline_icons_theme_enabled on
          set -g @catppuccin_l_left_separator ""
          set -g @catppuccin_l_right_separator ""
          set -g @catppuccin_r_left_separator ""
          set -g @catppuccin_r_right_separator ""
        '';
      }
      better-mouse-mode
    ];
  };
}
