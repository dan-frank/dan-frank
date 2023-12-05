{ pkgs }:
pkgs.writeShellApplication {
  name = "hss-hyrax-search";
  runtimeInputs = with pkgs; [ git ];
  text = ''
    git clone https://github.com/HSS-Proservice/hyrax-search.git "$1"
  '';
}
