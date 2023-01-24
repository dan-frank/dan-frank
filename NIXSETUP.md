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

## Further Reading

The following links consit of useful resources that I used to learn about Nix and how to set it up, and other users setups that I used for inspiration (or completely ripped off) to improve my config management:

- [Nixology](https://www.youtube.com/playlist?list=PLRGI9KQ3_HP_OFRG6R-p4iFgMSK1t5BHs) <- Great walkthrough of managing your packages and dev envrionment with Nix
- [burke/b](https://github.com/burke/b) <- Burke's in depth setup
- [jpetrucciani/nix](https://github.com/jpetrucciani/nix) <- Jacobi's clever breakdown (that is simple to implement)
- [yuanw/nix-home](https://github.com/yuanw/nix-home) <- Yuan's neet packages
- [Sourcegraph](https://sourcegraph.com/search?q=context:global+lang:nix&patternType=standard&sm=1&groupBy=repo) <- Every users public file from GitHub

