local neogit = require('neogit')

neogit.setup {
  integrations = {
    diffview = true
  }
}

vim.keymap.set("n", "<leader>gs", function() neogit.open() end);
