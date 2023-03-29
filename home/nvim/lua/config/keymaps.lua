-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- INSERT MODE KEYMAPS
vim.keymap.set("i", "jj", "<ESC>", { desc = "Escape insert mode" })
vim.keymap.set("i", ";;", function()
  local closers = { ")", "]", "}", ">", "'", '"', "`", "," }
  local line = vim.api.nvim_get_current_line()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local after = line:sub(col + 1, -1)
  local closer_col = #after + 1
  local closer_i = nil
  for i, closer in ipairs(closers) do
    local cur_index, _ = after:find(closer)
    if cur_index and (cur_index < closer_col) then
      closer_col = cur_index
      closer_i = i
    end
  end
  if closer_i then
    vim.api.nvim_win_set_cursor(0, { row, col + closer_col })
  else
    vim.api.nvim_win_set_cursor(0, { row, col + 1 })
  end
end, { desc = "Escape a pair" })

-- NORMAL MODE KEYMAPS
vim.keymap.set("n", "<leader>dd", 'i<C-R>=strftime("%Y-%m-%d")<CR><Esc>', { desc = "Insert date" })
vim.keymap.set("n", "<leader>dt", 'i<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>', { desc = "Insert datetime" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Jump down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Jump up and center" })
vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Next buffer" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Search down and center" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Search up and center" })

vim.keymap.set("n", "d", '"_d', { desc = "Delete into the black hole register" })

vim.keymap.set("n", "<leader>bw", "<cmd>%bd<CR>", { desc = "Close all unsaved buffers" })

-- VISUAL MODE KEYMAPS
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line up" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", ">", ">gv", { desc = "Move block right" })
vim.keymap.set("v", ">", ">gv", { desc = "Move block left" })
vim.keymap.set("v", "<leader>d", "ygv<CMD>!dt -q a <C-r><CR>", { desc = "Convert the highlighted text to datetime" })

-- https://sbulav.github.io/vim/neovim-opening-urls/
-- URL handling
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

-- Tmux
vim.keymap.set("n", "<leader>t", "<cmd>silent !tmux split-window -v -p 25<CR>", { desc = "Open a vertical tmux pane" })
