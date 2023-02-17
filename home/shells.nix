{ config, pkgs, lib, ... }:
let
  inherit (config.home) user-info;
in
{
  home.sessionVariables = {
    EDITOR = "${pkgs.neovim}/bin/nvim";
    VISUAL = "${pkgs.neovim}/bin/nvim";
    EMAIL = "${user-info.email}";
    PAGER = "${pkgs.less}/bin/less";
    CLICOLOR = 1;
    PATH = "$PATH:$HOME/.local/bin:$HOME/.tfenv/bin";
  };

  home.shellAliases = {
    # Git
    gst = "git status";
    ga = "git add";
    gaa = "git add --all";
    gc = "git commit";
    gco = "git checkout";
    gl = "git pull";
    glom = "git pull origin main";
    gp = "git push";
    gd = "git diff";
    gb = "git branch";
    gba = "git branch -a";
    del = "git branch -d";
    glg = "git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit";
    gr = "git rm";
    gra = "git rm `git status | grep deleted | awk '{print $2}'`";
    gh = "git log -p --follow --";
    git-fuck-everything = "git-abort; git reset .; git checkout .; git clean -f -d";

    # RipGrep
    alias = "rgf='rg --files | rg'";

    # Basic console commands
    ls = "ls --color=auto -F";
    ll = "ls -l";
    la = "ls -a";
    lla = "ls -la";

    # Get public key
    pubkey = "pbcopy < ~/.ssh/id_rsa.pub";

    # Natural Transformation
    ntssh = "ssh daniel@ntworkstation.hopto.org -p 26";
    ntlocalhost = "open http://ntworkstation.hopto.org:9005";
  } // lib.optionalAttrs pkgs.stdenv.isDarwin {
    # Homebrew - TODO Remove / integrate into nix-darwin
    brewuu = "brew update; brew upgrade";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    history = {
      # path = "${relativeXDGDataPath}//.zsh_history";
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
      # Plugins -> Try to move to plugins = [ ]
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      source ${pkgs.zsh-you-should-use}/share/zsh/plugins/you-should-use/you-should-use.plugin.zsh

      # Bindings
      autoload -U history-search-end
      zle -N history-beginning-search-backward-end history-search-end
      zle -N history-beginning-search-forward-end history-search-end
      bindkey '^[[A' history-beginning-search-backward-end
      bindkey '^[[B' history-beginning-search-forward-end
      bindkey -M vicmd 'k' history-beginning-search-backward-end
      bindkey -M vicmd 'j' history-beginning-search-forward-end
      bindkey ' ' magic-space                               # [Space] - don't do history expansion

      # Change auto suggest color
      # - fg=[https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg]
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=013'

      # Load colors for prettier `ls`
      eval $(dircolors ~/.nix-profile/share/LS_COLORS)

      # Little bit of visual flair on shell start
      typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
      freshfetch
    '';
    # https://github.com/unixorn/awesome-zsh-plugins
    plugins = [
      {
        file = "powerlevel10k.zsh-theme";
        name = "powerlevel10k";
        src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k";
      }
      # {
      #   name = "git";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "zsh-users";
      #     repo = "git";
      #     rev = "v0.6.3";
      #     sha256 = "1h8h2mz9wpjpymgl2p7pc146c1jgb3dggpvzwm9ln3in336wl95c";
      #   };
      # }
      {
        file = "zsh-vi-mode.plugin.zsh";
        name = "zsh-vi-mode";
        src = "${pkgs.zsh-vi-mode}/share/zsh/zsh-vi-mode";
      }
      {
        file = "history-search-multi-word.plugin.zsh";
        name = "history-search-mutli-word";
        src = "${pkgs.zsh-history-search-multi-word}/share/zsh/zsh-history-search-multi-word";
      }
      {
        file = "fast-syntax-highlighting.plugin.zsh";
        name = "zsh-fast-syntax-highlighting";
        src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
      }
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.6.3";
          sha256 = "1h8h2mz9wpjpymgl2p7pc146c1jgb3dggpvzwm9ln3in336wl95c";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "be3882aeb054d01f6667facc31522e82f00b5e94";
          sha256 = "0w8x5ilpwx90s2s2y56vbzq92ircmrf0l5x8hz4g1nx3qzawv6af";
        };
      }
      {
        name = "zsh-completions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-completions";
          rev = "v0.34.0";
          sha256 = "0w8x5ilpwx90s2s2y56vbzq92ircmrf0l5x8hz4g1nx3qzawv6af";
        };
      }
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.5.0";
          sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
        };
      }
    ];

    sessionVariables = rec {
      NVIM_TUI_ENABLE_TRUE_COLOR = "1";

      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=3";
      DEV_ALLOW_ITERM2_INTEGRATION = "1";
    };
  };
}
