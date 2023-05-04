-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Navigation
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Jump down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Jump up and center" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Search down and center" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Search up and center" })

-- Editing
vim.keymap.set("n", "d", '"_d', { desc = "Delete into the black hole register" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line up" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", ">", ">gv", { desc = "Move block right" })
vim.keymap.set("v", ">", ">gv", { desc = "Move block left" })

-- Buffers
vim.keymap.set("n", "<leader>bw", "<cmd>BDeleteAll<CR>", { desc = "Close all unsaved buffers" })
vim.keymap.set("n", "<leader>bn", "<cmd>enew<CR>", { desc = "Create a new buffer" })

-- Use tmux instead of vim terminal
vim.keymap.set("n", "<leader>tt", "<cmd>silent !tmux split-window -v -p 25<CR>", { desc = "Open a vertical tmux pane" })
vim.keymap.set("n", "<leader>tv", "<cmd>silent !tmux split-window -v<CR>", { desc = "Open a vertical tmux pane" })
vim.keymap.set("n", "<leader>th", "<cmd>silent !tmux split-window -h<CR>", { desc = "Open a horizontal tmux pane" })

-- Open URL under cursor https://sbulav.github.io/vim/neovim-opening-urls/
if vim.fn.has("mac") == 1 then
  vim.keymap.set(
    "n",
    "gx",
    '<Cmd>call jobstart(["open", expand("<cfile>")], {"detach": v:true})<CR>',
    { desc = "Open URI under cursor" }
  )
elseif vim.fn.has("unix") == 1 then
  vim.keymap.set(
    "n",
    "gx",
    '<Cmd>call jobstart(["open", expand("<cfile>")], {"detach": v:true})<CR>',
    { desc = "Open URI under cursor" }
  )
else
  vim.keymap.set(
    "n",
    "gx",
    '<Cmd>call jobstart(["open", expand("<cfile>")], {"detach": v:true})<CR>',
    { desc = "Open URI under cursor" }
  )
end

-- Ask for a string to parse into a date time object using script
local function parse_dt(prompt)
  vim.ui.input({ prompt = prompt }, function(input)
    local cmd = vim.fn.system('dt -q ymd "' .. input .. '"')
    local date = vim.fn.split(cmd, "\n")
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, date)
  end)
end
vim.keymap.set("n", "<leader>dd", function()
  parse_dt("Parse to date: ")
end, { desc = "Insert date from natural language" })
