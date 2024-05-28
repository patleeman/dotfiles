-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Make leader timeout more responsive
vim.opt.timeoutlen = 100
-- Don't hide any text
vim.opt.conceallevel = 0
-- Don't replace whitespace with >+- chars
vim.opt.list = false

-- Disable the "How to disable mouse" warning in the right click menu
vim.api.nvim_command("aunmenu PopUp.How-to\\ disable\\ mouse")

vim.api.nvim_command("aunmenu PopUp.-1-")

vim.api.nvim_command("set wrap linebreak")
