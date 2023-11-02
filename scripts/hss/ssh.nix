{ pkgs }:
pkgs.writeShellApplication {
  name = "hss-shh";
  text = ''
    TERM=xterm-256color ssh -L 5901:localhost:5901 -o StrictHostKeychecking=no -i ~/.ssh/dan-frank_cloud_dev_env.pem ec2-user@clouddev.local
  '';
}
