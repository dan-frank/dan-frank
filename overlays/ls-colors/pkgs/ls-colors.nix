{ fetchgit, runCommand, coreutils}:
let
  LS_COLORS = fetchgit {
    url = "https://github.com/trapd00r/LS_COLORS";
    sha256 = "hQTT/yNS9UIDZqHuul0xmknnOh6tOtfotQIm0SY5TTE=";
  };
in
  runCommand "ls-colors" { meta.priority = 3; } ''
    mkdir -p $out/bin $out/share
    ln -s ${coreutils}/bin/ls $out/bin/ls
    ln -s ${coreutils}/bin/dircolors $out/bin/dircolors
    cp ${LS_COLORS}/LS_COLORS $out/share/LS_COLORS
  ''

