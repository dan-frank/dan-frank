{ pkgs }:
pkgs.writeShellApplication {
  name = "hss-docker-restart";
  runtimeInputs = with pkgs; [ docker ];
  text = ''
    curl -L https://github.com/docker/machine/releases/download/v0.16.2/docker-machine-"$(uname -s)"-"$(uname -m)" >/tmp/docker-machine && \
      chmod +x /tmp/docker-machine && \
      sudo cp /tmp/docker-machine /usr/local/bin/docker-machine
    sudo systemctl restart docker
  '';
}
