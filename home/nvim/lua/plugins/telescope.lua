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
          ["n"] = {
            ["l"] = require("telescope.actions").select_default,
            ["h"] = require("telescope.actions").select_default,
          },
        },
        file_ignore_patterns = {
          ".git/",
          "out/",
        },
      },
      pickers = {
        find_files = {
          find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
        },
      },
    },
    keys = {
      {
        "<leader><space>",
        ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
        desc = "Telescope file browser (cwd)",
      },
      {
        "<leader>e",
        ":Telescope file_browser<CR>",
        desc = "Telescope file browser",
      },
      { "<leader>bf", "<cmd>Telescope buffers<cr>", desc = "Switch Buffer" },
      { "<leader>n", "<cmd>Telescope notify<cr>", desc = "See all notifications" },
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
            collapse_dirs = false,
            select_buffer = true,
            respect_gitignore = false,
            display_stat = {
              mode = false,
            },
            hidden = {
              file_browser = true,
              folder_browser = true,
            },
            mappings = {
              ["i"] = {
                ["<C-h>"] = require("telescope").extensions.file_browser.actions.backspace,
                ["<C-H>"] = require("telescope").extensions.file_browser.actions.toggle_hidden,
              },
              ["n"] = {
                ["h"] = require("telescope").extensions.file_browser.actions.backspace,
                ["H"] = require("telescope").extensions.file_browser.actions.toggle_hidden,
              },
            },
          },
        },
      })
      require("telescope").load_extension("file_browser")
    end,
    keys = {},
  },
}
