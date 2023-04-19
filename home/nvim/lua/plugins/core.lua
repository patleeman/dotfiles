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
    "wakatime/vim-wakatime",
  },
  -- Disable built in mini.bufremove and replace with bufdelete so we can re-open alpha when all buffers closed
  { "echasnovski/mini.bufremove", enabled = false },
  {
    "famiu/bufdelete.nvim",
    keys = {
      {
        "<leader>bd",
        function()
          require("bufdelete").bufdelete(0, false)
        end,
        desc = "Delete Buffer",
      },
      {
        "<leader>bD",
        function()
          require("bufdelete").bufdelete(0, true)
        end,
        desc = "Delete Buffer (Force)",
      },
    },
  },
}
