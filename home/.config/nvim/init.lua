-- ============================================================================
-- LEADER KEY
-- ============================================================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ============================================================================
-- PLUGIN MANAGER (lazy.nvim)
-- ============================================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Telescope: Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
          },
          file_ignore_patterns = { "node_modules", ".git/", "dist/", "build/" },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
        },
      })

      -- Load fzf native extension for better performance
      telescope.load_extension("fzf")
    end,
  },

  -- Bufferline: Modern tab/buffer line
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          numbers = "ordinal",
          close_command = "bdelete! %d",
          right_mouse_command = "bdelete! %d",
          left_mouse_command = "buffer %d",
          middle_mouse_command = nil,
          indicator = {
            style = "underline",
          },
          buffer_close_icon = "",
          modified_icon = "●",
          close_icon = "",
          left_trunc_marker = "",
          right_trunc_marker = "",
          diagnostics = false,
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "center",
              separator = true,
            },
          },
          show_buffer_icons = true,
          show_buffer_close_icons = true,
          show_close_icon = false,
          show_tab_indicators = true,
          separator_style = "thin",
          always_show_bufferline = true,
          sort_by = "insert_after_current",
        },
      })
    end,
  },
})

-- ============================================================================
-- EDITOR SETTINGS
-- ============================================================================

-- UI & Display
vim.opt.number = true                             -- Show line numbers
vim.opt.relativenumber = true                     -- Relative line numbers
vim.opt.signcolumn = "yes"                        -- Always show sign column
vim.opt.cursorline = true                         -- Highlight current line
vim.opt.termguicolors = true                      -- Enable true color support
vim.opt.showmatch = true                          -- Show matching brackets
vim.opt.showtabline = 2                           -- Always show tabline

-- Scrolling & Navigation
vim.opt.scrolloff = 8                             -- Keep 8 lines above/below cursor
vim.opt.sidescrolloff = 8                         -- Keep 8 columns left/right of cursor

-- Search
vim.opt.ignorecase = true                         -- Case-insensitive search
vim.opt.smartcase = true                          -- Unless uppercase in pattern
vim.opt.incsearch = true                          -- Incremental search
vim.opt.hlsearch = true                           -- Highlight search matches

-- Indentation
vim.opt.smartindent = true                        -- Smart auto-indenting
vim.opt.expandtab = true                          -- Use spaces instead of tabs
vim.opt.shiftwidth = 2                            -- Indent width
vim.opt.tabstop = 2                               -- Tab width
vim.opt.softtabstop = 2                           -- Backspace removes this many spaces

-- Splits
vim.opt.splitbelow = true                         -- Horizontal splits below
vim.opt.splitright = true                         -- Vertical splits right

-- Files & Persistence
vim.opt.undofile = true                           -- Persistent undo history
vim.opt.swapfile = false                          -- Disable swap files
vim.opt.backup = false                            -- Disable backup files
vim.opt.autoread = true                           -- Auto-reload files changed outside vim

-- Completion & LSP
vim.opt.completeopt = { "menuone", "noselect" }   -- Better completion menu
vim.opt.updatetime = 300                          -- Faster CursorHold & diagnostics

-- Misc
vim.opt.clipboard = "unnamedplus"                 -- Use system clipboard
vim.opt.wildmode = { "longest:full", "full" }     -- Command-line completion
vim.opt.shortmess:append("I")                     -- Don't show intro message
vim.opt.lazyredraw = true                         -- Faster rendering in macros

-- ============================================================================
-- KEYMAPS
-- ============================================================================

