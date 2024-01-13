{ home, pkgs, lib, ... }:

let
  tetris = pkgs.callPackage ../../custom-nixpkgs/tetris {};
  themeFlavour = if builtins.getEnv "HOSTNAME" != "San" then "Mocha" else "Latte";
  cursorFlavour = if builtins.getEnv "HOSTNAME" == "San" then "Mocha" else "Latte";
  themeAccent = "Teal";
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
    workspace = {
      clickItemTo = "select";
      #theme = "Catppuccin-${themeFlavour}-${themeAccent}";
      theme = "default";
      colorScheme = "Catppuccin${themeFlavour}${themeAccent}";
      cursorTheme = "Catppuccin-${cursorFlavour}-${themeAccent}-Cursors";
      iconTheme = "Papirus";
      wallpaper = "/etc/wallpaper/catppuccin-${lib.strings.toLower themeFlavour}.jpg";
    };

    hotkeys.commands."Launch Konsole" = {
      key = "Ctrl+T";
      command = "konsole";
    };

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
