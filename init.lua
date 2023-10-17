-- A TAB character looks like 4 spaces
vim.o.tabstop = 4
-- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.expandtab = true
-- Number of spaces inserted instead of a TAB character
vim.o.softtabstop = 4
-- Number of spaces inserted when indenting
vim.o.shiftwidth = 4

vim.o.smartindent = true

-- lazy.nvim

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

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


local plugins = {
    {
        "neovim/nvim-lspconfig"
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function () 
           local configs = require("nvim-treesitter.configs")

           configs.setup({
               ensure_installed = { "latex", "lua", "vim", "vimdoc", "c", "cpp", "python" },
               sync_install = false,
               highlight = { enable = true },
               indent = { enable = false },  
           })
        end
    },
	{
		"ggandor/leap.nvim",
		config = function()
			require('leap').add_default_mappings()
		end

	},
    {
        "rhysd/vim-clang-format"
    },
    {
        "MiroPalmu/nabla.nvim", enabled=false,
        dependencies = {"nvim-treesitter/nvim-treesitter", "folke/tokyonight.nvim"},

        config = function()
            vim.cmd("colorscheme tokyonight")

            -- Customize with popup({border = ...}) 
            --    * `single` (default)
            --    * `double`
            --    * `rounded`
            -- vim.cmd("nnoremap <leader>p :lua require('nabla').popup()<CR>")
            
            require("nabla").enable_virt({
                autogen = true, -- auto-regenerate ASCII art when exiting insert mode
                silent = false,     -- silents error messages
                border = "single"
            })
        end
    }


}

require("lazy").setup(plugins)
