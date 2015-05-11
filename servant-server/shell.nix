{ nixpkgs ? (import <nixpkgs> {}) }:
let
  lib = nixpkgs.haskell-ng.lib;
  haskell = nixpkgs.haskellngPackages.override { 
    overrides = self: super: {
      # overrides here

      # additional libraries
      servant = self.callPackage ../servant/default.nix {};

      servant-server = lib.addBuildTools (self.callPackage ./default.nix {}) [
        self.cabal2nix
        self.cabal-install
        self.codex
        self.ghc-mod
        #self.ghci-ng
        self.hasktags
        self.hlint
        self.stylish-haskell
      ];
    };
  };
in
haskell.servant-server.env
