local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

opt.smartindent = true
opt.autoindent = true

opt.wrap = true

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

opt.hlsearch = false
opt.incsearch = true

opt.termguicolors = true

opt.scrolloff = 8
opt.signcolumn = "yes"
opt.isfname:append("@-@")

opt.updatetime = 50

opt.colorcolumn = "100"

opt.laststatus = 2
opt.showmatch = true
opt.encoding = "utf-8"

-- Trim whitespace on write
-- vim.cmd "augroup TrimWhitespace"
-- vim.cmd "  autocmd!"
-- vim.cmd "  autocmd BufWritePre * lua require('utils').buf_trim_whitespace()"
-- vim.cmd "augroup END"
