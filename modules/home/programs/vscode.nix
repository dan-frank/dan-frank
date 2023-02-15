# { config, lib, pkgs, ... }:
# with lib;
# let
#   cfg = config.programs.vscode;
# in
# {
#   options.programs.vscode = {
#     enable = true;
# 
#     package = mkOption {
#       type = types.package;
#       default = pkgs.vscode;
#       defaultText = "pkgs.vscode";
#       description = "GUI Editor of choice";
#     };
#   };
# 
#   config = mkIf cfg.enable {
#     home.packages = [
#       cfg.package
#     ];
#   };
# }

{ config, lib, pkgs, ... }:
{
  programs.vscode = {
    enable = true;
  };
}

