{ ... }:

{
  #home.file.".themes" = {
  #  source = "/run/current-system/sw/share/themes";
  #  target = ".themes";
  #};
  xdg.configFile.".themes" = {
    enable = true;
    source = "/run/current-system/sw/share/themes";
    target = ".themes";
    recursive = true;
  };  
}
