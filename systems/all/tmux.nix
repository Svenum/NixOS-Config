{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    newSession = true;
    keyMode = "vi";
    historyLimit = 5000;
    clock24 = true;
    terminal = "screen-256color";
    plugins = with pkgs.tmuxPlugins; [
      (import ../../custom-nixpkgs/catppuccin-tmux pkgs)
    ];
  };
}
