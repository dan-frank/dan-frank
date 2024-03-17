local builtin = require('telescope.builtin')

-- Goto
vim.keymap.set('n', '<leader>D', builtin.lsp_definitions, {}) -- definitions
vim.keymap.set('n', '<leader>U', builtin.lsp_references, {}) -- usages

-- Find
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
-- vim.keymap.set('n', '<leader>ps', function()
--   builtin.grep_string({ search = vim.fn.input("Grep > ") });
-- end)
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})
vim.keymap.set('n', '<leader>pb' , builtin.buffers, {})
vim.keymap.set('n', '<leader>ph', 'Telescope harpoon marks', {})

-- ???
-- vim.keymap.set('n', '<C-p>', builtin.git_files, {})
-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
