{ pkgs, ... }:
with pkgs.vimPlugins;
{
  programs.neovim.plugins = [
    nvim-lspconfig
    nvim-dap
    {
      plugin = nvim-cmp;
      type = "lua";
      config = builtins.readFile ./nvim-cmp.lua;
    }
    cmp-nvim-lsp
    cmp-nvim-lsp-signature-help
    cmp-path
    cmp-buffer
    luasnip
    cmp_luasnip
    nvim-jdtls
    {
      plugin = nvim-metals;
      type = "lua";
      config = builtins.readFile ./nvim-metals.lua;
    }
  ];
}
