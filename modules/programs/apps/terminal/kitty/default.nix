{ pkgs, lib, config, ... }:
let
  cfg = config.programs.apps.terminal.kitty;

  theme = import ./theme.nix { inherit config; };
in {
  options.programs.apps.terminal.kitty = {
    enable = lib.mkEnableOption "Enables kitty and configuration";
  };

  config = lib.mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = true;

      settings = {
        active_tab_font_style = "bold";
        background_opacity = "1.0";
        bold_font = "auto";
        bold_italic_font = "auto";
        confirm_os_window_close = 0;
        cursor_blink_interval = "-1";
        cursor_shape = "underline";
        cursor_stop_blinking_after = 0;
        cursor_underline_thickness = "1.5";
        disable_ligatures = "never";
        copy_on_select = true;
        editor = "${pkgs.neovim}/bin/nvim";
        font_family = "${config.fontProfiles.monospace.family}";
        font_size = "${toString config.fontProfiles.fontSize}.0";
        hide_window_decorations = "titlebar-only";
        inactive_tab_font_style = "normal";
        inactive_text_alpha = "1.0";
        italic_font = "auto";
        placement_strategy = "center";
        resize_in_steps = "yes";
        scrollback_lines = config.programs.apps.terminal.scrollback;
        tab_bar_edge = "bottom";
        tab_bar_min_tabs = 1;
        tab_bar_style = "powerline";
        tab_powerline_style = "slanted";
        tab_title_template = "{title.split('/')[-1]} {' :{}:'.format(num_windows) if num_windows > 1 else ''}";
        touch_scroll_multiplier = "1.0";
        wheel_scroll_multiplier = "5.0";
        window_margin_width = 0;
        window_padding_width = 10;
      } // theme;

      extraConfig = ''
        modify_font cell_height 100%

        map alt+ctrl+1 goto_tab 1
        map alt+ctrl+2 goto_tab 2
        map alt+ctrl+3 goto_tab 3
        map alt+ctrl+4 goto_tab 4
        map alt+ctrl+5 goto_tab 5
        map alt+ctrl+6 goto_tab 6
        map alt+ctrl+7 goto_tab 7
        map alt+ctrl+8 goto_tab 8
        map alt+ctrl+9 goto_tab 9
        map alt+ctrl+0 goto_tab 10
      '';
    };
  };
}

