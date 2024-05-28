return {
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
  },
  config = function()
    vim.diagnostic.config({
      virtual_text = false,
    })
    require("lsp_lines").setup()
  end,
  keys = {
    { "<leader>ct", '<cmd>lua require("lsp_lines").toggle()<cr>', desc = "Toggle lsp_lines diagnostics" },
  },
}
