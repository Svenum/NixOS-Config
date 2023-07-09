{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    newSession = true;
    keyMode = "vi";
    historyLimit = 5000;
    clock24 = true;
    extraConfig = ''
      set -g mouse on
      set -g default-terminal "screen-256color"
    '';
    plugins = with pkgs.tmuxPlugins; [
      catppuccin
      better-mouse-mode
    ];
  };
}
