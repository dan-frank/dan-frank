{ pkgs }:
let
  REGION = "eu-west-1";
  AWS_PROFILE = "--profile dan-frank";
  AWS_CLI_OPTS = "${AWS_PROFILE} --region ${REGION}";
  DEVELOPER = "dan-frank";
  HOST = "clouddev.local";
in
pkgs.writeShellApplication {
  name = "hss-start";
  runtimeInputs = with pkgs; [ awscli2 ];
  text = ''
    set -e

    aws sso login ${AWS_PROFILE}

    INSTANCE_ID=$(aws ${AWS_CLI_OPTS} ec2 describe-instances \
      --filter Name=tag:developer,Values=${DEVELOPER} Name=instance-state-code,Values=80,16 \
      --query "Reservations[0].Instances[0].InstanceId" \
      --output text)

    INSTANCE_STATE=$(aws ${AWS_CLI_OPTS} ec2 describe-instances \
            --filter Name=tag:developer,Values=${DEVELOPER} Name=instance-state-code,Values=80,16 \
            --query "Reservations[0].Instances[0].State.Name" \
            --output text)

    if [[ "None" == "$INSTANCE_ID" ]];then
      echo "$(date "+[%H:%M]") No instances found, creating one"
      INSTANCE_ID=$(aws ${AWS_CLI_OPTS} ec2 run-instances \
        --launch-template LaunchTemplateId=lt-0200d8c4fbed996af,Version=\$Latest \
        --key-name "${DEVELOPER}_cloud_dev_env" \
        --tag-specifications "ResourceType=instance,Tags=[{Key=developer,Value=${DEVELOPER}},{Key=Name,Value=${DEVELOPER}-dev-env}]" "ResourceType=volume,Tags=[{Key=developer,Value=${DEVELOPER}}]" \
        --query="Instances[0].InstanceId" \
        --output text)
      sleep 30
    else
      if [[ "running" == "$INSTANCE_STATE" ]]; then
        echo "$(date "+[%H:%M]") Instance $INSTANCE_ID already running"
      else
        echo "$(date "+[%H:%M]") Found instance $INSTANCE_ID, starting it"
        aws ${AWS_CLI_OPTS} ec2 start-instances --instance-ids "$INSTANCE_ID" 1> /dev/null
      fi
    fi

    echo "$(date "+[%H:%M]") Waiting for instance $INSTANCE_ID to be running"
    aws ${AWS_CLI_OPTS} ec2 wait instance-running --instance-ids "$INSTANCE_ID"

    INSTANCE_IP=$(aws ${AWS_CLI_OPTS} ec2 describe-instances --instance-ids "$INSTANCE_ID" \
      --query="Reservations[0].Instances[0].PublicIpAddress" \
      --output text)

    # echo "$(date "+[%H:%M]") Opening SSH tunnel on port 5901 to IP $INSTANCE_IP"
    # ssh -L 5901:localhost:5901 -o StrictHostKeychecking=no -i ~/.ssh/${DEVELOPER}_cloud_dev_env.pem ec2-user@$INSTANCE_IP

    sudo sed -i "" -e "/${HOST}/ s/.*/$INSTANCE_IP\t${HOST}/g" /etc/hosts

    echo "$(date "+[%H:%M]") Linking SSH tunnel of IP $INSTANCE_IP to ${HOST}"
  '';
}
