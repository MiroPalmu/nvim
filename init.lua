-- A TAB character looks like 4 spaces
vim.o.tabstop = 4
-- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.expandtab = true
-- Number of spaces inserted instead of a TAB character
vim.o.softtabstop = 4
-- Number of spaces inserted when indenting
vim.o.shiftwidth = 4

vim.o.smartindent = true

-- Highlight cursor line
vim.o.cursorline = true
-- Keep status line for all windows at bottom of screen
-- https://github.com/neovim/neovim/pull/17266
vim.o.laststatus = 3
-- Hide commandline
-- vim.o.cmdheight=0

-- Start scrolling before cursor at edge of screen
vim.o.scrolloff = 5

-- Use smartcase in seach, i.e. ignore case excpet when capitalized letters appear in seach.
-- Note that \c and \C can be made to override this.

vim.o.ignorecase = true
vim.o.smartcase = true

-- Disable noisy diagnostic messages. Use only underline.
vim.diagnostic.config({
    virtual_text = false,
    signs = false,
})

-- Keymaps:
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', {
    desc = "Exit terminal mode"
})

vim.keymap.set({'i', 't'}, '<A-h>', '<C-\\><C-N><C-w>h', {
    desc = "Move to left [windows]",
})
vim.keymap.set({'i', 't'}, '<A-j>', '<C-\\><C-N><C-w>j', {
    desc = "Move to down [windows]",
})
vim.keymap.set({'i', 't'}, '<A-k>', '<C-\\><C-N><C-w>k', {
    desc = "Move to up [windows]",
})
vim.keymap.set({'i', 't'}, '<A-l>', '<C-\\><C-N><C-w>l', {
    desc = "Move to right [windows]",
})
vim.keymap.set('n', '<A-h>', '<C-w>h', {
    desc = "Move to left [windows]",
})
vim.keymap.set('n', '<A-j>', '<C-w>j', {
    desc = "Move to down [windows]",
})
vim.keymap.set('n', '<A-k>', '<C-w>k', {
    desc = "Move to up [windows]",
})
vim.keymap.set('n', '<A-l>', '<C-w>l', {
    desc = "Move to right [windows]",
})
vim.keymap.set('n', '<leader>.', '<CMD>term<CR>', {
    desc = "Open terminal",
})

-- lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
