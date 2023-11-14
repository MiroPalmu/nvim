return {
    "f-person/git-blame.nvim",
    config = function()
        require('gitblame').setup {
            enabled = true,
            date_format = "%r",
            -- Make colors work with cursorline
            highlight_group = "CursorLine",
        }
    end
}
