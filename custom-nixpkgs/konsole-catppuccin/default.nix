{ pkgs ? import <nixpkgs> {} }:
pkgs.haskellPackages.callPackage ./derivation.nix {}
