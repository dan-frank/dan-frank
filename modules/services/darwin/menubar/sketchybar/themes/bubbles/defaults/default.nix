{ pkgs, config, ... }:
{
  bar = import ./bar.nix { inherit pkgs config; };
  bracket = import ./bracket.nix { inherit pkgs config; };
  item = import ./item.nix { inherit pkgs config; };
  menu = import ./menu.nix { inherit pkgs config; };
  menuItem = import ./menuItem.nix { inherit pkgs config; };
  notification = import ./notification.nix { inherit pkgs config; };
  separator = import ./separator.nix { inherit pkgs config; };
}
