{ pkgs, ... }:
with pkgs.vimPlugins;
{
  programs.neovim.plugins = [{
    # TODO: Do I need config?
    plugin = todo-comments-nvim;
    type = "lua";
    config = ''
      require('todo-comments').setup{}
    '';
  }];
}
