{ pkgs, ... }:

{
  users.users.susven = {
    isNormalUser = true;
    description = "Susven";
    extraGroups = [ "networkmanager" "wheel" ];
  };
  users.users.sven = {
    isNormalUser = true;
    description = "Sven";
    extraGroups = [ "networkmanager" "libvirtd" ];
  };
}
