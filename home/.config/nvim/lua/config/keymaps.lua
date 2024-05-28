-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Navigation
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Jump down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Jump up and center" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Search down and center" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Search up and center" })
vim.keymap.set("n", "gh", ":OpenInGHRepo<CR>", { desc = "Open in GitHub repo" })

-- Editing
vim.keymap.set("n", "d", '"_d', { desc = "Delete into the black hole register" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line up" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", ">", ">gv", { desc = "Move block left" })
vim.keymap.set("v", ">", ">gv", { desc = "Move block right" })

-- Utility to get listed buffers
local function get_listed_buffers()
  local buffers = {}
  local len = 0
  for buffer = 1, vim.fn.bufnr("$") do
    if vim.fn.buflisted(buffer) == 1 then
      len = len + 1
      buffers[len] = buffer
    end
  end

  return buffers
end

-- Command to delete all buffers
vim.api.nvim_create_user_command("BDeleteAll", function()
  local buffers = get_listed_buffers()
  for _, bufnr in ipairs(buffers) do
    local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
    local name = vim.api.nvim_buf_get_name(bufnr)
    if ft ~= "Alpha" and name ~= "" then
      vim.api.nvim_buf_delete(bufnr, {})
    end
  end
end, { desc = "Delete all buffers" })
-- Buffers
vim.keymap.set("n", "<leader>bw", "<cmd>BDeleteAll<CR>", { desc = "Close all unsaved buffers" })
vim.keymap.set("n", "<leader>bn", "<cmd>enew<CR>", { desc = "Create a new buffer" })

-- Open URL under cursor https://sbulav.github.io/vim/neovim-opening-urls/
if vim.fn.has("mac") == 1 then
  vim.keymap.set(
    "n",
    "gx",
    '<cmd>call jobstart(["open", expand("<cfile>")], {"detach": v:true})<CR>',
    { desc = "Open URI under cursor" }
  )
elseif vim.fn.has("unix") == 1 then
  vim.keymap.set(
    "n",
    "gx",
    '<cmd>call jobstart(["open", expand("<cfile>")], {"detach": v:true})<CR>',
    { desc = "Open URI under cursor" }
  )
else
  vim.keymap.set(
    "n",
    "gx",
    '<cmd>call jobstart(["open", expand("<cfile>")], {"detach": v:true})<CR>',
    { desc = "Open URI under cursor" }
  )
end
