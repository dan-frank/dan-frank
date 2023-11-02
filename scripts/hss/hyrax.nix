{ pkgs }:
pkgs.writeShellApplication {
  name = "hss-hyrax";
  runtimeInputs = with pkgs; [ git ];
  text = ''
    git clone https://github.com/HSS-Proservice/hyrax.git "$1"
  '';
}
