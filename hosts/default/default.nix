{ modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./bootloader.nix
    ./packages.nix
    ./plymouth.nix
    ./desktop.nix
    ./language.nix
    ./user.nix
    ./nvim.nix
    ./tmux.nix
    ./shell.nix
    ./skel.nix
    ./kernel.nix
    ./network.nix
    ./printer.nix
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config = {
    allowUnfree = true;
    nvidia.acceptLicense = true;
  };
  system.stateVersion = "23.05";
}
