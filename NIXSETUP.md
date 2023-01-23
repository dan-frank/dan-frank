# Nix Dev Environment

I'm using Nix and home-manager to manage my applications and their configurations.
This file will act as a guide for how to setup and run these files.

## Setup

|                   | MacOS     | NixOS |
| ----------------- | --------- | ----- |
| Shell             | ZSH       | ?     |
| Window Manager    | ?         | ?     |
| Terminal Emulator | Alacritty | ?     |
| Editor            | NeoVim    | ?     |

## Dependencies

- [Nix](https://nixos.org/)
- [Home Manager](https://github.com/nix-community/home-manager)

## Build Instructions


**Current build instrucions are for Mac only.**
May update with Linux instructions in the future once setup and tested.

1. Install Nix package manager

```
sh <(curl -L https://nixos.org/nix/install)
```

This command will install all the required nix commands to manage packages from the Nix Store.

2. Install Home Manager for Nix

```
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```

This will add Home Manager commands that can be used to manage packages and their configurations from the Nix Store **and** store and declaratively manage these packages configurations.

3. Navigating to correct location 

```
cd ~/.config/nixpkgs
rm home.nix
```

Here we are moving into the nix configuration directory and removing the default `home.nix` file that we will replace with our own.

4. Downloading configuration

```
nix-shell -p git
git clone https://github.com/dan-frank/dan-frank.git .
```

These commands will create a temporary Nix shell where you have access and can use Git commands.
We then clone the repo containing the project into the current directory, which should be `~/.config/nixpkgs`.

5. Install my Nix configuration

```
home-manager switch
```

