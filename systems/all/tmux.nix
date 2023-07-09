{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    newSession = true;
    keyMode = "vi";
    historyLimit = 5000;
    clock24 = true;
    plugins = with pkgs.tmuxPlugins; [
      catppuccin
      better-mouse-mode
    ];
  };
}
