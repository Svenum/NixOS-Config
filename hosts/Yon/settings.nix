{
  # Language Settings
  tz = "Europe/Berlin";
  kbLayout = "de";
  locale = "en_DE";

  # Desktop Settings
  de = {
    name = "plasma";
    waylandDefault = true;
  };
  theme = {
    accent = "teal";
    flavour = "mocha";
    mode = "dark";
  };

  # Network Settings
  networkConfig = {
    hostName = "Yon";
    useDHCP = true;
  };

  # User Settings
  userAttrs = {
    "sven" = {
      isGuiUser = true;
      isSudoUser = true;
      isKvmUser = true;
      git = {
        userName = "Svenum";
        userEmail = "s.ziegler@holypenguin.net";
      };
    };
  };

  pciPassthrough = {
    enable = true;
    isolatedDevices = [
      "1002:ab30"
      "1002:7480"
      "c0a9:5021"
    ];
  };

  # Printer Settings
  enableScanner = true;
  printerAttrs =[
    {
      name = "Epson_ET-2720-Series";
      deviceUri = "https://pr-epson.intra.holypenguin.net:631/ipp/print";
      model = "epson-inkjet-printer-escpr/Epson-ET-2720_Series-epson-escpr-en.ppd";
      description = "Epson ET-2720";
      isDefault = true;
    }
    {
      name = "HP_Officejet_5740-Series";
      deviceUri = "https://pr-hp.intra.holypenguin.net/ipp/printers";
      model = "HP/hp-officejet_5740_series.ppd.gz";
      description = "HP Officejet 5740";
      isDefault = false;
    }
  ]; 

  # Shell Settings
  shell = "zsh";
}
