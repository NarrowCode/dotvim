local null_ls = require("null-ls")
local h = require("null-ls.helpers")
local methods = require("null-ls.methods")
local u = require("null-ls.utils")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local prettier_script = os.getenv('HOME') .. "/.vim/run-prettier.sh"

local FORMATTING = methods.internal.FORMATTING
local RANGE_FORMATTING = methods.internal.RANGE_FORMATTING

local function get_git_root()
    local handle = io.popen("git rev-parse --show-toplevel 2> /dev/null") -- runs command
    local result = handle:read("*a"):gsub("%s+$", "") -- trims output
    handle:close()

    return result ~= "" and result or nil -- return nil if not a git repository
end

require("null-ls").setup({
  sources = {
    null_ls.builtins.completion.spell,
    null_ls.builtins.formatting.rustfmt,
    h.make_builtin({
      method = { FORMATTING, RANGE_FORMATTING },
      filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "css",
        "scss",
        "less",
        "html",
        "json",
        "jsonc",
        "yaml",
        "markdown",
        "markdown.mdx",
        "graphql",
        "handlebars",
      },
      generator_opts = {
        command = prettier_script,
        to_stdin = true,
        args = h.range_formatting_args_factory({
                    "--stdin-filepath",
                    "$FILENAME",
                }, "--range-start", "--range-end", { row_offset = -1, col_offset = -1 }),
        --cwd = h.cache.by_bufnr(function(params)
        --      local root_dir = u.root_pattern(
        --          -- https://prettier.io/docs/en/configuration.html
        --          ".prettierrc",
        --          ".prettierrc.json",
        --          ".prettierrc.yml",
        --          ".prettierrc.yaml",
        --          ".prettierrc.json5",
        --          ".prettierrc.js",
        --          ".prettierrc.cjs",
        --          ".prettierrc.toml",
        --          "prettier.config.js",
        --          "prettier.config.cjs",
        --          "package.json"
        --      )(params.bufname)
        --      vim.notify(root_dir)
        --      return root_dir
        --  end),
      },
      factory = h.formatter_factory,
      timeout = 10000,
    })
  },
  debug = true
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
