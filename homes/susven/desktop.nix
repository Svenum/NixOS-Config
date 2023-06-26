{ pkgs, ... }:

{
  qt = {
    enable = true;
    platformTheme = "kde";
    style = {
      package = pkgs.breath-theme;
      name = "breath-dark";
    };
  };
}
