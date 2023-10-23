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
    gco = "git checkout";
    gl = "git pull";
    glom = "git pull origin main";
    gp = "git push";
    gd = "git diff";
    gb = "git branch";
    gba = "git branch -a";
    del = "git branch -d";
    glg = "git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit";
    gr = "git rm";
    gra = "git rm `git status | grep deleted | awk '{print $2}'`";
    gh = "git log -p --follow --";
    git-fuck-everything = "git-abort; git reset .; git checkout .; git clean -f -d";

    # RipGrep
    rgf = "rg --files | rg";

    # Basic console commands
    stdssh = "TERM=xterm-256color ssh"; # SSH in common term mode
    ls = "ls --color=auto -F";
    ll = "ls -l";
    la = "ls -a";
    lla = "ls -la";

    # Navigation
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
    "....." = "cd ../../../..";
    "......" = "cd ../../../../..";

    # Scala
    scalafmt = "sbt -mem 16384 scalafmt";

    # Name shortening
    docc = "docker-compose";

    # HSS
    hss-ssh = "stdssh -L 5901:localhost:5901 -o StrictHostKeychecking=no -i ~/.ssh/dan-frank_cloud_dev_env.pem ec2-user@clouddev.local";
    hss-hyrax = "git clone https://github.com/HSS-Proservice/hyrax.git";
    hss-merge = "git hssmerge";
  } // lib.optionalAttrs pkgs.stdenv.isDarwin {
    # Homebrew - TODO Remove / integrate into nix-darwin
    brewuu = "brew update; brew upgrade";

    # What fonts?
    myfonts = "atsutil fonts -list";
  };
}
