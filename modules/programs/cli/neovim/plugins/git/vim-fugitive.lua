vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Open Git Fugitive window"; })
vim.keymap.set("n", "<leader>gb", "<CMD>Git blame -w -C -C -C<CR>", { desc = "Enhanced git blame" })
