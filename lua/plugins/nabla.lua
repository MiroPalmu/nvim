return {
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
