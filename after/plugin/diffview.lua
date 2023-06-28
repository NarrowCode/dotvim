-- Code review helper to diff to develop
vim.keymap.set("n", "<leader>gd", "<cmd>:DiffviewOpen develop...HEAD<cr>",
  {silent = true, noremap = true}
)

vim.keymap.set("n", "<leader>gb", "<cmd>:DiffviewOpen<cr>",
  {silent = true, noremap = true}
)


-- Diff from HEAD to arbitrary target
function diffTarget()
  local target = vim.fn.input("Enter a target to diff to: ")
  if (target == nil or target == '') then target = "develop" end
  vim.cmd(":DiffviewOpen " .. target .. "...HEAD")
  print("Displaying diff from `HEAD` to `" .. target .. "`.")
end

vim.keymap.set("n", "<leader>gt", function() diffTarget() end)

