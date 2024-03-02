{ config, pkgs, lib, ... }:
let
  inherit (config.home) homeDirectory;

  # TODO: Move to nix flake
  LS_COLORS = pkgs.fetchFromGitHub {
    owner = "trapd00r";
    repo = "LS_COLORS";
    rev = "a75fca8545f91abb8a5f802981033ef54bf1eac0";
    sha256="1lzj0qnj89mzh76ha137mnz2hf86k278rh0y9x124ghxj9yqsnb4";
  };
in
{
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

      # Load colors for prettier `ls`
      eval $(dircolors -b ${LS_COLORS}/LS_COLORS)

      # Little bit of visual flair on shell start
      typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

      # Shell prompts -> neofetch / freshfetch / macchina
      ${pkgs.macchina}/bin/macchina
 
      # Load private vars
      if [[ -f ~/.private_vars ]]; then
        source ~/.private_vars
      fi
    '';
    plugins = (import ./config/plugins.nix { inherit pkgs; } );

    sessionVariables = rec {
      NVIM_TUI_ENABLE_TRUE_COLOR = "1";
      DEV_ALLOW_ITERM2_INTEGRATION = "1";
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=013"; # (colors)[https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg]
    };
  };
}
