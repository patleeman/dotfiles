return {
  {
    "kdheepak/lazygit.nvim",
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
  -- {
  --   "ThePrimeagen/harpoon",
  --   config = function()
  --     require("telescope").load_extension("harpoon")
  --   end,
  --   keys = {
  --     { "<leader>ha", '<cmd>lua require("harpoon.mark").add_file()<CR>', desc = "Add file to Harpoon" },
  --     {
  --       "<leader>hh",
  --       '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>',
  --       desc = "Toggle Harpoon quick menu",
  --     },
  --     { "<leader>hf", "<cmd>Telescope harpoon marks<CR>", desc = "Fuzzy find harpoon marks" },
  --     { "<leader>h1", '<cmd>lua require("harpoon.ui").nav_file(1)<CR>', desc = "Navigate to first harpoon file" },
  --     { "<leader>h2", '<cmd>lua require("harpoon.ui").nav_file(2)<CR>', desc = "Navigate to second harpoon file" },
  --     { "<leader>h3", '<cmd>lua require("harpoon.ui").nav_file(3)<CR>', desc = "Navigate to third harpoon file" },
  --     { "<leader>h4", '<cmd>lua require("harpoon.ui").nav_file(4)<CR>', desc = "Navigate to fourth harpoon file" },
  --     {
  --       "<leader>h5",
  --       '<cmd>lua require("harpoon.ui").nav_file(5)<CR>',
  --       desc = "Navigate to fifth ff harpoon file",
  --     },
  --   },
  -- },
  -- Super Tab
  -- {
  --   "L3MON4D3/LuaSnip",
  --   keys = function()
  --     return {}
  --   end,
  -- },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = {
  --     "hrsh7th/cmp-emoji",
  --   },
  --   ---@param opts cmp.ConfigSchema
  --   opts = function(_, opts)
  --     local has_words_before = function()
  --       unpack = unpack or table.unpack
  --       local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  --       return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  --     end
  --
  --     local luasnip = require("luasnip")
  --     local cmp = require("cmp")
  --
  --     opts.mapping = vim.tbl_extend("force", opts.mapping, {
  --       ["<Tab>"] = cmp.mapping(function(fallback)
  --         if cmp.visible() then
  --           cmp.select_next_item()
  --         -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
  --         -- they way you will only jump inside the snippet region
  --         elseif luasnip.expand_or_jumpable() then
  --           luasnip.expand_or_jump()
  --         elseif has_words_before() then
  --           cmp.complete()
  --         else
  --           fallback()
  --         end
  --       end, { "i", "s" }),
  --       ["<S-Tab>"] = cmp.mapping(function(fallback)
  --         if cmp.visible() then
  --           cmp.select_prev_item()
  --         elseif luasnip.jumpable(-1) then
  --           luasnip.jump(-1)
  --         else
  --           fallback()
  --         end
  --       end, { "i", "s" }),
  --     })
  --   end,
  -- },
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
  -- {
  --   "jakewvincent/mkdnflow.nvim",
  --   config = function()
  --     require("mkdnflow").setup()
  --   end,
  -- },
}
