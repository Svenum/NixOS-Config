{ pkgs ? import <nixpkgs> {} }:
pkgs.haskell.packages.ghc92.callPackage ./derivation.nix {}
