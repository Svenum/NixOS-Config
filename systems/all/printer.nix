{ pkgs, ... }:

{
  # Enable printer
  services.printing = {
    enable = true;
    drivers = [ pkgs.epson-escpr ];
  };
  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  services.avahi.openFirewall = true;

  hardware.printers = {
    ensurePrinters = [
      {
        name = "Epson_ET-2720-Series";
        deviceUri = "https://pr-epson.intra.holypenguin.net:631/ipp/print";
        description = "Epson ET-2720";
        model = "epson-inkjet-printer-escpr/Epson-ET-2720_Series-epson-escpr-en.ppd";
        ppdOptions.PageSize = "A4";
      }
    ];
    ensureDefaultPrinter = "Epson_ET-2720-Series";
  };

  environment.systemPackages = with pkgs; [
    libinklevel
    epson-escpr
  ];
}
