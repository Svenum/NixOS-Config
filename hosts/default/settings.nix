{
  tz = "Europe/Berlin";
  kbLayout = "de";
  de = {
    name = "plasma";
    waylandDefault = true;
  };
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
  locale = "en_DE";
  shell = "zsh";
}
