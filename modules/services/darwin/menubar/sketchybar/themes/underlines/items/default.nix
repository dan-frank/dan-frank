{ pkgs, config, ... }:
{
  battery = import ./battery { inherit pkgs config; };
  clock = import ./clock { inherit pkgs config; };
  memory = import ./memory { inherit pkgs config; };
  operating-system = import ./operating-system { inherit pkgs config; };
  processor = import ./processor { inherit pkgs config; };
  separator = import ./separator { inherit pkgs config; };
  space-number = import ./space-number { inherit pkgs config; };
  spaces = import ./spaces { inherit pkgs config; };
  storage = import ./storage { inherit pkgs config; };
  uptime = import ./uptime { inherit pkgs config; };
  window-title = import ./window-title { inherit pkgs config; };
  yabai = import ./yabai { inherit pkgs config; };
}
