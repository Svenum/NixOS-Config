{ userList, lib, pkgs, ... }:

let
  createUserConfig = {user}: { 
    # Create user
    user.name = {
      isNormalUser = true;
      description = user.name;
      # Add user to default groups
      extraGroups = [ "networkmanager" "libvirtd" "network" "video" "sys" "audio" "kvm" "optical" "scanner" "lp" (lib.mkIf (user.sudo ? false) [ "wheel" ])];
      useDefaultShell = true;
    };
  };
in
{
  # Disable root
  #users.users.root.hashedPassword = "!";
  #users.defaultUserShell = pkgs.zsh;

  # Create user
  lib.lists.forEach = userList: user: createUserConfig user;

  # Config other users
  #lib.lists.forEach = userList: user: import ./userConfig.nix;
}
