# IDEAS:
#  - https://www.youtube.com/playlist?list=PLRGI9KQ3_HP_OFRG6R-p4iFgMSK1t5BHs
#  - https://github.com/burke/b/blob/master/etc/nix/home.nix
#  - https://github.com/nix-community/home-manager/blob/master/modules/programs/zsh.nix
#  - https://sourcegraph.com/github.com/jbuchermn/dotfiles-nix/-/blob/users/common/zsh.nix
#  - https://sourcegraph.com/github.com/sagikazarmark/nix-config/-/blob/home.nix
#  - https://sourcegraph.com/github.com/MatthiasBenaets/nixos-config/-/blob/darwin/home.nix

# https://sourcegraph.com/github.com/NixOS/nixpkgs/-/tree/pkgs/shells/zsh
pkgs: {
  enable = true;
  enableCompletion = true;
  enableAutosuggestions = true;
  history = {
  #   path = "${relativeXDGDataPath}/zsh/.zsh_history";
    size = 50000;
    save = 50000;
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
    bindkey '^[[A' up-line-or-search
    bindkey '^[[B' down-line-or-search
    bindkey -M vicmd 'k' up-line-or-search
    bindkey -M vicmd 'j' down-line-or-search
    bindkey '\ew' kill-region                             # [Esc-w] - Kill from the cursor to the mark
    bindkey -s '\el' 'ls\n'                               # [Esc-l] - run command: ls
    bindkey ' ' magic-space                               # [Space] - don't do history expansion

    # Change auto suggest color
    # - fg=[https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg]
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=013'

    # Load colors for prettier `ls`
    eval $(dircolors ~/.nix-profile/share/LS_COLORS)

    # Call neofetch on load
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
  shellAliases = {
    # Config
    nixconf = "cd ~/.config/nixpkgs";
    zshconf = "vim ~/.config/nixpkgs/configs/zsh.nix";
    vimconf = "vim ~/.config/nixpkgs/configs/neovim.nix";

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

    # Terminal.news
    bitnews = "curl https://terminal.news | less";

    # Nix
    # nixre = "darwin-rebuild switch";
    # nixgc = "nix-collect-garbage -d";
    # nixq = "nix-env -qaP";
    # nixupgrade = "sudo -i sh -c 'nix-channel --update && nix-env -iA nixpkgs.nix && launchctl remove org.nixos.nix-daemon && launchctl load /Library/LaunchDaemons/org.nixos.nix-daemon.plist'";
    # nixup = "nix-env -u";
    # nixcfg = "nvim ~/.nixpkgs/darwin-configuration.nix";

    # Command replacements
    ls = "ls --color=auto -F";

    ## Basic console commands
    ll = "ls -l";
    la = "ls -a";
    lla = "ls -la";

    # Homebrew - TODO Remove!
    brewuu = "brew update; brew upgrade";

    # Wordpress
    wpinstall = "curl -LO https://wordpress.org/latest.zip; unzip latest.zip; rm latest.zip";
    wpdocker = "~/Documents/Projects/scripts/new-docker-wp-environment/new-docker-wordpress.sh";
    twsdocker = "~/Documents/Work/the-website-space/git/tws_dev_scripts/newWebProject/newWebProject.sh";

    # Get public key
    pubkey = "pbcopy < ~/.ssh/id_rsa.pub";

    # Natural Transformation
    ntssh = "ssh daniel@ntworkstation.hopto.org -p 26";
    ntlocalhost = "open http://ntworkstation.hopto.org:9005";

    # Mac Keyboard
    keyoff = "sudo kextunload /System/Library/Extensions/AppleUSBTopCase.kext/Contents/PlugIns/AppleUSBTCKeyb oard.kext/";
    keyon = "sudo kextload /System/Library/Extensions/AppleUSBTopCase.kext/Contents/PlugIns/AppleUSBTCKeyb oard.kext/";

    # Shortcuts
    scalaplay = "code ~/Documents/Projects/scala/playground";
    leet = "code ~/Documents/Projects/leetcode";
  };

  sessionVariables = rec {
    NVIM_TUI_ENABLE_TRUE_COLOR = "1";

    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=3";
    DEV_ALLOW_ITERM2_INTEGRATION = "1";

    EDITOR = "vim";
    VISUAL = EDITOR;
    GIT_EDITOR = EDITOR;
  };
}

