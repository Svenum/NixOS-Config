{
  description = "Flatpak Flake for managing flatpaks";

  outputs = inputs@{ nixpkgs, ... }:
  {
    nixosModules.default = import ./default.nix;
  };
}
