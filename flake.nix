{
  description = "dan-frank's system config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-22.11-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs"; # ...

    # ls-colors = {
    #   url = "path:overlays/ls-colors";
    #   flake = false;
    # };
  };

  outputs = { self, nixpkgs, darwin, home-manager, ... } @ inputs:
  let 
    inherit (darwin.lib) darwinSystem;
    inherit (inputs.nixpkgs-unstable.lib) attrValues makeOverridable optionalAttrs singleton;

    # Configuration for `nixpkgs`
    nixpkgsConfig = {
      config = {
        allowUnfree = true;
        allowBroken = false;
        allowInsecure = false;
        allowUnsupportedSystem = false;
      };
      # overlays = attrValues self.overlays;
    }; 
  in
  {
    darwinConfigurations = rec {
      dan = darwinSystem {
        system = "aarch64-darwin";
        modules = [
          home-manager.darwinModules.home-manager
          ./hosts/dan/configuration.nix
          {
            nixpkgs = nixpkgsConfig;
            # `home-manager` config
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.dan = import ./hosts/dan/home.nix;            
            };
          }
        ];
      };
    };
  };

  # Overlays to add various packages into package set
  # overlays = {
  #   # ls-colors = final: prev: {
  #   #   ls-colors = import inputs.ls-colors { inherit (prev) pkgs; };
  #   # };
  #   ls-colors = import inputs.ls-colors.default;
  # };
}

