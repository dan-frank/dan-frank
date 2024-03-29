let
  onOff = import ./onOff.nix;
in
value:
  if builtins.isBool value then
    onOff value
  else
    toString value