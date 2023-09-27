{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    newSession = true;
    historyLimit = 5000;
    escapeTime = 100;
    clock24 = true;
    terminal = "screen-256color";
    plugins = with pkgs.tmuxPlugins; [
      catppuccin
    ];
    extraConfig = ''
      set -g repeat-time 700
    '';
  };
}
