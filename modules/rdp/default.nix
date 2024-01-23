{ settings, ... }:

{
  # Configure RDP
  services.xrdp = {
    enable = true;
    openFirewall = true;
    defaultWindowManager = (
      if settings.de == "plasma" then
        "startplasma-x11"
        else
        ""
    );
  };
}
