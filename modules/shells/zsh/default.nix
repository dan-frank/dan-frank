{ pkgs, lib, config, ... }:
let
  cfg = config.shells.zsh;

  inherit (config.home) homeDirectory;
in {
  options.shells.zsh = {
    enable = lib.mkEnableOption "Enables zsh and configuration";
  };

  config = lib.mkIf cfg.enable {
    home.file = {
      ".p10k.zsh".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/p10k.zsh;
    };

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      # dotDir = "${homeDirectory}/.config/.zsh";
      history = {
        # path = config.programs.zsh.dotDir + "/.zsh_history";
        size = 50000;
        save = 500000;
        ignoreDups = true;
        share = true;
      };
      initExtraBeforeCompInit = ''
        # Source P10K
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      '';
      initExtra = ''
        # Bindings
        autoload -U history-search-end
        zle -N history-beginning-search-backward-end history-search-end
        zle -N history-beginning-search-forward-end history-search-end
        bindkey '^[[A' history-beginning-search-backward-end
        bindkey '^[[B' history-beginning-search-forward-end
        bindkey -M vicmd 'k' history-beginning-search-backward-end
        bindkey -M vicmd 'j' history-beginning-search-forward-end
        bindkey ' ' magic-space                               # [Space] - don't do history expansion

        # Brew
        export PATH="/opt/homebrew/bin:$PATH"

        # Little bit of visual flair on shell start
        typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

        # Shell prompts -> neofetch / freshfetch / macchina
        ${pkgs.macchina}/bin/macchina
   
        # Load private vars
        if [[ -f ~/.private_vars ]]; then
          source ~/.private_vars
        fi
      '';
      plugins = (import ./plugins.nix { inherit pkgs; } );

      sessionVariables = rec {
        NVIM_TUI_ENABLE_TRUE_COLOR = "1";
        DEV_ALLOW_ITERM2_INTEGRATION = "1";
      };
    };
  };
}
