{ pkgs, ...  }:
pkgs.writeShellScript "space-click.sh" ''
  yabai -m space --focus \$SID 2>/dev/null
''
