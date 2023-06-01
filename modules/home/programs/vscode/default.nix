{ config, lib, pkgs, ... }:
let
  merge = lib.foldr (a: b: a // b) { };
in {
  imports = [
    "${fetchTarball {
      url = "https://github.com/msteen/nixos-vscode-server/tarball/master";
      sha256 = "sha256:0ahgyd2swkapimvf70ah2y55wpn2hdh1wymfh6492xrkv5x91sqz";
    }}/modules/vscode-server/home.nix"
  ];

  services.vscode-server.enable = true;

  programs.vscode = {
    enable = true;
    # package = pkgs.vscodium; #pkgs.vscode.fhs;
    userSettings = merge [
      (import ./settings/editor.nix)
      (import ./settings/git.nix)
      (import ./settings/languages.nix pkgs)
      (import ./settings/remote-ssh.nix)
      (import ./settings/search.nix)
    ];
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      # bierner.emojisense
      bierner.markdown-checkbox
      bierner.markdown-emoji
      bradlc.vscode-tailwindcss
      eamodio.gitlens
      gencer.html-slim-scss-css-class-completion
      github.github-vscode-theme
      gruntfuggly.todo-tree
      matklad.rust-analyzer
      mhutchie.git-graph
      ms-vscode-remote.remote-ssh
      naumovs.color-highlight
      pkief.material-icon-theme
      scala-lang.scala
      scalameta.metals
      shardulm94.trailing-spaces
      usernamehw.errorlens
      vscodevim.vim
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "vscode-pets";
        publisher = "tonybaloney";
        version = "1.2.2";
        sha256 = "0zd0n9f5z1f0ckzfjr38xw2zzmcxg1gjrava7yahg5cvdcw6l35b";
      }
    ];
  };
}
