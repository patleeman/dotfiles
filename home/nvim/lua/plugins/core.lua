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
}
