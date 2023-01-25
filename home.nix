# Setup ideas
# - https://sourcegraph.com/github.com/knl/dotskel/-/blob/home.nix?L532:17
# - [zsh plugin func] https://sourcegraph.com/github.com/Icy-Thought/Snowflake/-/blob/modules/shell/zsh.nix

# { config, pkgs, ... }:
let
  # pkgs = import <nixpkgs> { };
  pkgs = import ./default.nix { };

  LS_COLORS = pkgs.fetchgit {
    url = "https://github.com/trapd00r/LS_COLORS";
    sha256 = "KsVuHBd4CzAWDeobS0N4NW+z1KMK1kBnZg14g67SCeQ=";
  };
  ls-colors = pkgs.runCommand "ls-colors" {} ''
    mkdir -p $out/bin $out/share
    ln -s ${pkgs.coreutils}/bin/ls $out/bin/ls
    ln -s ${pkgs.coreutils}/bin/dircolors $out/bin/dircolors
    cp ${LS_COLORS}/LS_COLORS $out/share/LS_COLORS
  '';
in {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "dan";
  home.homeDirectory = "/Users/dan";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Packages
  nixpkgs.config = {
    allowUnfree = true;
  };

  home.packages = with pkgs; [
    # Window Manager for Mac -> https://github.com/koekeishiya/yabai
    
    # Theme
    nerdfonts

    # CLI Tools
    ripgrep
    vifm
    ls-colors
    bottom
    neofetch
    # macchina
    tree

    # Apps
    vscode # Code editor
    utm # Virtual machine

    # Fun
    asciiquarium
    cmatrix
    cowsay
    lolcat
  ];

  home.file = {
    ".hushlogin".text = "";
  };

  programs.git = {
    enable = true;
    userName = "dan-frank";
    userEmail = "dan.frank.lucas@gmail.com";
    extraConfig = {
      core.editor = "vim";
      pull.rebase = "false";
    };
  };

  # IDEAS:
  #  - https://www.youtube.com/playlist?list=PLRGI9KQ3_HP_OFRG6R-p4iFgMSK1t5BHs
  #  - https://github.com/burke/b/blob/master/etc/nix/home.nix
  #  - https://github.com/nix-community/home-manager/blob/master/modules/programs/zsh.nix
  #  - https://sourcegraph.com/github.com/jbuchermn/dotfiles-nix/-/blob/users/common/zsh.nix
  #  - https://sourcegraph.com/github.com/sagikazarmark/nix-config/-/blob/home.nix
  #  - https://sourcegraph.com/github.com/MatthiasBenaets/nixos-config/-/blob/darwin/home.nix

  # https://sourcegraph.com/github.com/NixOS/nixpkgs/-/tree/pkgs/shells/zsh
  programs.zsh = {
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
      neofetch
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
      # {
      #   file = "zsh-you-should-use.plugin.zsh";
      #   name = "zsh-you-should-use";
      #   src = "${pkgs.zsh-you-should-use}/share/zsh/zsh-you-should-use";
      # }
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
      # zshconfig = "vim ~/.zshrc && source ~/.zshrc";
      # aliasconfig = "vim ~/.oh-my-zsh/custom/aliases.zsh && source ~/.zshrc";
      # vimconfig = "vim ~/.vimrc";
      # nixconfig = "vim /etc/nix/nix.conf";

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
  };

  programs.alacritty = {
    enable = true;
    settings = {
      bell = {
        animation = "EaseOutExpo";
        duration = 5;
        color = "#ffffff";
      };
      font = {
        size = 14;
        normal.family = "MesloLGS NF";
        # normal.family = "Liga SFMono Nerd Font";
        # normal.style = "Light";
        # bold.family = "Liga SFMono Nerd Font";
        # bold.style = "Bold";
        # italic.family = "Liga SFMono Nerd Font";
        # italic.style = "Italic";
      };
      # GitHub Theme
      # -> https://gist.github.com/huytd/6e76206fb02267c5da5018f725693862?permalink_comment_id=3681421
      colors = {
        primary = {
          background = "#252729";
          foreground = "#e0e2e4";
        };
        normal = {
          black = "#474646";
          red = "#f97583";
          green = "#85e89d";
          yellow = "#ffab70";
          blue = "#79b8ff";
          magenta = "#b392f0";
          cyan = "#9ecbff";
          white = "#e0e2e4";
        };
        bright = {
          black = "#282828";
          red = "#fdaeb7";
          green = "#bef5cb";
          yellow = "#fff5b1";
          blue = "#c8e1ff";
          magenta = "#d1bcf9";
          cyan = "#b3f0ff";
          white = "#e1e4e8";
        };
      };
      key_bindings = [
        { key = "Key0"; mods = "Alt"; chars = "º"; }
        { key = "Key1"; mods = "Alt"; chars = "¡"; }
        { key = "Key2"; mods = "Alt"; chars = "€"; }
        { key = "Key3"; mods = "Alt"; chars = "#"; }
        { key = "Key4"; mods = "Alt"; chars = "¢"; }
        { key = "Key5"; mods = "Alt"; chars = "∞"; }
        { key = "Key6"; mods = "Alt"; chars = "§"; }
        { key = "Key7"; mods = "Alt"; chars = "¶"; }
        { key = "Key8"; mods = "Alt"; chars = "•"; }
        { key = "Key9"; mods = "Alt"; chars = "ª"; }
        { key = "N"; mods = "Command|Shift"; action = "SpawnNewInstance"; }
      ];
      # ??? https://sourcegraph.com/github.com/NeQuissimus/DevSetup/-/blob/users/nequi/home/alacritty.nix
      selection.save_to_clipboard = true;
      # shell.program = "${pkgs.zsh}/bin/zsh";
      window = {
        decorations = "Transparent"; # Full | Transparent | Buttonless | None
        opacity = 1.00;
        padding = {
          x = 12;
          y = 12;
        };
      };
      mouse = {
        hints = {
          launcher = {
            program = "open"; # Mac only -> need !isDarwin alt option
            modifiers = "Command";
          };
        };
      };
    };
  };

  programs.neovim = import ./config/neovim.nix pkgs;
  programs.vscode = import ./config/vscode.nix pkgs;
  programs.bat = import ./config/bat.nix pkgs;
}

