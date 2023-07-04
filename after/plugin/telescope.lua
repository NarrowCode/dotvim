local builtin = require('telescope.builtin')
local lga_actions = require("telescope-live-grep-args.actions")

local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local sorters = require('telescope.sorters')
local actions = require('telescope.actions')

-- define your keybindings
local keybindings = {
  {"<leader>ff", "[TELESCOPE] Find files in the current directory"},
  {"<leader>bf", "[TELESCOPE] List current buffers"},
  {"<leader>sy", "[TELESCOPE] List document symbols"},
  {"<leader>tp", "[TELESCOPE] List builtin telescope commands"},
  {"<leader>ps", "[TELESCOPE] String grep"},
  {"<leader>fg", "[TELESCOPE] Live grep with rg support"},
  {"<C>p", "[TELESCOPE] List Git files"},

  {"<leader>gd", "[GIT] Git diff to HEAD"},
  {"<leader>ll", "[LSP] Toggle LSP lines newline / inline"},
  {"<leader>lo", "[LSP] Toggle LSP lines on / off"},

  {"<leader>gs", "[GIT] Open Neogit"},

  {"<leader>xx", "[DIA] Trouble Toggle"},
  {"<leader>xw", "[DIA] Workspace Diagnostics"},
  {"<leader>xd", "[DIA] Document Diagnostics"},
  {"<leader>xl", "[DIA] Loclist"},
  {"<leader>xq", "[DIA] Quickfix"},
  {"gR", "[DIA] LSP References"},

  -- add your other keybinds here
}

function ShowKeybindings()
  pickers.new({}, {
    prompt_title = 'Keybindings',
    finder = finders.new_table({
      results = keybindings,
      entry_maker = function(entry)
        return {
          value = entry[1],
          display = entry[1] .. " - " .. entry[2],
          ordinal = entry[1] .. " - " .. entry[2],
        }
      end,
    }),
    sorter = sorters.get_generic_fuzzy_sorter(),
    attach_mappings = function(_, map)
      map('i', '<CR>', actions.close)
      return true
    end,
  }):find()
end

local function find_files_short()
  builtin.find_files({
    path_display = { shorten = { len = 5, exclude = {1, -1} } },
    attach_mappings = function(_, map)
      map('i', '<CR>', actions.select_default + actions.center)
      return true
    end,
  })
end

local function find_files_full()
  builtin.find_files({
    attach_mappings = function(_, map)
      map('i', '<CR>', actions.select_default + actions.center)
      return true
    end,
  })
end

local function find_git_short()
  builtin.git_files({
    path_display = { shorten = { len = 5, exclude = {1, -1} } },
    attach_mappings = function(_, map)
      map('i', '<CR>', actions.select_default + actions.center)
      return true
    end,
  })
end

local function find_git_full()
  builtin.git_files({
    attach_mappings = function(_, map)
      map('i', '<CR>', actions.select_default + actions.center)
      return true
    end,
  })
end

vim.keymap.set('n', '<leader>ff', find_files_short, {})
vim.keymap.set('n', '<leader>FF', find_files_full, {})
vim.keymap.set('n', '<C-p>', find_git_short, {})
vim.keymap.set('n', '<C-del>', find_git_full, {})
vim.keymap.set('n', '<leader>bf', builtin.buffers, {})
vim.keymap.set('n', '<leader>sy', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>tp', builtin.builtin, {})
vim.keymap.set('n', '<leader>k', '<cmd>lua ShowKeybindings()<CR>', {noremap = true, silent = true})

-- This requires `ripgrep` to be installed
vim.keymap.set('n', '<leader>ps', function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")

local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

local telescope = require("telescope")

telescope.setup {
  defaults = {
    mappings = {
      i = { ["<c-t>"] = trouble.open_with_trouble },
      n = { ["<c-t>"] = trouble.open_with_trouble },
    },
  },
  extensions = {
    live_grep_args = {
      prompt_title = "Live Grep",
      shorten_path = true,
      auto_quoting = true,
      mappings = {
        i = { ["<C-l>"] = lga_actions.quote_prompt({ postfix = " --iglob " }) },
      },
    },
  },
}
