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
      (import ./settings/tabnine.nix)
    ];
    extensions = import ./extensions.nix { pkgs = pkgs; };
  };
}
