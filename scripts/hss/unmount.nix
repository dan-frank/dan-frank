{ pkgs }:
pkgs.writeShellApplication {
  name = "hss-unmount";
  runtimeInputs = with pkgs; [ sshfs macfuse-stubs ];
  text = ''
    umount ~/Remotes/any-junk
    rmdir ~/Remotes/any-junk
  '';
}
