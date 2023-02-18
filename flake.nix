{
  description = "dan-franks's dotfiles";

  inputs = {
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixpkgs-22.11-darwin";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixos-stable.url = "github:nixos/nixpkgs/nixos-22.11";

    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, darwin, home-manager, flake-utils, ... } @ inputs:
    let
      inherit (darwin.lib) darwinSystem;
      inherit (inputs.nixpkgs-unstable.lib) attrValues makeOverridable optionalAttrs singleton;

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

      homeManagerStateVersion = "22.11";
      nixosStateVersion = "22.11";

      primaryUserInfo = {
        username = "dan";
        fullName = "Daniel Lucas";
        email = "dan.frank.lucas@gmail.com";
        github = "dan-frank";
      };

      nixDarwinCommonModules = attrValues self.darwinModules ++ [
        home-manager.darwinModules.home-manager
        ({ config, lib, pkgs, ... }:
          let
            inherit (config.users) primaryUser;
          in
          rec {
            nixpkgs = nixpkgsConfig;
            users.users.${primaryUser.username}.home = "/Users/${primaryUser.username}";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${primaryUser.username} = {
              imports = attrValues self.homeManagerModules;
              home.stateVersion = homeManagerStateVersion;
              home.user-info = config.users.primaryUser;
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
            home-manager.useGlobalPkgs = true;
            home-manager.users.${primaryUser.username} = {
              imports = attrValues self.homeManagerModules;
              home.stateVersion = homeManagerStateVersion;
              home.user-info = config.users.primaryUser;
            };
          })
      ];
    in
    {
      darwinConfigurations = rec {
        # My macOS configuration
        macbook-x86 = makeOverridable darwinSystem {
          system = "x86_64-darwin";
          modules = nixDarwinCommonModules ++ [
            ./system/darwin/host-mac.nix
            {
              users.primaryUser = primaryUserInfo;
            }
          ];
        };
        macbook-arm = macbook-x86.override { system = "aarch64-darwin"; };
      };

      nixosConfigurations = {
        wsl = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = nixosCommonModules ++ [
            ./system/nixos/host-wsl.nix
            {
              users.primaryUser = primaryUserInfo;
            }
          ];
        };
      };

      homeConfigurations = {
        linuxWsl = home-manager.lib.homeManagerConfiguration {
          pkgs = import inputs.nixpkgs-unstable {
            system = "x86_64-linux";
            inherit (nixpkgsConfig) config overlays;
          };
          modules = attrValues self.homeManagerModules ++ singleton ({ config, ... }: {
            home.username = config.home.user-info.username;
            home.homeDirectory = "/home/${config.home.username}";
            home.stateVersion = homeManagerStateVersion;
            home.user-info = primaryUserInfo;
          });
        };
      };

      darwinModules = {
        common = import ./system/common.nix;
        packages = import ./system/packages.nix;

        darwin-bootstrap = import ./system/darwin/bootstrap.nix;
        darwin-packages = import ./system/darwin/packages.nix;
        darwin-system = import ./system/darwin/system.nix;

        users-primaryUser = import ./schema/users.nix;
      };

      nixosModules = {
        common = import ./system/common.nix;
        stateVersion = { system.stateVersion = nixosStateVersion; };
        packages = import ./system/packages.nix;

        users-primaryUser = import ./schema/users.nix;
      };

      homeManagerModules = {
        home-config-files = import ./home/config-files.nix;
        home-git = import ./home/git.nix;
        home-packages = import ./home/packages.nix;
        home-shells = import ./home/shells.nix;
        home-terminal = import ./home/terminal.nix;

        home-bat = import ./home/programs/bat.nix;
        home-neovim = import ./home/programs/neovim.nix;
        home-vscode = import ./home/programs/vscode.nix;

        home-user-info = { lib, ... }: {
          options.home.user-info =
            (self.darwinModules.users-primaryUser { inherit lib; }).options.users.primaryUser;
        };
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
        ls-colors = import ./overlays/ls-colors;
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
