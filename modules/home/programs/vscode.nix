{ config, lib, pkgs, ... }:
let
  font = {
    family = "'Terminus (TTF)', sans-serif";
    size = 15;
  };
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
    userSettings = {
      "diffEditor.ignoreTrimWhitespace" = true;
      "editor.bracketPairColorization.enabled" = true;
      "editor.detectIndentation" = false;
      "editor.fontFamily" = font.family;
      "editor.fontSize" = font.size;
      "editor.fontWeight" = "normal";
      "editor.guides.bracketPairs" = true;
      "editor.insertSpaces" = true;
      "editor.lineNumbers" = "relative";
      "editor.tabSize" = 2;
      "files.exclude" = {
        "**/.classpath" = true;
        "**/.project" = true;
        "**/.settings" = true;
        "**/.factorypath" = true;
      };
      "files.watcherExclude" = {
        "**/.bloop" = true;
        "**/.metals" = true;
        "**/.ammonite" = true;
      };
      "git.autofetch" = false;
      "gitlens.advanced.messages" = {
        "suppressFileNotUnderSourceControlWarning" = true;
      };
      "java.semanticHighlighting.enabled" = true;
      "metals.javaHome" = "${pkgs.jdk}";
      "php.validate.executablePath" = "${pkgs.php81}/bin/php";
      "remote.SSH.defaultExtensions" = [
        "bbenoist.nix"
        # "bierner.emojisense"
        "bierner.markdown-checkbox"
        "bierner.markdown-emoji"
        "bradlc.vscode-tailwindcss"
        "eamodio.gitlens"
        "gencer.html-slim-scss-css-class-completion"
        "github.github-vscode-theme"
        "gruntfuggly.todo-tree"
        "matklad.rust-analyzer"
        "mhutchie.git-graph"
        "ms-vscode-remote.remote-ssh"
        "naumovs.color-highlight"
        "pkief.material-icon-theme"
        "scala-lang.scala"
        "scalameta.metals"
        "shardulm94.trailing-spaces"
        "tonybaloney.vscode-pets"
        "usernamehw.errorlens"
        "vscodevim.vim"
      ];
      "window.zoomLevel" = 0.5;
      "workbench.colorTheme" = "GitHub Dark";
      "workbench.iconTheme" = "material-icon-theme";
    };
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
