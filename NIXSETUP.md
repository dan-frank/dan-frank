# `dan-frank`'s Nix System Configuration 

I'm using Nix to manage my applications and their configurations.
This file will act as a guide for how to setup and run these files.

_This setup is heavily inspired (stolen) from the brilliant [@hardselius/dotfiles](https://github.com/hardselius/dotfiles)._

## Next steps

1. Add custom overlay to `flake.nix` and apply with home-manager.
1. Setup nerdfonts to work correctly and apply to alacritty
1. Update configurations to allow for various hosts (i.e. Work M2 + NixOS VM + Asahi?)
1. Add `.zshhistory` to repo
1. [Install some Mac Apps from App Store with `mas`](https://daiderd.com/nix-darwin/manual/index.html#opt-homebrew.masApps)
1. [Look into if I can configure Safari settings](https://daiderd.com/nix-darwin/manual/index.html#opt-system.defaults.CustomUserPreferences)

## Setup

|                   | MacOS     | NixOS |
| ----------------- | --------- | ----- |
| Shell             | ZSH       | ?     |
| Window Manager    | ?         | ?     |
| Terminal Emulator | Alacritty | ?     |
| Editor            | NeoVim    | ?     |

## Dependencies

- [Nix](https://nixos.org/)

## Preliminary

0. ? Install 'Command Line Developer Tools' for [Mac only]

```sh
xcode-select --install
```

1. Install Nix package manager

```sh
sh <(curl -L https://nixos.org/nix/install)
```

2. Clone this repo into your home config directory

```sh
nix-shell -p git
git clone https://github.com/dan-frank/dan-frank ~/d
```

## Build Instructions

1. Build the environment from the Nix flake

```
cd ~/d
nix build \
	--extra-experimental-features nix-command \
	--extra-experimental-features flakes \
	.#darwinConfigurations.bootstrap-arm.system
./result/sw/bin/darwin-rebuild switch --flake .#bootstrap-arm
```

2. **Open up a new terminal session** and run the following to apply the configs 

```
cd ~/d
darwin-rebuild switch --flake .#macbook-arm
```

3. Install other apps

Some apps are unable to be installed via Nix

- [1Password](https://1password.com/downloads/mac/)
- [itsycal](https://www.mowglii.com/itsycal/)
- [Bartender 4](https://www.macbartender.com)
- [Night Owl](https://nightowlapp.co)
- [Haze Over](https://hazeover.com)
- [Logi Options +](https://www.logitech.com/en-gb/software/logi-options-plus.html)
- [Bears Countdown](https://apps.apple.com/us/app/bears-countdown/id1536711520)
- [Duckduckgo Mac](https://duckduckgo.com/mac)
- Safari Extensions
  - [1Password for Safari](https://apps.apple.com/us/app/1password-for-safari/id1569813296?mt=12)
  - [Duckduckgo Privacy for Safari](https://apps.apple.com/us/app/duckduckgo-privacy-for-safari/id1482920575?mt=12)
  - [Dark Reader for Safari](https://apps.apple.com/us/app/dark-reader-for-safari/id1438243180)
  - [Vimari](https://apps.apple.com/us/app/vimari/id1480933944?mt=12)
  - [SponsorBlock for YouTube](https://apps.apple.com/us/app/sponsorblock-for-youtube/id1573461917)
  - [AdGuard for Safari](https://apps.apple.com/app/adguard-for-safari/id1440147259)
  - [PiPifier](https://apps.apple.com/us/app/pipifier/id1160374471?mt=12)
  - [JSON Peep for Safari](https://apps.apple.com/gb/app/json-peep-for-safari/id1458969831?mt=12)
  - [\_scite](https://apps.apple.com/us/app/scite-extension/id1551820111?mt=12)

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
- [@hardselius/dotfiles](https://github.com/hardselius/dotfiles) <- Brilliant Darwin & NixOS setup
- [@burke/b](https://github.com/burke/b) <- Burke's (Nixology's) in depth setup
- [@jpetrucciani/nix](https://github.com/jpetrucciani/nix) <- Jacobi's clever breakdown (that is simple to implement)
- [@yuanw/nix-home](https://github.com/yuanw/nix-home) <- Yuan's neet packages
- [@lucasew/nixcfg](https://github.com/lucasew/nixcfg) <- Interesting setup with custom (edited with config) packages
- [@alex35mil/dotfiles](https://github.com/alex35mil/dotfiles) <- Another nice and simple setup
- [@jakehamilton/dotfiles](https://github.com/jakehamilton/dotfiles) <- Cool darwin setup with tiling manager and top bar
- [@shaunsing/nix-darwin-dotfiles](https://github.com/shaunsingh/nix-darwin-dotfiles) <- Nicely commented flake
- [@ahmedelgabri/dotfiles](https://github.com/ahmedelgabri/dotfiles/blob/main/flake.nix#L99) <- Interesting shared flake config
- [Sourcegraph](https://sourcegraph.com/search?q=context:global+lang:nix&patternType=standard&sm=1&groupBy=repo) <- Every users public file from GitHub

