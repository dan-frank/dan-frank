{ pkgs, ...  }:
pkgs.writeShellScript "script.sh" ''
  # TOPPROC=$(sw_vers -productVersion; echo " ("; uname -r; echo ")")
  TOPPROC=$(sw_vers -productVersion)

  sketchybar --set $NAME icon="" label="$TOPPROC"
''
