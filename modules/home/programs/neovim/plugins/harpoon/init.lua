local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

require("telescope").load_extension("harpoon")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<leader>hj", ui.nav_next)
vim.keymap.set("n", "<leader>hk", ui.nav_prev)

vim.keymap.set("n", "<C-a>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-s>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-z>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-x>", function() ui.nav_file(4) end)

vim.keymap.set("n", "<leader>hm", "<cmd>Telescope harpoon marks<CR>")

require("harpoon").setup({
  global_settings = {
    save_on_toggle = true,
    save_on_change = true, -- save harpoon on change
    enter_on_sendcmd = false,
    tmux_autoclose_windows = false,
    excluded_filetypes = { "harpoon" },
    mark_branch = false, -- git branch aware

    -- enable tabline with harpoon marks
    tabline = true,
    tabline_prefix = "   ",
    tabline_suffix = "   ",
  },
  menu = {
    width = math.max(
      math.floor(vim.api.nvim_win_get_width(0) * 0.35),
      math.min(
        math.floor(vim.api.nvim_win_get_width(0) - 15),
        80
      )
    ),
    height = math.max(
      math.floor(vim.api.nvim_win_get_height(0) * 0.35),
      math.min(
        math.floor(vim.api.nvim_win_get_width(0) - 15),
        15
      )
    ),
  }
})
