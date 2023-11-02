{ pkgs }:
pkgs.writeShellApplication {
  name = "hss-merge";
  runtimeInputs = with pkgs; [ git ];
  text = ''
    git checkout master;
    git reset --hard origin/master;

    count=$(git rev-list --count "$1" ^master);
    if [ "$count" -gt 1 ]; then
      ff="--no-ff";
    else
      ff="--ff-only";
    fi;

    git merge "$ff" "$1";
    git push -f origin "$1";
    git push origin master;
    git push origin --delete "$1";
  '';
}
