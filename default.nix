with builtins;
{ 
  overlays ? [ ],
  config ? { },
  system ? builtins.currentSystem
}:
import <nixpkgs> {
  inherit system;
  overlays = overlays;
  config = { allowUnfree = true; } // config;
}

