{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    newSession = true;
    historyLimit = 5000;
    escapeTime = 200;
    aggressiveResize = true;
    clock24 = true;
    terminal = "screen-256color";
    plugins = with pkgs.tmuxPlugins; [
      (pkgs.callPackage ../../custom-nixpkgs/catppuccin-tmux {})
    ];
  };
}
