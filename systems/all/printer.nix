{ pkgs, ... }:

{
  # Enable printer
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  services.avahi.openFirewall = true;

  hardware.printers.ensurePrinters = {
    "Epson_ET-2720-Series" = {
      deviceUri = "https://pr-epson.intra.holypenguin.net:631/ipp/print";
      description = "Epson ET-2720";
    };
  };

  environment.systemPackages = with pkgs; [
    libinklevel
    epson-escpr
  ];
}
