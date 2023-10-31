{ userList, lib, ... }:

{
  # Disable root
  users.users.root.hashedPassword = "!";

  # Config other users
  lib.forEach = userList: user: lib.import ./userConfig.nix;
}
