{ inputs, ...}:
{
  # Colors can be either:
  # -> inputs.nix-colors.colorSchemes.helios;
  # -> import ./palettes/theme.nix;
  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-latte;
}
