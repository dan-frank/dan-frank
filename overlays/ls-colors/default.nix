self: super:
rec {
  ls-colors = self.callPackage ./pkgs/ls-colors.nix { };
}
