local null_ls = require("null-ls")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
require("null-ls").setup({
  sources = {
    null_ls.builtins.completion.spell,
    null_ls.builtins.formatting.prettier, -- Make sure prettier is on the $PATH.
    null_ls.builtins.formatting.rustfmt
  },
  -- debug = true, -- Enable and use :NullLsLog to debug.
  -- you can reuse a shared lspconfig on_attach callback here
})

local callback = function()
  vim.lsp.buf.format({
    bufnr = bufnr,
    filter = function(client)
      return client.name == "null-ls"
    end
  })
end
