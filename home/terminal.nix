{ config, pkgs, lib, ... }:
let
  fontFamily = "Hack";

  github-dark = {
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

  jellybeans = {
    primary = {
      background = "0x121212";
      foreground = "0xdedede";
    };
    cursor = {
      text = "0xffffff";
      cursor = "0xffa460";
    };
    normal = {
      black = "0x929292";
      red = "0xe27373";
      green = "0x94b979";
      yellow = "0xffba7b";
      blue = "0x97bedc";
      magenta = "0xe1c0fa";
      cyan = "0x00988e";
      white = "0xdedede";
    };
    bright = {
      black = "0xbdbdbd";
      red = "0xffa1a1";
      green = "0xbddeab";
      yellow = "0xffdca0";
      blue = "0xb1d8f6";
      magenta = "0xfbdaff";
      cyan = "0x1ab2a8";
      white = "0xffffff";
    };
  };

  quiet = {
    primary = {
      background = "0x000000";
      foreground = "0xdadada";
    };
    normal = {
      black = "0x000000";
      red = "0xd7005f";
      green = "0x00af5f";
      yellow = "0xd78700";
      blue = "0x0087d7";
      magenta = "0xd787d7";
      cyan = "0x00afaf";
      white = "0xdadada";
    };
    bright = {
      black = "0x707070";
      red = "0xff005f";
      green = "0x00d75f";
      yellow = "0xffaf00";
      blue = "0x5fafff";
      magenta = "0xff87ff";
      cyan = "0x00d7d7";
      white = "0xffffff";
    };
  };

  slate = {
    primary = {
      background = "#262626";
      foreground = "#ffffff";
    };
    normal = {
      black = "0x000000";
      red = "0xff0000";
      green = "0x5f8700";
      yellow = "0xffff00";
      blue = "0x87d7ff";
      magenta = "0xd7d787";
      cyan = "0xffd7af";
      white = "0x666666";
    };
    light = {
      black = "0x333333";
      red = "0xffafaf";
      green = "0x00875f";
      yellow = "0xffd700";
      blue = "0x5f87d7";
      magenta = "0xafaf87";
      cyan = "0xff8787";
      white = "0xffffff";
    };
  };
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      bell = {
        animation = "EaseOutExpo";
        duration = 5;
        color = "#ffffff";
      };
      # ??? https://sourcegraph.com/github.com/NeQuissimus/DevSetup/-/blob/users/nequi/home/alacritty.nix
      selection.save_to_clipboard = true;
      # shell.program = "${pkgs.zsh}/bin/zsh";
      window = {
        dynamic_title = false;
        decorations = "Buttonless"; # Full | Transparent | Buttonless | None
        opacity = 1.00;
        padding = {
          x = 10;
          y = 10;
        };
      };
      scrolling.history = 10000;
      mouse = {
        hints = {
          launcher = {
            program = "open"; # Mac only -> need !isDarwin alt option
            modifiers = "Command";
          };
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
      colors = github-dark;
      font = {
        normal.family = "${fontFamily}";
        bold.family = "${fontFamily}";
        italic.family = "${fontFamily}";
        bold_italic.family = "${fontFamily}";
        size = 14;
      };
    };
  };
}
