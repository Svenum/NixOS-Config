{ pkgs, ... }:

{
  # Enable printer
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  services.avahi.openFirewall = true;

  hardware.printers = {
    ensurePrinters = [
      {
        name = "Epson_ET-2720-Series";
        deviceUri = "https://pr-epson.intra.holypenguin.net:631/ipp/print";
        description = "Epson ET-2720";
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
