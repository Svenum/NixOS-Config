{
  # Language Settings
  tz = "Europe/Berlin";
  kbLayout = "de";
  locale = "de_DE";

  # Desktop Settings
  de = {
    name = "plasma";
  };
  theme = {
    accent = "peach";
    flavour = "mocha";
    mode = "dark";
  };

  # Network Settings
  networkConfig = {
    hostName = "Zeta";
    useDHCP = true;
  };

  # GPU Settings
  nvidia ={
    hybridGraphics = false;
  };

  # User Settings
  userAttrs = {
    "martinn" = {
      isGuiUser = true;
      isSudoUser = false;
      uid = 1001;
    };
    "sumartinn" = {
      isGuiUser = true;
      isSudoUser = true;
      uid = 1000;
      authorizedKeys = [
        "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBABz8jUkUacu8PahA+mlDCCp3780yrcpAcNZIJ1CFswAbgbWoK+FZxdQ3P43X4cBjKVtz8tthf4xHhkGe6eNC1+ofgHq5bXfIP15ba7AEncdUvreQzPx2Aao7yZFw94piTiZqlQA193SZTw8ggbYPwn3hnXkFT/6ttIEr+18xUMGFM9c1A== sven@Ni"
      ];
    };
  };
  
  # Virtualisation
  pciPassthrough.enable = false;

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
