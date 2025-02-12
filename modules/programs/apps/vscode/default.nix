{ pkgs, lib, config, ... }:
let
  cfg = config.programs.apps.vscode;

  merge = lib.foldr (a: b: a // b) { };
in {
  options.programs.apps.vscode = {
    enable = lib.mkEnableOption "Enables vscode and configuration";
  };

  imports = [
    "${fetchTarball {
      url = "https://github.com/msteen/nixos-vscode-server/tarball/master";
      sha256 = "sha256:0sz8njfxn5bw89n6xhlzsbxkafb6qmnszj4qxy2w0hw2mgmjp829";
    }}/modules/vscode-server/home.nix"
  ];

  config = lib.mkIf cfg.enable {
    services.vscode-server.enable = true;

    programs.vscode = {
      enable = true;
      # package = pkgs.vscodium; #pkgs.vscode.fhs;
      userSettings = merge [
        (import ./settings/editor.nix { inherit config; })
        (import ./settings/git.nix)
        (import ./settings/languages.nix pkgs)
        (import ./settings/search.nix)
      ];
      extensions = import ./extensions.nix { pkgs = pkgs; };
    };
  };
}
