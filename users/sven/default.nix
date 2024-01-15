{ home, pkgs, lib, ... }:

let
  tetris = pkgs.callPackage ../../custom-nixpkgs/tetris {};
  
  hostname = builtins.getEnv "HOSTNAME";
  themeFlavour = if hostname != "San" then "Mocha" else "Latte";
  cursorFlavour = if hostname == "San" then "Mocha" else "Latte";
  themeAccent = "Teal";
  range = if hostname == "San" then "1200" else if hostname == "Ni" then "800" else if hostname == "srv-nixos-test" then "400" else "100"; 
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
      cursorTheme = "Catppuccin-${cursorFlavour}-${themeAccent}-Cursors";
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
        extraSettings = ''
          panelIds.forEach((panel) => { //search through the panels
            panel = panelById(panel);
            if (!panel) {
              return;
            }
            panel.widgetIds.forEach((appletWidget) => {
              appletWidget = panel.widgetById(appletWidget);

              switch(appletWidget.type) {
                case "org.kde.shutdownOrSwitch":
                  appletWidget.currentConfigGroup = ["General"];
                  appletWidget.writeConfig("showName", false);
                  appletWidget.writeConfig("showExit", true);
                  appletWidget.writeConfig("showNewSession", false);
                  appletWidget.writeConfig("showSuspend", true);
                  appletWidget.writeConfig("showUser", false);
                  appletWidget.writeConfig("showUsers", false);
                  appletWidget.currentConfigGroup = ["Appearance"];
                  appletWidget.writeConfig("widgetListIconSize", 2);
                  appletWidget.reloadConfig();
                  break;
                case "org.kde.plasma.systemmonitor.cpucore":
                  appletWidget.currentConfigGroup = ["Appearance"];
                  appletWidget.writeConfig("chartFace", "org.kde.ksysguard.piechart");
                  appletWidget.currentConfigGroup = ["org.kde.ksysguard.piechart", "General"];
                  appletWidget.writeConfig("rangeTo", ${range});
                  appletWidget.writeConfig("rangeAuto", false);
                  appletWidget.reloadConfig();
                  break;
              }
            });
          });
        '';
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
