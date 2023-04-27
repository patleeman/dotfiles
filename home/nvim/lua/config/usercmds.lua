-- Utility to get listed buffers
local function get_listed_buffers()
  local buffers = {}
  local len = 0
  for buffer = 1, vim.fn.bufnr("$") do
    if vim.fn.buflisted(buffer) == 1 then
      len = len + 1
      buffers[len] = buffer
    end
  end

  return buffers
end

-- Utility to clear no name buffers
local function clearNoNameBuffers()
  local buffers = get_listed_buffers()
  for _, bufnr in ipairs(buffers) do
    local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
    local name = vim.api.nvim_buf_get_name(bufnr)
    if ft == "" and name == "" then
      vim.api.nvim_buf_delete(bufnr, {})
    end
  end
end
-- Command to delete all buffers
vim.api.nvim_create_user_command("BDeleteAll", function()
  local buffers = get_listed_buffers()
  for _, bufnr in ipairs(buffers) do
    local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
    local name = vim.api.nvim_buf_get_name(bufnr)
    if ft ~= "Alpha" and name ~= "" then
      vim.api.nvim_buf_delete(bufnr, {})
    end
  end
end, { desc = "Delete all buffers" })
