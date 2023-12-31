{ printerAttrs, pkgs, lib, enableScanner, ... }:

let
  mkPrinterConfig = printer: {
    name = printer.name;
    deviceUri = printer.deviceUri;
    description = printer.description;
    model = printer.model;
    #ppdOptions.PageSize = if builtins.hasAttr "pageSize" printer then printer.pageSize else "A4";
  };

  defaultPrinter = (lib.lists.findFirst (printer: if builtins.hasAttr "isDefault" printer then printer.isDefault else false) (lib.lists.findFirst (printer: true) "none" printerAttrs) printerAttrs).name;

in
{
  # Enable printer
  services.printing = {
    enable = true;
    drivers = with pkgs; [ epson-escpr hplip ];
  };
  # Enable auto discovery
  #services.avahi.enable = true;
  #services.avahi.nssmdns = true;
  #services.avahi.openFirewall = true;

  hardware.printers = {
    ensurePrinters = builtins.map mkPrinterConfig printerAttrs;
    ensureDefaultPrinter = defaultPrinter;
  };

  environment.systemPackages = with pkgs; [
    libinklevel
    epson-escpr
    hplip
  ];

  # Enable Scanner
  hardware.sane = {
    enable = enableScanner;
    extraBackends = with pkgs; [
      sane-airscan
      #hplipWithPlugin
      #epkowa
    ];
  };

  # Enable usb scanner support
  services.ipp-usb.enable = true;
}
