# Setup ideas
# - https://sourcegraph.com/github.com/knl/dotskel/-/blob/home.nix?L532:17
# - [zsh plugin func] https://sourcegraph.com/github.com/Icy-Thought/Snowflake/-/blob/modules/shell/zsh.nix

{ config, pkgs, ... }:
let
  pkgs = import <nixpkgs> { };

  github-nvim-theme = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "github-nvim-theme";
    src = pkgs.fetchFromGitHub {
      owner = "projekt0n";
      repo = "github-nvim-theme";
      rev = "b3f15193d1733cc4e9c9fe65fbfec329af4bdc2a";
      sha256 = "wLX81wgl4E50mRig9erbLyrxyGbZllFbHFAQ9+v60W4=";
    };
  };

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
      # GitHub Dark - https://gist.github.com/huytd/6e76206fb02267c5da5018f725693862?permalink_comment_id=3681421
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
          black = "0x686868";
          red = "0xF07178";
          green = "0xC2D94C";
          yellow = "0xFFB454";
          blue = "0x59C2FF";
          magenta = "0xFFEE99";
          cyan = "0x95E6CB";
          white = "0xFFFFFF";
        };
      };
      # key_bindings = [
      #   # { key = 53; mods = "Shift"; mode = "Vi"; action = "SearchBackward"; }
      #   { key = "A"; mods = "Alt"; chars = "\x1ba"; }
      #   { key = "B"; mods = "Alt"; chars = "\x1bb"; }
      #   { key = "C"; mods = "Alt"; chars = "\x1bc"; }
      #   { key = "D"; mods = "Alt"; chars = "\x1bd"; }
      #   { key = "E"; mods = "Alt"; chars = "\x1be"; }
      #   { key = "F"; mods = "Alt"; chars = "\x1bf"; }
      #   { key = "G"; mods = "Alt"; chars = "\x1bg"; }
      #   { key = "H"; mods = "Alt"; chars = "\x1bh"; }
      #   { key = "I"; mods = "Alt"; chars = "\x1bi"; }
      #   { key = "J"; mods = "Alt"; chars = "\x1bj"; }
      #   { key = "K"; mods = "Alt"; chars = "\x1bk"; }
      #   { key = "L"; mods = "Alt"; chars = "\x1bl"; }
      #   { key = "M"; mods = "Alt"; chars = "\x1bm"; }
      #   { key = "N"; mods = "Alt"; chars = "\x1bn"; }
      #   { key = "O"; mods = "Alt"; chars = "\x1bo"; }
      #   { key = "P"; mods = "Alt"; chars = "\x1bp"; }
      #   { key = "Q"; mods = "Alt"; chars = "\x1bq"; }
      #   { key = "R"; mods = "Alt"; chars = "\x1br"; }
      #   { key = "S"; mods = "Alt"; chars = "\x1bs"; }
      #   { key = "T"; mods = "Alt"; chars = "\x1bt"; }
      #   { key = "U"; mods = "Alt"; chars = "\x1bu"; }
      #   { key = "V"; mods = "Alt"; chars = "\x1bv"; }
      #   { key = "W"; mods = "Alt"; chars = "\x1bw"; }
      #   { key = "X"; mods = "Alt"; chars = "\x1bx"; }
      #   { key = "Y"; mods = "Alt"; chars = "\x1by"; }
      #   { key = "Z"; mods = "Alt"; chars = "\x1bz"; }
      #   { key = "A"; mods = "Alt|Shift"; chars = "\x1bA"; }
      #   { key = "B"; mods = "Alt|Shift"; chars = "\x1bB"; }
      #   { key = "C"; mods = "Alt|Shift"; chars = "\x1bC"; }
      #   { key = "D"; mods = "Alt|Shift"; chars = "\x1bD"; }
      #   { key = "E"; mods = "Alt|Shift"; chars = "\x1bE"; }
      #   { key = "F"; mods = "Alt|Shift"; chars = "\x1bF"; }
      #   { key = "G"; mods = "Alt|Shift"; chars = "\x1bG"; }
      #   { key = "H"; mods = "Alt|Shift"; chars = "\x1bH"; }
      #   { key = "I"; mods = "Alt|Shift"; chars = "\x1bI"; }
      #   { key = "J"; mods = "Alt|Shift"; chars = "\x1bJ"; }
      #   { key = "K"; mods = "Alt|Shift"; chars = "\x1bK"; }
      #   { key = "L"; mods = "Alt|Shift"; chars = "\x1bL"; }
      #   { key = "M"; mods = "Alt|Shift"; chars = "\x1bM"; }
      #   { key = "N"; mods = "Alt|Shift"; chars = "\x1bN"; }
      #   { key = "O"; mods = "Alt|Shift"; chars = "\x1bO"; }
      #   { key = "P"; mods = "Alt|Shift"; chars = "\x1bP"; }
      #   { key = "Q"; mods = "Alt|Shift"; chars = "\x1bQ"; }
      #   { key = "R"; mods = "Alt|Shift"; chars = "\x1bR"; }
      #   { key = "S"; mods = "Alt|Shift"; chars = "\x1bS"; }
      #   { key = "T"; mods = "Alt|Shift"; chars = "\x1bT"; }
      #   { key = "U"; mods = "Alt|Shift"; chars = "\x1bU"; }
      #   { key = "V"; mods = "Alt|Shift"; chars = "\x1bV"; }
      #   { key = "W"; mods = "Alt|Shift"; chars = "\x1bW"; }
      #   { key = "X"; mods = "Alt|Shift"; chars = "\x1bX"; }
      #   { key = "Y"; mods = "Alt|Shift"; chars = "\x1bY"; }
      #   { key = "Z"; mods = "Alt|Shift"; chars = "\x1bZ"; }
      #   { key = "Key1"; mods = "Alt"; chars = "\x1b1"; }
      #   { key = "Key2"; mods = "Alt"; chars = "\x1b2"; }
      #   { key = "Key3"; mods = "Alt"; chars = "\x1b3"; }
      #   { key = "Key4"; mods = "Alt"; chars = "\x1b4"; }
      #   { key = "Key5"; mods = "Alt"; chars = "\x1b5"; }
      #   { key = "Key6"; mods = "Alt"; chars = "\x1b6"; }
      #   { key = "Key7"; mods = "Alt"; chars = "\x1b7"; }
      #   { key = "Key8"; mods = "Alt"; chars = "\x1b8"; }
      #   { key = "Key9"; mods = "Alt"; chars = "\x1b9"; }
      #   { key = "Key0"; mods = "Alt"; chars = "\x1b0"; }
      #   { key = "Space"; mods = "Control"; chars = "\x00" ; } # Ctrl + Space
      #   { key = "Grave"; mods = "Alt"; chars = "\x1b`"; } # Alt + `
      #   { key = "Grave"; mods = "Alt|Shift"; chars = "\x1b~"; } # Alt + ~
      #   { key = "Period"; mods = "Alt"; chars = "\x1b."; } # Alt + .
      #   { key = "Key8"; mods = "Alt|Shift"; chars = "\x1b*"; } # Alt + *
      #   { key = "Key3"; mods = "Alt|Shift"; chars = "\x1b#"; } # Alt + #
      #   { key = "Period"; mods = "Alt|Shift"; chars = "\x1b>"; } # Alt + >
      #   { key = "Comma"; mods = "Alt|Shift"; chars = "\x1b<"; } # Alt + <
      #   { key = "Minus"; mods = "Alt|Shift"; chars = "\x1b_"; } # Alt + _
      #   { key = "Key5"; mods = "Alt|Shift"; chars = "\x1b%"; } # Alt + %
      #   { key = "Key6"; mods = "Alt|Shift"; chars = "\x1b^"; } # Alt + ^
      #   { key = "Backslash"; mods = "Alt"; chars = "\x1b\\"; } # Alt + \
      #   { key = "Backslash"; mods = "Alt|Shift"; chars = "\x1b|"; } # Alt + |
      # ];
      # ??? https://sourcegraph.com/github.com/NeQuissimus/DevSetup/-/blob/users/nequi/home/alacritty.nix
      selection.save_to_clipboard = true;
      # shell.program = "${pkgs.zsh}/bin/zsh";
      window = {
        decorations = "full";
        opacity = 1.00;
        padding = {
          x = 12;
          y = 12;
        };
      };
    };
  };

  # Helpful
  # - https://sourcegraph.com/github.com/cbrewster/nix-home/-/blob/home/neovim.nix
  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = ''
      syntax on
      set laststatus=2
      set softtabstop=2
      set tabstop=2
      set shiftwidth=2
      set expandtab
      set autoindent
      set showmatch
      set number relativenumber
      set wrap
      set encoding=utf-8

      lua << EOF
      require('github-theme').setup({
          theme_style = 'dark',
          dark_float = true,
      })
      EOF
    '';
    plugins = with pkgs.vimPlugins; [
      # Languages
      vim-nix
      vim-scala

      # Themes
      github-nvim-theme
      rainbow_parentheses
      tagbar

      # Utility
      ctrlp
      # deoplete
    ];
  };

  programs.vscode.enable = true;

  programs.bat = {
    enable = true;
    config = {
      # Create custom GitHub Dark theme -> https://github.com/sharkdp/bat#adding-new-themes
      theme = "TwoDark";
      italic-text = "always";
    };
  };
}

