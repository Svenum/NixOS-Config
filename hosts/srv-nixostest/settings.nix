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
    hostName = "srv-nixostest";
    interface = "enp1s0";
    address = "172.16.0.111";
    prefixLength = 24;
    defaultGateway = "172.16.0.1";
    nameservers = [ "172.16.0.3" "172.16.0.4" ];
  };

  # GPU Settings
  nvidia ={
    hybridGraphics = false;
  };

  # User Settings
  userAttrs = {
    "sven" = {
      isGuiUser = true;
      isSudoUser = true;
      git = {
        userName = "Svenum";
        userEmail = "s.ziegler@holypenguin.net";
      };
    };
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