-- Telescope: Fuzzy Finder
vim.keymap.set("n", "<leader><leader>", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
vim.keymap.set("n", "<leader>P", "<cmd>Telescope live_grep<cr>", { desc = "Find in files (grep)" })
vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find help" })
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Find recent files" })

-- Bufferline: Buffer Navigation
vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>x", "<cmd>bdelete<cr>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>X", "<cmd>BufferLineCloseOthers<cr>", { desc = "Close other buffers" })
vim.keymap.set("n", "<leader>1", "<cmd>BufferLineGoToBuffer 1<cr>", { desc = "Go to buffer 1" })
vim.keymap.set("n", "<leader>2", "<cmd>BufferLineGoToBuffer 2<cr>", { desc = "Go to buffer 2" })
vim.keymap.set("n", "<leader>3", "<cmd>BufferLineGoToBuffer 3<cr>", { desc = "Go to buffer 3" })
vim.keymap.set("n", "<leader>4", "<cmd>BufferLineGoToBuffer 4<cr>", { desc = "Go to buffer 4" })
vim.keymap.set("n", "<leader>5", "<cmd>BufferLineGoToBuffer 5<cr>", { desc = "Go to buffer 5" })
vim.keymap.set("n", "<leader>6", "<cmd>BufferLineGoToBuffer 6<cr>", { desc = "Go to buffer 6" })
vim.keymap.set("n", "<leader>7", "<cmd>BufferLineGoToBuffer 7<cr>", { desc = "Go to buffer 7" })
vim.keymap.set("n", "<leader>8", "<cmd>BufferLineGoToBuffer 8<cr>", { desc = "Go to buffer 8" })
vim.keymap.set("n", "<leader>9", "<cmd>BufferLineGoToBuffer 9<cr>", { desc = "Go to buffer 9" })

-- Normal Mode: Navigation & Movement
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result, centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result, centered" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down, center cursor" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up, center cursor" })

-- Normal Mode: Line Movement
vim.keymap.set("n", "J", ":m .+1<CR>==", { desc = "Move line down", silent = true })
vim.keymap.set("n", "K", ":m .-2<CR>==", { desc = "Move line up", silent = true })

-- Normal Mode: Split Navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left split", silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to below split", silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to above split", silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right split", silent = true })

-- Visual Mode: Line Movement
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected line(s) down", silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected line(s) up", silent = true })

-- Visual Mode: Indentation
vim.keymap.set("v", "<", "<gv", { desc = "Shift left and keep selection", silent = true })
vim.keymap.set("v", ">", ">gv", { desc = "Shift right and keep selection", silent = true })

-- Terminal Mode: Navigation & Exit
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode", silent = true })
vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], { desc = "Move to left split", silent = true })
vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], { desc = "Move to below split", silent = true })
vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], { desc = "Move to above split", silent = true })
vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], { desc = "Move to right split", silent = true })

-- Leader: Terminal
local function open_term(cmd)
  vim.cmd(cmd)
  vim.cmd("terminal")
  vim.cmd("startinsert")
  vim.bo.buflisted = true
end

vim.keymap.set("n", "<leader>tt", function() open_term("enew") end,
  { desc = "Open terminal in new buffer" })
vim.keymap.set("n", "<leader>t-", function() open_term("split") end,
  { desc = "Open terminal in horizontal split" })
vim.keymap.set("n", "<leader>t\\", function() open_term("vsplit") end,
  { desc = "Open terminal in vertical split" })

-- Leader: Git
vim.keymap.set("n", "<leader>gg", function()
  local buf = vim.api.nvim_create_buf(false, true)
  local width = math.floor(vim.o.columns * 0.9)
  local height = math.floor(vim.o.lines * 0.9)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })

  vim.fn.termopen("lazygit", {
    on_exit = function()
      vim.api.nvim_win_close(win, true)
    end,
  })
  vim.cmd("startinsert")
end, { desc = "Open LazyGit (floating terminal)", silent = true })

-- Leader: Config
vim.keymap.set("n", "<leader>rr", function()
  if vim.bo.modified then
    vim.cmd("write")
  end
  vim.cmd("source $MYVIMRC")
  vim.notify("✅ Reloaded Neovim config!", vim.log.levels.INFO)
end, { desc = "Reload Neovim config", silent = true })

-- ============================================================================
-- AUTO-RELOAD FILES ON EXTERNAL CHANGES
-- ============================================================================

-- Check for external file changes and reload
vim.api.nvim_create_autocmd({
  "FocusGained", "BufEnter", "CursorHold", "CursorHoldI"
}, {
  callback = function()
    if vim.fn.mode() ~= "c" then
      vim.cmd("checktime")
    end
  end,
})
