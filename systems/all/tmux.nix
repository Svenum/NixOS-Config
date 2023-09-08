{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    newSession = true;
    historyLimit = 5000;
    resizeAmount = 15;
    clock24 = true;
    customPaneNavigationAndResize = true; 
    terminal = "screen-256color";
    plugins = with pkgs.tmuxPlugins; [
      (pkgs.callPackage ../../custom-nixpkgs/catppuccin-tmux {})
    ];
  };
}
