{ pkgs, ... }:
let
  mergeFiles = files: builtins.concatStringsSep " " (map builtins.readFile files);
in
mergeFiles [
  ./source.css
  ./tweaks.css
]
