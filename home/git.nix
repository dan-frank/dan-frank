{ config, pkgs, lib, ... }:
let
  inherit (config.home) user-info;
in
{
  programs.git = {
    enable = true;
    package = pkgs.pkgs-stable.git;
    userName = user-info.fullName;
    userEmail = user-info.email;
    ignores = [
      ".DS_Store"
    ];
    extraConfig = {
      color.ui = "auto";
      core = {
        editor = "${pkgs.neovim}/bin/nvim";
        trustctime = false;
        logAllRefUpdates = true;
        precomposeunicode = true;
        whitespace = "trailing-space,space-before-tab";
      };
      github.user = user-info.github;
      pull.rebase = "false";
    };
  };
}
