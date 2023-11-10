return {
    "Everblush/nvim",
    name = "everblush",
    config = function()
        require('everblush').setup({

--            override = { Normal = { fg = '#dadada', bg = '#000000' }},
--            transparent_background = true,
--            nvim_tree = {
--                contrast = true,
--            },

        })

        vim.cmd("colorscheme everblush")
    end,
}
