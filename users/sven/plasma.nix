{ lib, settings, systemConfig, ... }:

let
  hostname = settings.networkConfig.hostName;
  cursorFlavour = if settings.theme.flavour == "latte" then "Mocha" else "Latte";
  themeAccent = if settings.theme.accent == "teal" then "Teal" else "";
  themeFlavour = if settings.theme.flavour == "latte" then "Latte" else "Mocha";
  range = if hostname == "San" then "1200" else if hostname == "Ni" then "800" else if hostname == "srv-nixostest" then "400" else "100"; 
in
{
  programs.plasma = {
    enable = true;
    workspace = {
      clickItemTo = "select";
      theme = "default";
      colorScheme = "Catppuccin${themeFlavour}${themeAccent}";
      cursorTheme = "Catppuccin-${cursorFlavour}-${themeAccent}-Cursors";
      wallpaper = "/etc/wallpaper/catppuccin-${lib.strings.toLower settings.theme.flavour}.jpg";
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
        floating = false;
        widgets = [
          "org.kde.plasma.panelspacer"
          {
            name = "org.kde.plasma.icontasks";
            config = {
              General = {
                launchers = [
                  "applications:org.kde.dolphin.desktop"
                  "preferred://browser"
                  "applications:com.valvesoftware.Steam.desktop"
                  "applications:net.lutris.Lutris.desktop"
                  "applications:net.lutris.league-of-legends-1.desktop"
                  "applications:org.remmina.Remmina.desktop"
                ];
              };
            };
          }
          "org.kde.plasma.panelspacer"
        ];
        height = 50;
        maxLength = 1410;
        minLength = 1050;
      }
      {
        location = "top";
        hiding = "windowscover";
        alignment = "center";
        floating = false;
        widgets = [
          "org.kde.plasma.appmenu"
          "org.kde.plasma.panelspacer"
          "org.kde.plasma.digitalclock"
          {
            name = "org.kde.plasma.digitalclock";
            config = {
              Apperance = {
                dateDisplayFormat = "BesideTime";
                dateFormat = "longDate";
              };
            };
          }
          "org.kde.plasma.pager"
          "org.kde.plasma.panelspacer"
          "org.kde.plasma.systemmonitor.memory"
          {
            name = "org.kde.plasma.systemmonitor.cpucore";
            config = {
              Appearance = {
                chartFace = "org.kde.ksysguard.piechart";
              };
              "org.kde.ksysguard.piechart.General" = {
                rangeTo = range;
                rangeAuto = "false";
              };
            };
          }
          ( if (!builtins.elem "modesetting" systemConfig.services.xserver.videoDrivers) then {
            name = "org.kde.plasma.systemmonitor";
            config = {
              Sensors = {
                highPrioritySensorIds= ''[\"gpu/gpu0/usage\"]'';
                totalSensors = ''[\"gpu/gpu0/usage\"]'';
              };
            };
          } else "" )
          {
            name = "org.kde.plasma.panelspacer";
            config = {
              General = {
                length = "10";
                expanding = "false";
              };
            };
          }
          "org.kde.plasma.systemtray"
          {
            name = "org.kde.shutdownOrSwitch";
            config = {
              General = {
                showName = "false";
                showExit = "true";
                showNewSession = "false";
                showSuspend = "true";
                showUser = "false";
                showUsers = "false";
              };
              Appearance = {
                widgetListIconSize = "2";
              };
            };
          }
        ];
        height = 30;
        maxLength = 3440;
        minLength = 1920;
        #extraSettings = ''
        #  panelIds.forEach((panel) => { //search through the panels
        #    panel = panelById(panel);
        #    if (!panel) {
        #      return;
        #    }
        #    panel.widgetIds.forEach((appletWidget) => {
        #      appletWidget = panel.widgetById(appletWidget);
        #        case "org.kde.plasma.systemmonitor.cpucore":
        #          appletWidget.currentConfigGroup = ["org.kde.ksysguard.piechart", "General"];
        #          appletWidget.writeConfig("rangeTo", ${range});
        #          appletWidget.writeConfig("rangeAuto", false);
        #          appletWidget.reloadConfig();
        #          break;
        #      }
        #    });
        #  });
        #'';
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
