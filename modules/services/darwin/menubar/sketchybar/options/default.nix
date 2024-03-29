{ lib, ... }:
{
  align = import ./align.nix { inherit lib; };
  blur-radius = import ./blur-radius.nix { inherit lib; };
  border-color = import ./border-color.nix { inherit lib; };
  border-width = import ./border-width.nix { inherit lib; };
  color = import ./color.nix { inherit lib; };
  corner-radius = import ./corner-radius.nix { inherit lib; };
  drawing = import ./drawing.nix { inherit lib; };
  height = import ./height.nix { inherit lib; };
  highlight-color = import ./highlight-color.nix { inherit lib; };
  padding = import ./padding.nix { inherit lib; };
  scroll-texts = import ./scroll-texts.nix { inherit lib; };
  topmost = import ./topmost.nix { inherit lib; };
  width = import ./width.nix { inherit lib; };
  y-offset = import ./y-offset.nix { inherit lib; };

  background = import ./background.nix { inherit lib; };
  font = import ./font.nix { inherit lib; };
  image = import ./image.nix { inherit lib; };
  shadow = import ./shadow.nix { inherit lib; };
  text = import ./text.nix { inherit lib; };

  suites = import ./suites { inherit lib; };
}
