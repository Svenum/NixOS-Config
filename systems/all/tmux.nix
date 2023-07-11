{ pkgs, ... }:

let
  catppuccin-tmux = pkgs.callPackage (import ../../custom-nixpkgs/catppuccin-tmux) {};
{
  programs.tmux = {
    enable = true;
    newSession = true;
    keyMode = "vi";
    historyLimit = 5000;
    clock24 = true;
    terminal = "screen-256color";
    plugins = [
      catppuccin-tmux
    ];
  };
}
