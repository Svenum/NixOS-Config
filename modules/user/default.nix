{ userAttrs, lib, pkgs, ... }:

let
  mkUser = name: user: {
    isNormalUser = true;
    description = name;
    extraGroups = [ "networkmanager" "libvirtd" "network" "video" "sys" "audio" "kvm" "optical" "scanner" "lp" (lib.mkIf (if builtins.hasAttr "isSudo" user then user.isSudo else false) "wheel")];
    useDefaultShell = true;
  };
in
{
  # Disable root
  #users.users.root.hashedPassword = "!";
  #users.defaultUserShell = pkgs.zsh;

  # Create user
  users.users = lib.mapAttrs mkUser userAttrs;
}
