{ home, pkgs, ... }:

let
  tetris = pkgs.callPackage ../../custom-nixpkgs/tetris {};
in
{
  # Add extgra packages
  home.packages = with pkgs; [
    caffeine-ng
    tetris
    ccrypt
  ];


  programs.plasma = {
    enable = true;
    shortcuts = {
      kwin = {
        # Switch Desktop
        "Switch One Desktop Down" = "Ctrl+Alt+Down";
        "Switch One Desktop Up" = "Ctrl+Alt+Up";
        "Switch One Desktop to the Left" = "Ctrl+Alt+Left";
        "Switch One Desktop to the Right" = "Ctrl+Alt+Right";
        # Move Window to diffrent Desktop
        "Window One Desktop Down" = "Meta+Ctrl+Alt+Down";
        "Window One Desktop Up" = "Meta+Ctrl+Alt+Up";
        "Window One Desktop to the Left" = "Meta+Ctrl+Alt+Left";
        "Window One Desktop to the Right" = "Meta+Ctrl+Alt+Right";


      };
    };
  };
}
