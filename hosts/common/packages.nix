{ pkgs, ... }:
let
  jcurl = import ./../../scripts/jcurl.nix { inherit pkgs; };
in {
  environment.systemPackages = with pkgs; [
    alacritty
    git
    vscode

    # Scripts
    jcurl
  ];
}
