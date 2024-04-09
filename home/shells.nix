{ config, pkgs, lib, ... }:
let
  inherit (config.home) user-info;
in
{
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    EMAIL = "${user-info.email}";
    PAGER = "${pkgs.less}/bin/less";
    CLICOLOR = 1;
    PATH = "$PATH:$HOME/.local/bin:$HOME/.tfenv/bin";
  };

  home.shellAliases = {
    # Git
    gst = "git status";
    ga = "git add";
    gaa = "git add --all";
    gc = "git commit";
    gb = "git branch";
    gco = "git checkout";
    gf = "git fetch";
    gl = "git pull";
    gp = "git push";
    gd = "git diff";
    gblm = "git blame -w -C -C -C";
    gs = "git stash --include-untracked";
    glg = "git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit";
    gr = "git rm";
    gra = "git rm `git status | grep deleted | awk '{print $2}'`";

    # RipGrep
    rgf = "rg --files | rg";

    # Basic console commands
    stdssh = "TERM=xterm-256color ssh"; # SSH in common term mode

    # Navigation
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
    "....." = "cd ../../../..";
    "......" = "cd ../../../../..";

    # Scala
    scalafmt = "sbt -mem 8192 scalafmtAll";
    sbtcleanup = "rm -rf .bsp project target";

    # Helpful
    cleanDsStore = "find . -name \".DS_Store\" -print -type f -delete";

    # Name shortening
    ":q" = "exit";
    docc = "docker-compose";
    v = "nvim .";
  } // lib.optionalAttrs pkgs.stdenv.isDarwin {
    # Homebrew - TODO Remove / integrate into nix-darwin
    brewuu = "brew update; brew upgrade";

    # What fonts?
    myfonts = "atsutil fonts -list";
  };
}
