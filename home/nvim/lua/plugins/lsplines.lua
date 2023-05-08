return {
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  config = function()
    vim.diagnostic.config({
      virtual_text = false,
    })
    require("lsp_lines").setup()
  end,
  keys = {
    { "<leader>ct", 'lua require("lsp_lines").toggle()', desc = "Toggle lsp_lines diagnostics" },
  },
}
