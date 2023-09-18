{ pkgs, ... }:

{
  # Disable root
  users.users.root.hashedPassword = "!";

  users.defaultUserShell = pkgs.zsh;
  #users.users.susven = {
  #  isNormalUser = true;
  #  description = "Susven";
  #  extraGroups = [ "networkmanager" "wheel" "lp" ];
  #  useDefaultShell = true;
  #};
  users.users.sven = {
    isNormalUser = true;
    description = "Sven";
    extraGroups = [ "wheel" "networkmanager" "libvirtd" "network" "video" "sys" "audio" "kvm" "optical" "scanner" "lp" ];
    useDefaultShell = true;
  };
}
