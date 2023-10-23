{ pkgs, ... }:
let
  hss-apply-jdk-certs = import ../../../scripts/hss/apply-jdk-certs.nix { inherit pkgs; };
  hss-docker-restart = import ../../../scripts/hss/docker-restart.nix { inherit pkgs; };
  hss-start-script = import ../../../scripts/hss/start.nix { inherit pkgs; };
  hss-stop-script = import ../../../scripts/hss/stop.nix { inherit pkgs; };
  hss-swag-script = import ../../../scripts/hss/swag.nix { inherit pkgs; };
in
{
  environment.systemPackages = with pkgs; [
    # === Scala ===
    coursier
    jdk17
    sbt
    scala-cli
    scalafmt

    # === Additional ===
    nodejs
    swagger-cli

    # === Scripts ===
    hss-apply-jdk-certs
    hss-docker-restart
    hss-start-script
    hss-stop-script
    hss-swag-script
  ];
}
