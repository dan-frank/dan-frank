{ pkgs, config, ... }:
let
  cfg = config.fontProfiles;
in {
  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      iosevka
      fira-code
      terminus_font
      terminus_font_ttf
    ] ++ lib.optionals cfg.enable [ cfg.monospace.package cfg.regular.package ];
  };
}
