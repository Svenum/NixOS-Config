{ modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../../modules/user
    ../../modules/boot
    ../../modules/nvim
    ./packages.nix
    ./desktop.nix
    ./language.nix
    ./tmux.nix
    ./shell.nix
    ./skel.nix
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
