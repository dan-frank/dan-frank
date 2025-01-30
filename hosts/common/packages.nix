{ pkgs, ... }:
let
  jcurl = import ./../../scripts/jcurl.nix { inherit pkgs; };
in {
  environment.systemPackages = with pkgs; [
    git
    vscode

    # Scripts
    jcurl
  ];
}
