-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap
local opt = { noremap = true, silent = true }

--formatting keymap for neoformat just for chsarp
keymap.set("n", "<leader>nf", ":Neoformat<CR>", opt)

keymap.set("n", "<A-j>", ":m .+1<CR>==", opt) -- move line up(n)
keymap.set("n", "<A-k>", ":m .-2<CR>==", opt) -- move line down(n)
keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", opt) -- move line up(v)
keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", opt) -- move line down(v)

keymap.set("n", "<leader>ch", ":Cheatsheet<CR>", opt)

-- Function to toggle line numbers
function ToggleLineNumbers()
  if vim.wo.number and vim.wo.relativenumber then
    vim.wo.number = true
    vim.wo.relativenumber = false
  elseif vim.wo.number then
    vim.wo.relativenumber = true
  else
    vim.wo.number = true
  end
end

-- Keymap to toggle line numbers
keymap.set("n", "<leader>tl", ":lua ToggleLineNumbers()<CR>", opt)
