{ pkgs, config, ... }:
let
  helpers = import ./helpers { inherit pkgs config; };
  inherit (helpers) getColor;
in pkgs.writeShellScript "colors" ''
  export BAR_COLOR=${getColor { color = "black"; opacity = "o25"; }}
  export BAR_BORDER_COLOR=${getColor { color = "black"; opacity = "o50"; }}
  export HIGHLIGHT=${getColor { color = "teal"; }}
  export HIGHLIGHT_75=${getColor { color = "teal"; opacity = "o75"; }}
  export HIGHLIGHT_50=${getColor { color = "teal"; opacity = "o50"; }}
  export HIGHLIGHT_25=${getColor { color = "teal"; opacity = "o25"; }}
  export HIGHLIGHT_10=${getColor { color = "teal"; opacity = "o10"; }}
  export ICON_COLOR=${getColor { color = "white"; }}
  export ICON_COLOR_INACTIVE=${getColor { color = "white"; opacity = "o50"; }}
  export LABEL_COLOR=${getColor { color = "white"; opacity = "o75"; }}
  export POPUP_BACKGROUND_COLOR=${getColor { color = "black"; opacity = "o25"; }}
  export POPUP_BORDER_COLOR=${getColor { color = "black"; opacity = "o0"; }}
  export SHADOW_COLOR=${getColor { color = "black"; }}
  export TRANSPARENT=${getColor { color = "black"; opacity = "o0"; }}
''
