return {
    "Everblush/nvim",
    name = "everblush",
    config = function()
        -- Custom comment color for better visibility
        local comment_color = {
            fg = "#00FFFF",
            italic = true
        }

        -- Everblush pallette color 8 (#2d3437) is not very visible
        -- so define new one
        local custom_color8 = "#ffea00"
        vim.g.terminal_color_8 = custom_color8

        require('everblush').setup({
            -- See: https://github.com/Everblush/nvim/blob/main/lua/everblush/theme.lua
            -- for documentation what can be overridden
            override = {
                Comment = comment_color,
                ["@comment"] = comment_color,
                -- Custom line number color for better visibility
                LineNr = { fg = "#C47220" },
                -- Custom vertical buffer separator
                WinSeparator = { fg = "#000000" },
                -- Cursor line line number
                CursorLineNr = comment_color,
                -- Set all which use color 8
                ["@exception"] = { fg = custom_color8 },
                ["@float"] = { fg = custom_color8 },
                ["@text.danger"] = { fg = custom_color8 },
                ["@text.note"] = { fg = custom_color8 },
            },
            -- Background comes from underlying terminal
            transparent_background = true,
        })

        vim.cmd("colorscheme everblush")
    end,
}
