{ pkgs }:
let
  REGION = "eu-west-1";
  AWS_PROFILE = "--profile dan-frank";
  AWS_CLI_OPTS = "${AWS_PROFILE} --region ${REGION}";
  DEVELOPER = "dan-frank";
in
pkgs.writeShellApplication {
  name = "aj-stop";
  runtimeInputs = with pkgs; [ awscli2 ];
  text = ''
    set -e
    
    aws sso login ${AWS_PROFILE}
    
    INSTANCE_ID=$(aws ${AWS_CLI_OPTS} ec2 describe-instances \
            --filter Name=tag:developer,Values=${DEVELOPER} Name=instance-state-code,Values=16 \
            --query "Reservations[0].Instances[0].InstanceId" \
            --output text)
    
    echo "$(date "+[%H:%M]") Stopping instance $INSTANCE_ID"
    
    aws ${AWS_CLI_OPTS} ec2 stop-instances --hibernate --instance-ids "$INSTANCE_ID" 1> /dev/null
    
    aws ${AWS_CLI_OPTS} ec2 wait instance-stopped --instance-ids "$INSTANCE_ID" 1> /dev/null
    
    echo "$(date "+[%H:%M]") Instance stopped"
  '';
}
