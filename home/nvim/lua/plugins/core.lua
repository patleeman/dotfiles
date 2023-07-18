return {
  {
    "kdheepak/lazygit.nvim",
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
  {
    "alexghergh/nvim-tmux-navigation",
    setup = function()
      require("nvim-tmux-navigation").setup()
    end,
    keys = {
      { "<C-h>", "<cmd>lua require('nvim-tmux-navigation').NvimTmuxNavigateLeft()<CR>", desc = "Tmux navigate left" },
      { "<C-j>", "<cmd>lua require('nvim-tmux-navigation').NvimTmuxNavigateDown()<CR>", desc = "Tmux navigate down" },
      { "<C-k>", "<cmd>lua require('nvim-tmux-navigation').NvimTmuxNavigateUp()<CR>", desc = "Tmux navigate up" },
      { "<C-l>", "<cmd>lua require('nvim-tmux-navigation').NvimTmuxNavigateRight()<CR>", desc = "Tmux navigate right" },
    },
  },
  {
    "almo7aya/openingh.nvim",
    keys = {
      { "gh", ":OpenInGHRepo<CR>", desc = "Open in GitHub repo" },
    },
  },
  {
    "ThePrimeagen/harpoon",
    setup = function()
      require("telescope").load_extension("harpoon")
    end,
    keys = {
      { "<leader>ha", ':lua require("harpoon.mark").add_file()<CR>', desc = "Harpoon mark" },
      { "<leader>hh", ":Telescope harpoon marks<CR>", desc = "Harpoon menu" },
      { "<leader>h]", ':lua require("harpoon.ui").nav_next()<CR>', desc = "Harpoon nav next" },
      { "<leader>h[", ':lua require("harpoon.ui").nav_prev()<CR>', desc = "Harpoon nav prev" },
      { "<leader>h1", ':lua require("harpoon.ui").nav_file(1)<CR>', desc = "Harpoon nav 1" },
      { "<leader>h2", ':lua require("harpoon.ui").nav_file(2)<CR>', desc = "Harpoon nav 2" },
      { "<leader>h3", ':lua require("harpoon.ui").nav_file(3)<CR>', desc = "Harpoon nav 3" },
      { "<leader>h4", ':lua require("harpoon.ui").nav_file(4)<CR>', desc = "Harpoon nav 4" },
      { "<leader>h5", ':lua require("harpoon.ui").nav_file(5)<CR>', desc = "Harpoon nav 5" },
      { "<leader>h6", ':lua require("harpoon.ui").nav_file(6)<CR>', desc = "Harpoon nav 6" },
      { "<leader>h7", ':lua require("harpoon.ui").nav_file(7)<CR>', desc = "Harpoon nav 7" },
      { "<leader>h8", ':lua require("harpoon.ui").nav_file(8)<CR>', desc = "Harpoon nav 8" },
      { "<leader>h9", ':lua require("harpoon.ui").nav_file(9)<CR>', desc = "Harpoon nav 9" },
      { "<leader>h0", ':lua require("harpoon.ui").nav_file(0)<CR>', desc = "Harpoon nav 0" },
    },
  },
}
