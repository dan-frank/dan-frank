{ pkgs, config, ... }:
{
  apple = import ./apple { inherit pkgs config; };
  battery = import ./battery { inherit pkgs config; };
  control-center = import ./control-center { inherit pkgs config; };
  countdown = import ./countdown { inherit pkgs config; };
  datetime = import ./datetime { inherit pkgs config; };
  diskmonitor = import ./diskmonitor { inherit pkgs config; };
  donotdisturb = import ./donotdisturb { inherit pkgs config; };
  messages = import ./messages { inherit pkgs config; };
  music = import ./music { inherit pkgs config; };
  spaces = import ./spaces { inherit pkgs config; };
  volume = import ./volume { inherit pkgs config; };
  weather = import ./weather { inherit pkgs config; };
  wifi = import ./wifi { inherit pkgs config; };
  yabai = import ./yabai { inherit pkgs config; };
}
