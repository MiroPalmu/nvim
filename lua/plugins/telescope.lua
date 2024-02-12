local M = { "nvim-telescope/telescope.nvim", branch = "0.1.x" }

M.dependencies = {
    "nvim-lua/plenary.nvim",
    "BurntSushi/ripgrep",
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' 
    },
}

function M.config()
    local builtin = require('telescope.builtin')

    -- Set label for "<leader>t" using which-key notation
    require("which-key").register({ ["<leader>t"] = { name = "Telescope" } })

    -- Set keymaps using native notation but set desc
    -- which which-key can use.
    vim.keymap.set('n', '<leader>f', builtin.find_files, {
        desc = "Find File",
    })
    vim.keymap.set('n', '<leader>g', builtin.live_grep, {
        desc = "Live Grep",
    })
    vim.keymap.set('n', '<leader>b', builtin.buffers, {
        desc = "List open Buffers",
    })
    vim.keymap.set('n', '<leader>th', builtin.help_tags, {
        desc = "List available Help tags",
    })
    vim.keymap.set('n', '<leader>tk', builtin.keymaps, {
        desc = "List normal mode Keymappings",
    })

    require('telescope').setup{
        defaults = {
          -- Default configuration for telescope goes here:
          -- config_key = value,
          mappings = {
            i = {
              -- map actions.which_key to <C-h> (default: <C-/>)
              -- actions.which_key shows the mappings for your picker,
              -- e.g. git_{create, delete, ...}_branch for the git_branches picker
              ["<C-h>"] = "which_key"
            }
          }
        },
        pickers = {
          -- Default configuration for builtin pickers goes here:
          -- picker_name = {
          --   picker_config_key = value,
          --   ...
          -- }
          -- Now the picker_config_key will be applied every time you call this
          -- builtin picker
        },
        extensions = {
          -- Your extension configuration goes here:
          -- extension_name = {
          --   extension_config_key = value,
          -- }
          -- please take a look at the readme of the extension you want to configure
            fzf = {
                fuzzy = true,                    -- false will only do exact matching
                override_generic_sorter = true,  -- override the generic sorter
                override_file_sorter = true,     -- override the file sorter
                case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
            },
        }
    }
end

return M
