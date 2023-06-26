{ ... }:

{
  imports = [
    ./bootloader.nix
    ./packages.nix
    ./desktop.nix
    ./language.nix
    ./user.nix
    ./nvim.nix
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "23.05";
}
