{ config, pkgs, lib, ... }:
{
  programs.bash = {
    enable = true;
    initExtra = ''
      eval "$(direnv hook bash)"

      # Load private vars
      if [[ -f ~/.private_vars ]]; then
        source ~/.private_vars
      fi
    '';
  };
}
