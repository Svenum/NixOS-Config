{ userList, lib, ... }:

{
  # Disable root
  users.users.root.hashedPassword = "!";

  # Config other users
  lib.lists.forEach = userList: user: lib.import ./userConfig.nix;
}
