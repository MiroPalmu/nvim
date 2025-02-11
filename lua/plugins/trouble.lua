return {
    "folke/trouble.nvim",
    -- No icons, please.
    -- dependencies = { "nvim-tree/nvim-web-devicons" },
    -- Settings without a patched font or icons.
    config = function()


        opts = {
            icons = false,
            fold_open = "v", -- icon used for open folds
            fold_closed = ">", -- icon used for closed folds
            indent_lines = false, -- add an indent guide below the fold icons
            -- signs = {
            --     -- icons / text used for a diagnostic
            --     error = "error",
            --     warning = "warn",
            --     hint = "hint",
            --     information = "info"
            -- },
            use_diagnostic_signs = true, -- enabling this will use the signs defined in your lsp client

        }

        require('trouble').setup(opts)

        -- Set label for "<leader>x" using which-key notation
        require("which-key").add({
            { "<leader>x", group = "Trouble" },
        })

        -- Lua
        vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end, {
            desc = "Toggle",
        })
        vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end, {
            desc = "Toggle workspace diagnostics",
        })
        vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end, {
            desc = "Toggle document diagnostrics",
        })
        vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end, {
            desc = "Toggle quickfix",
        })
        vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end, {
            desc = "Toggle loclist",
        })
        vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end, {
            desc = "Toggle lsp reference",
        })
    end
}
