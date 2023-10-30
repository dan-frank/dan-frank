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
    aliases = {
      hssmerge = ''
        !f() { \
          git checkout master && git reset --hard origin/master; \
          count=$(git rev-list --count $1 ^master); \
          if [ "$count" -gt "1" ];then ff="--no-ff";else ff="--ff-only"; fi; \
          git merge $ff $1 && git push -f origin $1 && git push origin master && git push origin --delete $1; \
        }; f $1;
      '';
    };
  };
}
