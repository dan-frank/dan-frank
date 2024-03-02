{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # === Hyrax Dependancies ===
    coursier
    jdk17
    sbt
    scala-cli
    scalafmt

    # === Additional ===
    nodejs
    swagger-cli

    # === UI Tools ===
    dbeaver
    tigervnc
    zoom-us
  ];
}
