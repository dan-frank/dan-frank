{ pkgs }:
pkgs.writeShellApplication {
  name = "hss-hyrax-protocols-local";
  runtimeInputs = with pkgs; [ coursier sbt jdk17 ];
  text = ''
    sbt publishLocal
  '';
}
