{ config, pkgs, lib, ... }:
let
  # ! Move to nix flake
  LS_COLORS = pkgs.fetchFromGitHub {
    owner = "trapd00r";
    repo = "LS_COLORS";
    rev = "a75fca8545f91abb8a5f802981033ef54bf1eac0";
    sha256="1lzj0qnj89mzh76ha137mnz2hf86k278rh0y9x124ghxj9yqsnb4";
  };
in
{
  programs.bash = {
    enable = true;
    initExtra = ''
      eval "$(direnv hook bash)"
      eval $(dircolors -b ${LS_COLORS}/LS_COLORS)
    '';
  };
}
