{ pkgs }:
pkgs.writeShellApplication {
  name = "hss-swag";
  runtimeInputs = with pkgs; [ nodejs swagger-cli ];
  text = ''
    swagger-cli validate hyrax-api-docs/hyrax-api-docs-ref.yaml
  '';
}
