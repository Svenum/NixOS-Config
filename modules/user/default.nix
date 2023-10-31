{ users, lib, ... }:

{
  lib.forEach = users: user: import ./userConfig.nix;
}
