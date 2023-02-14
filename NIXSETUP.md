# Nix Dev Environment

I'm using Nix and home-manager to manage my applications and their configurations.
This file will act as a guide for how to setup and run these files.

## Next steps

1. Add custom overlay to `flake.nix` and apply with home-manager.
1. Setup nerdfonts to work correctly and apply to alacritty
1. Update configurations to allow for various hosts (i.e. Work M2 + NixOS VM + Asahi?)

## Setup

|                   | MacOS     | NixOS |
| ----------------- | --------- | ----- |
| Shell             | ZSH       | ?     |
| Window Manager    | ?         | ?     |
| Terminal Emulator | Alacritty | ?     |
| Editor            | NeoVim    | ?     |

## Dependencies

- [Nix](https://nixos.org/)

## Build Instructions

1. Install Nix package manager

```
sh <(curl -L https://nixos.org/nix/install)
```

2. Clone this repo into your home config directory

```sh
nix-shell -p git
git clone https://github.com/dan-frank/dan-frank ~/.config/dan-frank
```

3. Install system configurations with nix

---
**TODO**

Remove `--impure` flag
---

```sh
cd ~/.config/dan-frank
nix build .#darwinConfigurations.dan.system --extra-experimental-features "nix-command flakes" --impure
./result/sw/bin/darwin-rebuild switch --flake . --impure
```

4. Install other apps

Some apps are unable to be installed via Nix

- [1Password](https://1password.com/downloads/mac/)
- [1Password for Safari](https://apps.apple.com/us/app/1password-for-safari/id1569813296?mt=12)

## Breakdown

### `flake.nix`

Entry point and container of all my config dependancies.

### `/dotfiles`

`.` dotfiles that I was unable to 'nixify' and are imported as is.

### `/hosts`

My dev environments, managed with home manager and my nix flake.

### `/modules`

This folder includes various nix attribute files that contain the configurations of various packages and apps that I use.

### `/overlays`

This folder contains my personal overlays that don't really need to be pushed into the main nixpkgs repo.

## Further Reading

The following links consit of useful resources that I used to learn about Nix and how to set it up, and other users setups that I used for inspiration (or completely ripped off) to improve my config management:

- [nix-darwin Instructions](https://xyno.space/post/nix-darwin-introduction) <- Nice blog post about setting up nix-darwin
- [Nixology](https://www.youtube.com/playlist?list=PLRGI9KQ3_HP_OFRG6R-p4iFgMSK1t5BHs) <- Great walkthrough of managing your packages and dev envrionment with Nix
- [burke/b](https://github.com/burke/b) <- Burke's in depth setup
- [jpetrucciani/nix](https://github.com/jpetrucciani/nix) <- Jacobi's clever breakdown (that is simple to implement)
- [yuanw/nix-home](https://github.com/yuanw/nix-home) <- Yuan's neet packages
- [lucasew/nixcfg](https://github.com/lucasew/nixcfg) <- Interesting setup with custom (edited with config) packages
- [alex35mil/dotfiles](https://github.com/alex35mil/dotfiles) <- Another nice and simple setup
- [jakehamilton/dotfiles](https://github.com/jakehamilton/dotfiles) <- Cool darwin setup with tiling manager and top bar
- [shaunsing/nix-darwin-dotfiles](https://github.com/shaunsingh/nix-darwin-dotfiles) <- Nicely commented flake
- [ahmedelgabri/dotfiles](https://github.com/ahmedelgabri/dotfiles/blob/main/flake.nix#L99) <- Interesting shared flake config
- [Sourcegraph](https://sourcegraph.com/search?q=context:global+lang:nix&patternType=standard&sm=1&groupBy=repo) <- Every users public file from GitHub

