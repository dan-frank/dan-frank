{ config, lib, ... }:
let
  cfg = config.fontProfiles;
in {
  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.monospace.package cfg.regular.package ];
  };
}
