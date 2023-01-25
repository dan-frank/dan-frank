with builtins;
{ 
  config ? { },
  system ? builtins.currentSystem
}:
import <nixpkgs> {
  inherit system;
  config = { allowUnfree = true; } // config;
}

