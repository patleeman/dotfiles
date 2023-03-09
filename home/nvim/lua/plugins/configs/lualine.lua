local present, lualine  = pcall(require, "lualine")

if not present then
  return
end

local function lsp_status()
  return require('lsp-status').status()
end

local config = {
  options = {
    theme = 'solarized_dark',
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
  },
  tabline = {
    lualine_a = {'buffers'},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {lsp_status}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {},
    lualine_x = {'encoding', 'fileformat', 'filetype', 'filesize'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
}

lualine.setup(config)

