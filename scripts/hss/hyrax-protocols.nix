{ pkgs }:
pkgs.writeShellApplication {
  name = "hss-hyrax-protocols";
  runtimeInputs = with pkgs; [ git ];
  text = ''
    git clone https://github.com/HSS-Proservice/hyrax-protocols.git "$1"
  '';
}
