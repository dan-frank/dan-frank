{ pkgs }:
pkgs.writeShellApplication {
  name = "hss-mount";
  runtimeInputs = with pkgs; [ sshfs macfuse-stubs ];
  text = ''
    mkdir -p ~/Remotes
    sshfs -o StrictHostKeychecking=no -o IdentityFile=~/.ssh/dan-frank_cloud_dev_env.pem ec2-user@clouddev.local:/home/ec2-user ~/Remotes/hss -C
  '';
}
