pkgs: {
  enable = true;
  settings = {
    bell = {
      animation = "EaseOutExpo";
      duration = 5;
      color = "#ffffff";
    };
    font = {
      size = 14;
      # normal.family = "Liga SFMono Nerd Font";
      normal.family = "JetBrains Mono Regular Nerd Font Complete";
      normal.style = "Regular";
      # bold.family = "Liga SFMono Nerd Font";
      bold.family = "JetBrains Mono Bold Nerd Font Complete";
      bold.style = "Bold";
      # italic.family = "Liga SFMono Nerd Font";
      italic.family = "JetBrains Mono Italic Nerd Font Complete";
      italic.style = "Italic";
    };
    # GitHub Theme
    # -> https://gist.github.com/huytd/6e76206fb02267c5da5018f725693862?permalink_comment_id=3681421
    colors = {
      primary = {
        background = "#24292E";
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
      decorations = "Buttonless"; # Full | Transparent | Buttonless | None
      opacity = 1.00;
      padding = {
        x = 10;
        y = 10;
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
}

