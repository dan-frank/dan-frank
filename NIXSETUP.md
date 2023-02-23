# `dan-frank`'s Nix System Configuration 

I'm using Nix to manage my applications and their configurations.
This file will act as a guide for how to setup and run these files.

_This setup is heavily inspired (stolen) from @hardselius' wonderful [dotfiles](https://github.com/hardselius/dotfiles)._

## Setup

|                   | MacOS     | NixOS |
| ----------------- | --------- | ----- |
| Shell             | ZSH       | ?     |
| Window Manager    | Yabai     | ?     |
| Terminal Emulator | Alacritty | ?     |
| Editor            | NeoVim    | ?     |

<!-- ## Screenshots

<details>
    <summary>Terminal</summary>
    <img width="1728" alt="Terminal" src="https://user-images.githubusercontent.com/4244251/213017876-62a7a987-c0ac-4515-87db-df1c809351ef.png">
</details> -->

## Dependencies

- [Nix](https://nixos.org/)
- [Homebrew](https://brew.sh) (_MacOS only_)

## Preliminary Steps / Setup

1. Install Nix

```sh
sh <(curl -L https://nixos.org/nix/install)
```

2. **Open up a new terminal session** and clone this repo into your home directory

```sh
nix-shell -p git
git clone https://github.com/dan-frank/dan-frank ~/.d
```

---

**The following are _MacOS_ only steps**

3. Install Homebrew

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

4. Turn on Mission Control shortcuts

System Settings > Keyboard > Keyboard Shortcuts > Mission Control > Turn on "Switch to Desktop 1 - 9"

5. **Log in** to AppStore

AppStore > Login

6. Install other apps

Some apps are unable to be installed via Nix, or have yet to be configured within this repo.

- [Affinity Suite](https://affinity.serif.com/en-gb/)
- [Logi Options +](https://www.logitech.com/en-gb/software/logi-options-plus.html)

---

## Build Instructions

1. Build the environment from the Nix flake (_call `-x86` if using an intel based mac_)

```
cd ~/.d
nix build \
	--extra-experimental-features nix-command \
	--extra-experimental-features flakes \
	.#darwinConfigurations.macbook-arm.system
./result/sw/bin/darwin-rebuild switch --flake .#macbook-arm
```

2. **Open up a new terminal session** and run the following to apply the configs 

```
cd ~/.d
darwin-rebuild switch --flake .#macbook-arm
```

## Brief Breakdown

### `flake.nix`

Entry point and container of all my config and dependancies.

### `default.nix`

Required for `flake-compat`, which adds flake combatability to non flake supported Nix versions. See [@edolstra/flake-compat](https://github.com/edolstra/flake-compat/blob/master/default.nix).

### `/dotfiles`

`.` dotfiles that I was unable, or have yet, to 'nixify' and are imported as is.

### `/flakes`

A collection of dev shell flakes I use.

### `/home`

Collection of my home-manager configurations.

### `/home/programs`

Programs that are managed by home-manager.

### `/overlays`

This folder contains my personal overlays that don't really need, or have yet, to be pushed into the main nixpkgs repo.

### `/schema`

Holds schema for `flake.nix`.

### `/system`

My dev environments, managed with nixos and darwin. Both called via `flake.nix`.

## Resources & Further Reading

The following links consit of useful resources that I used to learn about Nix and how to set it up, and other users setups that I used for inspiration (or completely ripped off) to improve my config management:

- [Nixology](https://www.youtube.com/playlist?list=PLRGI9KQ3_HP_OFRG6R-p4iFgMSK1t5BHs) ← Great walkthrough of managing your packages and dev envrionment with Nix
- [Intro to Flakes](https://www.youtube.com/watch?v=mJbQ--iBc1U&t=909s) ← Flake tutorial that introduces you to various concpets
- [Moving Nixos System Configuration Into A Flake](https://www.youtube.com/watch?v=mJbQ--iBc1U&t=909s) ← Video tutorial on setting up a flake to manage your system configuration
- [nix-darwin Instructions](https://xyno.space/post/nix-darwin-introduction) ← Blog post about setting up nix-darwin
- [NixOS Flake Tour](https://youtu.be/ARjAsEJ9WVY) ← Interesting view on managing configuration and clever modules explanation
- [@hardselius/dotfiles](https://github.com/hardselius/dotfiles) ← Hardselius' Darwin & NixOS flake configuration (Major inspiration for this repo)
- [@burke/b](https://github.com/burke/b) ← Burke's (Nixology's author) Darwin configuration
- [@jpetrucciani/nix](https://github.com/jpetrucciani/nix) ← Jacobi's quite indepth but relatively simple to read nix configuration
- [@yuanw/nix-home](https://github.com/yuanw/nix-home) ← Yuan's Darwin & NixOS flake configuration
- [@shaunsing/nix-darwin-dotfiles](https://github.com/shaunsingh/nix-darwin-dotfiles) ← Shaun's Darwin & Asahi Linux flake configuration
- [Sourcegraph](https://sourcegraph.com/search?q=context:global+lang:nix&patternType=standard&sm=1&groupBy=repo) ← Public nix files sourced from every public repo on GitHub

## Next Steps

1. Setup packages / services / configurations with modules (more control, can easily create multiple hosts using only specific packages)
1. Update configurations to allow for hosts Work M2 + NixOS VM + Asahi + RaspberryPi
1. Add `.zshhistory` to repo
1. See if I can manage MacOS Keyboard Shortcuts with SKHD or alternative utility
1. Look into if I can [configure Safari settings](https://daiderd.com/nix-darwin/manual/index.html#opt-system.defaults.CustomUserPreferences)
1. Look into resolving this which doesn't work [LnL7/nix-darwin#214](https://github.com/LnL7/nix-darwin/issues/214) & [IvarWithoutBones/dotfiles@0b3faad](https://github.com/IvarWithoutBones/dotfiles/commit/0b3faad8bd1d0e1af6103caf59b206666ab742f4) and removing some brew packages
