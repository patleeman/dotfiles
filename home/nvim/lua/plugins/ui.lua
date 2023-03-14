return {
  {
    "rose-pine/neovim",
    lazy = false,
    priority = 1000,
    name = "rose-pine",
    config = function()
      vim.cmd("colorscheme rose-pine")
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<leader>nn", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
    },
    config = function()
      require("neo-tree").setup({
        window = {
          width = 30,
        },
      })
    end,
  },
}
