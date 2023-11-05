{ modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../../modules/user
    ../../modules/boot
    ../../modules/nvim
    ../../modules/locale
    ../../modules/desktop
    ../../modules/wireguard
    ../../modules/tmux 
    ../../modules/shell
    ./packages.nix
    ./skel.nix
    ./printer.nix
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config = {
    allowUnfree = true;
    nvidia.acceptLicense = true;
  };
  system.stateVersion = "23.05";
}
