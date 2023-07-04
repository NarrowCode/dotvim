local lsp = require("lsp-zero")
local lspkind = require('lspkind')
local ls = require("luasnip")
require("luasnip.loaders.from_snipmate").load()
require("luasnip.loaders.from_snipmate").lazy_load { paths = { "~/.vim/snippets" } }

ls.filetype_extend("all", { "snippets" })


lsp.preset("recommended")

require 'nvim-treesitter.install'.compilers = { "zig", "gcc" }

lsp.ensure_installed({
  'tsserver',
  'eslint',
  'rust_analyzer',
})

vim.filetype.add({
  extension = {
    astro = "astro"
  }
})

-- Fix Undefined global 'vim'
lsp.configure('lua-language-server', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
  -- Add compatibility fallback for terminals that can't handle Ctrl-Space
  ["<C-s>"] = cmp.mapping.complete(),
  ["<C-.>"] = cmp.mapping(function(fallback)
    if ls.expand_or_jumpable() then
      ls.expand_or_jump()
    end
  end, { "i", "s" }),
  ["<C_,>"] = cmp.mapping(function(fallback)
    if ls.jumpable(-1) then
      ls.jump(-1)
    end
  end, { "i", "s" }),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<CR>'] = nil
-- cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings,
  formatting = {
    format = lspkind.cmp_format({
      mode = 'text_symbol',
      maxWidth = 50,
      ellipsis_char = "...",
      symbol_map = {
        Text = "",
        Method = "",
        Function = "",
        Constructor = "",
        Field = "ﰠ",
        Variable = "",
        Class = "ﴯ",
        Interface = "",
        Module = "",
        Property = "ﰠ",
        Unit = "塞",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "פּ",
        Event = "",
        Operator = "",
        TypeParameter = ""
      },
      before = function(entry, vim_item)
        vim_item.kind = lspkind.symbolic(vim_item.kind)

        return vim_item
      end
    })
  },
  snippet = {
    expand = function(args)
      ls.lsp_expand(args.body)
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }
})


lsp.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = {
    error = '❌',
    warn = '🔔',
    hint = '👋',
    info = '🥸'
  }
})

require("symbols-outline").setup()

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "gh", function() vim.lsp.buf.hover() end, opts)
  -- vim.keymap.set("n", "ge", function() vim.diagnostic.show_line_diagnostics() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "g]", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "g[", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>ga", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>gr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
  vim.keymap.set("i", "<C-s>", function() vim.lsp.buf.completion() end, opts)
  vim.keymap.set("i", "<C-Space>", function() vim.lsp.buf.completion() end, opts)
  vim.keymap.set("n", "<leader>gl", function() require("lsp_lines").toggle() end, opts)
  vim.keymap.set('n', '<leader>so', ':SymbolsOutline<CR>', { noremap = true, silent = true })

  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = bufnr,
    callback = function()
      --vim.cmd("LspZeroFormat", { silent = true })
      -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
      vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 5000, async = false })
      --vim.lsp.buf.formatting_sync()
    end,
  })
end)

lsp.setup()

vim.diagnostic.config({
  -- No virtual text, we're using lsp_lines for that.
  virtual_text = false,
  virtual_lines = true,
  float = {
    -- Focusable so I can copy / paste from diag folds.
    focusable = true,
  }
})

require("lsp_lines").setup()


-- local null_ls = require("null-ls")
-- Format on save
-- vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
-- vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()]]
