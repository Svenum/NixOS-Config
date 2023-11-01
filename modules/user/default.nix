{ userList, lib, ... }:

rec {
  # Disable root
  users.users.root.hashedPassword = "!";

  # Config other users
  lib.lists.forEach = userList: user: import ./userConfig.nix;
}
