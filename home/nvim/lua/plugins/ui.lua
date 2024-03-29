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
    enabled = false,
  },
  {
    "goolord/alpha-nvim",
    enabled = false,
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      top_down = false,
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      sections = {
        lualine_y = {
          { "progress", separator = " ", padding = { left = 1, right = 1 } },
        },
        lualine_z = {
          { "location", padding = { left = 1, right = 1 } },
        },
      },
    },
  },
  {
    "sitiom/nvim-numbertoggle",
  },
}
