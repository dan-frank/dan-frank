# { config, pkgs, ... }:
{
  imports = [
    ./../common

    ./brew.nix
    ./settings.nix

    ./../../modules/darwin/services/skhd
    ./../../modules/darwin/services/spacebar
    ./../../modules/darwin/services/yabai
  ];

  # Copy applications into ~/Applications/Nix Apps. This workaround allows us
  # to find applications installed by nix through spotlight.
  # system.activationScripts.applications.text = pkgs.lib.mkForce (
  #   ''
  #     if [[ -L "$HOME/Applications" ]]; then
  #       rm "$HOME/Applications"
  #       mkdir -p "$HOME/Applications/Nix Apps"
  #     fi

  #     rm -rf "$HOME/Applications/Nix Apps"
  #     mkdir -p "$HOME/Applications/Nix Apps"

  #     for app in $(find ${config.system.build.applications}/Applications -maxdepth 1 -type l); do
  #       src="$(/usr/bin/stat -f%Y "$app")"
  #       echo "copying $app"
  #       cp -rL "$src" "$HOME/Applications/Nix Apps"
  #     done
  #   ''
  # );

  nix.settings.trusted-users = [ "@admin" ];
  nix.configureBuildUsers = true;
  services.nix-daemon.enable = true;
  system.stateVersion = 4;

  programs.nix-index.enable = true;

  # environment.systemPackages = with pkgs; [
  #   yabai
  # ];
}
