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
      run-shell ${pkgs.tmuxPlugins.catppuccin}/share/catppuccin/tmux/catppuccin.tmux
      set -g @catppuccin_powerline_icons_theme_enabled on
    '';
    plugins = with pkgs.tmuxPlugins; [
      catppuccin
      better-mouse-mode
    ];
  };
}
