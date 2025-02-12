{ pkgs }:
with pkgs.vscode-extensions;
[
  bbenoist.nix
  bierner.markdown-checkbox
  bierner.markdown-emoji
  bradlc.vscode-tailwindcss
  eamodio.gitlens
  gencer.html-slim-scss-css-class-completion
  github.copilot
  gruntfuggly.todo-tree
  rust-lang.rust-analyzer
  mechatroner.rainbow-csv
  mhutchie.git-graph
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
]
