{ de, ... }:

{
  # Configure RDP
  services.xrdp = {
    enable = true;
    openFirewall = true;
    defaultWindowManager = (
      if de == "plasma" then
        "startplasma-x11"
        else
        ""
    );
  };
}
