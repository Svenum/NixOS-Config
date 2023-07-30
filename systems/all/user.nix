{ pkgs, ... }:

{
  users.defaultUserShell = pkgs.zsh;
  users.users.susven = {
    isNormalUser = true;
    description = "Susven";
    extraGroups = [ "networkmanager" "wheel" ];
    useDefaultShell = true;
  };
  users.users.sven = {
    isNormalUser = true;
    description = "Sven";
    extraGroups = [ "networkmanager" "libvirtd" "network" "video" "sys" "audio" "kvm" "optical" "scanner" ];
    useDefaultShell = true;
  };
}
