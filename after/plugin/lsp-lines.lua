local function toggleLspLines()
  vim.diagnostic.config({
    virtual_text = LspLinesEnabled,
    virtual_lines = not LspLinesEnabled,
    float = {
      focusable = true,
    }
  })
  LspLinesEnabled = not LspLinesEnabled
end

local function toggleLspVirtualText()
  if not LspVirtualEnabled then
    vim.diagnostic.config({
      virtual_text = true,
      virtual_lines = false,
    })
    LspLinesEnabled = false
  else
    vim.diagnostic.config({
      virtual_text = false,
      virtual_lines = false,
    })
  end
  LspVirtualEnabled = not LspVirtualEnabled
end

vim.keymap.set("n", "<leader>ll", function() toggleLspLines() end, { desc = "Toggle lsp_lines" })
vim.keymap.set("n", "<leader>lo", function() toggleLspVirtualText() end, { desc = "Toggle virtual text" })

LspLinesEnabled = true
LspVirtualEnabled = true
