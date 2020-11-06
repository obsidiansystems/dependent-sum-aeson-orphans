{ pkgs ? import ./nixpkgs {} }:
pkgs.haskell.packages.ghc884.callCabal2nix "dependent-sum-aeson-orphans" ./. {}
