{ lib, config, ... }:
{
  bracket = import ./bracket.nix { inherit lib config; };
  item = import ./item.nix { inherit lib config; };
  menu = import ./menu.nix { inherit lib config; };
  menuItem = import ./menuItem.nix { inherit lib config; };
  notification = import ./notification.nix { inherit lib config; };
  separator = import ./separator.nix { inherit lib config; };
}
