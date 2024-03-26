local builtin = require("telescope.builtin")

-- Goto
vim.keymap.set("n", "<leader>D", builtin.lsp_definitions, { desc = "Find definition of hovered" })
vim.keymap.set("n", "<leader>U", builtin.lsp_references, { desc = "Find usages of hovered" })

-- Find
vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Fuzzy search file names" })
-- vim.keymap.set("n", "<leader>ps", function()
--   builtin.grep_string({ search = vim.fn.input("Grep > ") });
-- end)
vim.keymap.set("n", "<leader>ps", builtin.live_grep, { desc = "Fuzzy search codebase" })
vim.keymap.set("n", "<leader>pb", builtin.buffers, { desc = "Show open buffers" })

-- Util
vim.keymap.set("n", "<C-h>", builtin.help_tags, { desc = "Show neovim commands" })

require("telescope").setup({
  defaults = {
    layout_strategy = "vertical",
    layout_config = {
      horizontal = {
        preview_width = 0.55,
        results_width = 0.8,
      },
      width = 0.75,
      height = 0.80,
    },
    file_ignore_patterns = { "node_modules" },
  },
})
