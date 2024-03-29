{ pkgs, lib, config, ... }:
let
  cfg = config.shells.bash;
in {
  options.shells.bash = {
    enable = lib.mkEnableOption "Enables bash and configuration";
  };

  config = lib.mkIf cfg.enable {
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
