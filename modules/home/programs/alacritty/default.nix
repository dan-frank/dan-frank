{ config, pkgs, lib, ... }:
let
  setfont = import ./setfont.nix;
  themes = import ./config/themes.nix;
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      bell = {
        animation = "EaseOutExpo";
        duration = 5;
        color = "0xffffff";
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
      keyboard.bindings = [
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
      colors = themes.github-dark;
      font = setfont config.fontProfiles.monospace.family // {
        size = 16;
      };
    };
  };
}
