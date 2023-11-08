local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-a>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-s>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-z>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-x>", function() ui.nav_file(4) end)

require("harpoon").setup({
    menu = {
        width = math.max(
          math.floor(vim.api.nvim_win_get_width(0) * 0.35),
          80
        ),
        height = math.max(
          math.floor(vim.api.nvim_win_get_height(0) * 0.35),
          15
        ),
    }
})

require("telescope").load_extension("harpoon")
