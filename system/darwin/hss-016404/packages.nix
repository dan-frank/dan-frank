{ pkgs, ... }:
let
  hss-apply-jdk-certs = import ../../../scripts/hss/apply-jdk-certs.nix { inherit pkgs; };
  hss-db-secret = import ../../../scripts/hss/db-secret.nix { inherit pkgs; };
  hss-hyrax = import ../../../scripts/hss/hyrax.nix { inherit pkgs; };
  hss-hyrax-search = import ../../../scripts/hss/hyrax-search.nix { inherit pkgs; };
  hss-merge = import ../../../scripts/hss/merge.nix { inherit pkgs; };
  hss-mount = import ../../../scripts/hss/mount.nix { inherit pkgs; };
  hss-ssh = import ../../../scripts/hss/ssh.nix { inherit pkgs; };
  hss-start = import ../../../scripts/hss/start.nix { inherit pkgs; };
  hss-stop = import ../../../scripts/hss/stop.nix { inherit pkgs; };
  hss-swag = import ../../../scripts/hss/swag.nix { inherit pkgs; };
  hss-unmount = import ../../../scripts/hss/unmount.nix { inherit pkgs; };
in
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

    # === Scripts ===
    hss-apply-jdk-certs
    hss-db-secret
    hss-hyrax
    hss-hyrax-search
    hss-merge
    hss-mount
    hss-ssh
    hss-start
    hss-stop
    hss-swag
    hss-unmount

    # === UI Tools ===
    dbeaver
    tigervnc
    zoom-us
  ];
}
