{
  description = "dan-franks's dotfiles";

  inputs = {
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixpkgs-23.05-darwin";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixos-stable.url = "github:nixos/nixpkgs/nixos-23.05";

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";

    flake-utils.url = "github:numtide/flake-utils";

    nix-colors.url = "github:misterio77/nix-colors";

    nixpkgs-firefox-darwin = {
      url = "github:bandithedoge/nixpkgs-firefox-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
  };

  outputs = { self, nixpkgs, darwin, nix-homebrew, homebrew-bundle, homebrew-core, homebrew-cask, home-manager, flake-utils, ... } @ inputs:
    let
      inherit (darwin.lib) darwinSystem;
      inherit (inputs.nixpkgs-unstable.lib) attrValues makeOverridable optionalAttrs singleton;
      #inherit (inputs.nixpkgs.stdenv) isDarwin;
      isDarwin = nixpkgs.lib.hasSuffix "-darwin";

      systems = [
        "x86_64-darwin"
        "aarch64-darwin"
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);

      nixpkgsConfig = with inputs; rec {
        config = { allowUnfree = true; };
        overlays = attrValues self.overlays;
      };

      homeManagerStateVersion = "23.05";
      nixosStateVersion = "23.05";

      userInfo = {
        primary = {
          username = "dan";
          fullName = "Daniel Lucas";
          email = "dan.frank.lucas@gmail.com";
          github = "dan-frank";
        };

        work = userInfo.primary // { username = "dlucas"; };
      };

      nixDarwinCommonModules = attrValues self.darwinModules ++ [
        home-manager.darwinModules.home-manager
        nix-homebrew.darwinModules.nix-homebrew
        ({ config, lib, pkgs, ... }:
          let
            inherit (config.users) primaryUser;
          in
          rec {
            nixpkgs = nixpkgsConfig;
            users.users.${primaryUser.username}.home = "/Users/${primaryUser.username}";
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${primaryUser.username} = {
                imports = attrValues self.homeManagerModules;
                home.stateVersion = homeManagerStateVersion;
                home.user-info = config.users.primaryUser;
              };
              extraSpecialArgs = { inherit inputs; };
            };
            nix-homebrew = {
              user = primaryUser.username;
              enable = true;
              taps = {
                "homebrew/homebrew-core" = homebrew-core;
                "homebrew/homebrew-cask" = homebrew-cask;
                "homebrew/homebrew-bundle" = homebrew-bundle;
              };
              mutableTaps = false;
              autoMigrate = true;
            };
          })
      ];

      nixosCommonModules = attrValues self.nixosModules ++ [
        home-manager.nixosModules.home-manager
        ({ config, lib, pkgs, ... }:
          let
            inherit (config.users) primaryUser;
          in
          rec {
            nixpkgs = nixpkgsConfig;
            users.users.${primaryUser.username} = {
              home = "/home/${primaryUser.username}";
              isNormalUser = true;
              isSystemUser = false;
              initialPassword = "helloworld";
              extraGroups = [ "wheel" ];
              shell = pkgs.zsh;
            };
            home-manager = {
              useGlobalPkgs = true;
              users.${primaryUser.username} = {
                imports = attrValues self.homeManagerModules;
                home.stateVersion = homeManagerStateVersion;
                home.user-info = config.users.primaryUser;
              };
              extraSpecialArgs = { inherit inputs; };
            };
          })
      ];
    in
    {
      darwinConfigurations = rec {
        darwin-mac = darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          specialArgs = { inherit inputs; };
          modules = nixDarwinCommonModules ++ [
            ./hosts/darwin
            # Do I need this?
            {
              users.primaryUser = userInfo.primary;
            }
          ];
        };

        hss-016404 = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = { inherit inputs; };
          modules = nixDarwinCommonModules ++ [
            ./hosts/darwin/hss-016404
            # Do I need this?
            {
              users.primaryUser = userInfo.work;
            }
          ];
        };
      };

      nixosConfigurations = rec {
        utm-x86 = makeOverridable nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = nixosCommonModules ++ [
            ./hosts/nixos/utm-vm
            {
              users.primaryUser = userInfo.primary;
            }
          ];
        };
        utm-arm = utm-x86.override { system = "aarch64-linux"; };

        # linux-x86 = makeOverridable nixpkgs.lib.nixosSystem {
        #   system = "x86_64-linux";
        #   specialArgs = { inherit inputs; };
        #   modules = nixosCommonModules ++ [
        #     ./hosts/nixos/linux
        #     {
        #       users.primaryUser = userInfo.primary;
        #     }
        #   ];
        # };
        # linux-arm = linux-x86.override { system = "aarch64-linux"; };
      };

      darwinModules = {
        users-primaryUser = import ./options/users.nix;
        fontProfiles = import ./options/fontProfiles.nix;
        nixColors = inputs.nix-colors.homeManagerModules.default;
      };

      nixosModules = {
        stateVersion = { system.stateVersion = nixosStateVersion; };

        users-primaryUser = import ./options/users.nix;
        fontProfiles = import ./options/fontProfiles.nix;
        nixColors = inputs.nix-colors.homeManagerModules.default;
      };

      homeManagerModules = {
        home-modules = import ./home;

        home-user-info = { lib, ... }: {
          options.home.user-info =
            (self.darwinModules.users-primaryUser { inherit lib; }).options.users.primaryUser;
        };
        fontProfiles = import ./options/fontProfiles.nix;
        nixColors = inputs.nix-colors.homeManagerModules.default;
      };

      overlays = {
        pkgs-master = _: prev: {
          pkgs-master = import inputs.nixpkgs-master {
            inherit (prev.stdenv) system;
            inherit (nixpkgsConfig) config;
          };
        };
        pkgs-stable = _: prev: {
          pkgs-stable = import inputs.nixpkgs-stable {
            inherit (prev.stdenv) system;
            inherit (nixpkgsConfig) config;
          };
        };
        pkgs-unstable = _: prev: {
          pkgs-unstable = import inputs.nixpkgs-unstable {
            inherit (prev.stdenv) system;
            inherit (nixpkgsConfig) config;
          };
        };
        # Overlay useful on Macs with Apple Silicon
        apple-silicon = _: prev: optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
          # Add access to x86 packages system is running Apple Silicon
          pkgs-x86 = import inputs.nixpkgs-unstable {
            system = "x86_64-darwin";
            inherit (nixpkgsConfig) config;
          };
        };

        firefox = inputs.nixpkgs-firefox-darwin.overlay;
        nur = inputs.nur.overlay;
      };

      # `nix develop`
      devShell = forAllSystems
        (system:
          let
            pkgs = nixpkgs.legacyPackages.${system};
          in
          pkgs.mkShell {
            nativeBuildInputs = with pkgs; [
              rnix-lsp
              nixpkgs-fmt
            ];
          }
        );
      formatter =
        forAllSystems (system: nixpkgs.legacyPackages.${system}.nixpkgs-fmt);

      # Figure this out -> https://github.com/jeslie0/fonts/blob/main/flake.nix
      # fonts.shin-go = nixpkgs.stdenvNoCC.mkDerivation {
      #   name = "shin-go-font";
      #   dontConfigue = true;
      #   src = nixpkgs.fetchzip {
      #     url = "https://www.cufonfonts.com/download/redirect/a-otf-shin-go-pro";
      #     sha256 = "sha256-FBA8Lj2yJzrBQnazylwUwsFGbCBp1MJ1mdgifaYches=";
      #     stripRoot = false;
      #   };
      #   installPhase = ''
      #     mkdir -p $out/share/fonts
      #     cp -R $src/a-otf-shin-go-pro-cufonfonts $out/share/fonts/truetype/
      #   '';
      #   meta = { description = "The A-OTF Shin Go Pro Font Family derivation."; };
      # };
    };
}
