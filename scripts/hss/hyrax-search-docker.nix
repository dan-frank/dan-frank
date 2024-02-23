{ pkgs }:
pkgs.writeShellApplication {
  name = "hss-hyrax-search-docker";
  runtimeInputs = with pkgs; [ awscli2 coursier docker docker-compose jdk17 sbt ];
  text = ''
    aws sso login --profile hss;
    ./devops/login-ecr.sh;
    # aws ecr get-login-password --profile hss --region us-east-1 | docker login --username AWS --password-stdin 689558859283.dkr.ecr.us-east-1.amazonaws.com;
    ./run-local.sh;
    echo "You can now run \`sbt -mem 8192 test\`";
  '';
}
