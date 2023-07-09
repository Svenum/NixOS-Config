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
    '';
    plugins = with pkgs.tmuxPlugins; [
      catppuccin
      better-mouse-mode
    ];
  };
}
