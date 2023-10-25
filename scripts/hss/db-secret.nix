{ pkgs }:
pkgs.writeShellApplication {
  name = "hss-db-secret";
  runtimeInputs = with pkgs; [ awscli2 ];
  text = ''
    echo "============================================================================="
    echo "Note: If you don't have a profile you can create one with \`aws configure sso\`"
    echo "============================================================================="

    aws --profile dan-frank secretsmanager get-secret-value --secret-id arn:aws:secretsmanager:eu-west-2:860977539643:secret:hyrax-staging.anyjunk.persist.db.password-c9KufH --region eu-west-2
  '';
}
