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
      theme = "default";
      colorScheme = "Catppuccin${themeFlavour}${themeAccent}";
      cursorTheme = "Catppuccin-${cursorFlavour}-${themeAccent}";
      iconTheme = "Papirus";
      wallpaper = "/etc/wallpaper/catppuccin-${lib.strings.toLower themeFlavour}.jpg";
    };

    hotkeys.commands."Launch Konsole" = {
      key = "Ctrl+T";
      command = "konsole";
    };

    panels = [
      {
        location = "left";
        hiding = "windowscover";
        alignment = "right";
        widgets = [
          "org.kde.plasma.panelspacer"
          "org.kde.plasma.icontasks"
          "org.kde.plasma.panelspacer"
        ];
        iconTasksLaunchers = [
          "org.kde.dolphin.desktop"
          "com.brave.Browser.desktop"
          "com.valvesoftware.Steam.desktop"
          "net.lutris.Lutris.desktop"
          "net.lutris.league-of-legends-1.desktop"
          "org.remmina.Remmina.desktop"
        ];
        height = 50;
        maxLength = 1410;
        minLength = 1050;
      }
      {
        location = "top";
        hiding = "windowscover";
        alignment = "center";
        widgets = [
          "org.kde.plasma.appmenu"
          "org.kde.plasma.panelspacer"
          "org.kde.plasma.betterinlineclock"
          "org.kde.plasma.pager"
          "org.kde.plasma.panelspacer"
          "org.kde.plasma.systemmonitor.memory"
          "org.kde.plasma.systemmonitor.cpucore"
          "org.kde.plasma.systemtray"
          "org.kde.shutdownOrSwitch"
        ];
        height = 30;
        maxLength = 3440;
        minLength = 1920;
      }
    ];

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
