set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=400, on_visual=true}
source ~/init.lua
