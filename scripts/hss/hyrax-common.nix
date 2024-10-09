{ pkgs }:
pkgs.writeShellApplication {
  name = "hss-hyrax-common";
  runtimeInputs = with pkgs; [ git ];
  text = ''
    git clone https://github.com/HSS-Proservice/hyrax-common.git "$1"
  '';
}
