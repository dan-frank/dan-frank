{ config }:
with config.colorscheme.palette;
{
  # The basic colors
  foreground = "#${base05}";
  background = "#${base00}";
  selection_foreground = "#${base05}";
  selection_background = "#${base04}";

  # Tab bar colors
  tab_bar_background = "#${base01}";
  active_tab_foreground = "#${base01}";
  active_tab_background = "#${base0D}";
  inactive_tab_foreground = "#${base06}";
  inactive_tab_background = "#${base03}";

  # Cursor colors
  cursor = "#${base05}";
  cursor_text_color = "#${base00}";

  # URL underline color
  url_color = "#${base09}";

  # The 16 terminal colors
  color0 = "#${base04}";
  color8 = "#${base04}";
  color1 = "#${base08}";
  color9 = "#${base08}";
  color2 = "#${base0B}";
  color10 = "#${base0B}";
  color3 = "#${base0A}";
  color11 = "#${base0A}";
  color4 = "#${base0D}";
  color12 = "#${base0D}";
  color5 = "#${base0E}";
  color13 = "#${base0E}";
  color6 = "#${base0C}";
  color14 = "#${base0C}";
  color7 = "#${base05}";
  color15 = "#${base05}";
}
