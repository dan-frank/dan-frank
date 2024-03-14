{ inputs, ...}:
{
  # Colors can be either:
  # -> inputs.nix-colors.colorSchemes.helios;
  # -> import ./palettes/theme.nix;
  colorScheme = import ./palettes/catppuccin-mocha.nix;
}
