return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        initial_mode = "normal",
        layout_strategy = "vertical",
        sorting_strategy = "ascending",
        layout_config = {
          prompt_position = "top",
          mirror = true,
        },
        mappings = {
          ["i"] = {
            ["<C-l>"] = require("telescope.actions").select_default,
            ["<C-h>"] = require("telescope.actions").select_default,
          },
          ["n"] = {
            ["l"] = require("telescope.actions").select_default,
            ["h"] = require("telescope.actions").select_default,
          },
        },
      },
    },
    keys = {
      { "<leader><space>", "<cmd>Telescope file_browser<cr>", desc = "Telescope file browser" },
      { "<leader>bf", "<cmd>Telescope buffers<cr>", desc = "Switch Buffer" },
      { "<leader>sn", "<cmd>Telescope notify<cr>", desc = "See all notifications" },
    },
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    lazy = false,
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        extensions = {
          file_browser = {
            hijack_netrw = true,
            grouped = true,
            auto_depth = true,
            collapse_dirs = true,
            select_buffer = true,
            display_stat = {
              mode = false,
            },
            hidden = {
              file_browser = false,
              folder_browser = false,
            },
            mappings = {
              ["i"] = {
                ["<C-h>"] = require("telescope").extensions.file_browser.actions.backspace,
              },
              ["n"] = {
                ["h"] = require("telescope").extensions.file_browser.actions.backspace,
              },
            },
          },
        },
      })
      require("telescope").load_extension("file_browser")
    end,
    keys = {
      {
        "<leader>e",
        "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>",
        desc = "Telescope file browser (cwd)",
      },
    },
  },
}
