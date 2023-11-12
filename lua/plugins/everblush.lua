return {
    "Everblush/nvim",
    name = "everblush",
    config = function()
        -- Custom comment color for better visibility
        local comment_color = {
            fg = "#00FFFF",
            italic = true
        }

        require('everblush').setup({
            -- See: https://github.com/Everblush/nvim/blob/main/lua/everblush/theme.lua
            -- for documentation what can be overridden
            override = {
                Comment = comment_color,
                ["@comment"] = comment_color,
                -- Custom line number color for better visibility
                LineNr = { fg = "#C47220" },
            },

        })

        vim.cmd("colorscheme everblush")
    end,
}
