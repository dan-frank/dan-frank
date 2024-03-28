{ pkgs, lib, config, ... }:
{
  options = {
    bash.enable = lib.mkEnableOption "Enables bash and configuration";
  };

  config = lib.mkIf config.bash.enable {
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
  };
}
