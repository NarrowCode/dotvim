local builtin = require('telescope.builtin')
local lga_actions = require("telescope-live-grep-args.actions")

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})

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
  }
}
