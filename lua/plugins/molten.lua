image_plugin_spec = {
    "3rd/image.nvim",
    dependencies = {
        "vhyrro/luarocks.nvim",
        priority = 1001, -- this plugin needs to run before anything else
        opts = {
            rocks = { "magick" },
        },
    },
    opts = {
        -- default config
        backend = "ueberzug",
        integrations = {
            markdown = {
                enabled = true,
                clear_in_insert_mode = false,
                download_remote_images = true,
                only_render_image_at_cursor = false,
                filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
            },
            neorg = {
                enabled = true,
                clear_in_insert_mode = false,
                download_remote_images = true,
                only_render_image_at_cursor = false,
                filetypes = { "norg" },
            },
            html = {
                enabled = false,
            },
            css = {
                enabled = false,
            },
        },
        max_width = 100,
        max_height = 100,
        max_width_window_percentage = math.huge,
        max_height_window_percentage = math.huge,
        window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
        tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
        HIJACK_FILE_PATTERNS = { "*.PNG", "*.JPG", "*.JPEG", "*.GIF", "*.WEBP", "*.AVIF" }, -- RENDER IMAGE FILES AS IMAGES WHEN OPENED
    },
}

-- Provide a command to create a blank new Python notebook
-- note: the metadata is needed for Jupytext to understand how to parse the notebook.
-- if you use another language than Python, you should change it in the template.
local default_notebook = [[
  {
    "cells": [
     {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        ""
      ]
     }
    ],
    "metadata": {
     "kernelspec": {
      "display_name": "Python 3",
      "language": "python",
      "name": "python3"
     },
     "language_info": {
      "codemirror_mode": {
        "name": "ipython"
      },
      "file_extension": ".py",
      "mimetype": "text/x-python",
      "name": "python",
      "nbconvert_exporter": "python",
      "pygments_lexer": "ipython3"
     }
    },
    "nbformat": 4,
    "nbformat_minor": 5
  }
]]

local function new_notebook(filename)
    local path = filename .. ".ipynb"
    local file = io.open(path, "w")
    if file then
        file:write(default_notebook)
        file:close()
        vim.cmd("edit " .. path)
    else
        print("Error: Could not open new notebook file for writing.")
    end
end

return {
    "benlubas/molten-nvim",
    lazy = true,
    dependencies = {
        image_plugin_spec,
        {
            "GCBallesteros/jupytext.nvim",
            init = function()
            end,
            opts = {
                style = "markdown",
                output_extension = "md",
                force_ft = "markdown",
            },
        },
    },
    build = ":UpdateRemotePlugins",
    init = function()
        vim.g.python3_host_prog = vim.fn.expand("~/data/scratch/molten-nvim-venv/bin/python3")
        -- these are examples, not defaults. Please see the readme
        vim.g.molten_image_provider = "image.nvim"
        vim.g.molten_output_win_max_height = 100
        vim.g.molten_output_virt_lines = true

        vim.api.nvim_create_user_command(
            'NewNotebook',
            function(opts)
                new_notebook(opts.args)
            end,
            {
                nargs = 1,
                complete = 'file'
            }
        )
    end,
    config = function()
        vim.keymap.set("n", "<leader>mi", ":MoltenInit<CR>", {
            silent = true,
            desc = "Initialize Molten"
        })
        vim.keymap.set("n", "<leader>mo", ":MoltenEvaluateOperator<CR>", {
            silent = true,
            desc = "Evaluate operator"
        })
        vim.keymap.set("n", "<leader>ml", ":MoltenEvaluateLine<CR>", {
            silent = true,
            desc = "Evaluate line"
        })
        vim.keymap.set("n", "<leader>mr", ":MoltenReevaluateCell<CR>", {
            silent = true,
            desc = "Re-evaluate cell"
        })
        vim.keymap.set("v", "<leader>mv", ":<C-u>MoltenEvaluateVisual<CR>gv", {
            silent = true,
            desc = "Evaluate visual selection"
        })
        vim.keymap.set("n", "<leader>md", ":MoltenDelete<CR>", {
            silent = true,
            desc = "Molten delete cell"
        })
        vim.keymap.set("n", "<leader>mh", ":MoltenHideOutput<CR>", {
            silent = true,
            desc = "Hide output"
        })
        vim.keymap.set("n", "<leader>ms", ":noautocmd MoltenEnterOutput<CR>", {
            silent = true,
            desc = "Show/enter output"
        })
        vim.keymap.set("n", "<leader>mn", ":noautocmd MoltenNext<CR>", {
            silent = true,
            desc = "Goto next cell"
        })
        vim.keymap.set("n", "<leader>mp", ":noautocmd MoltenPrev<CR>", {
            silent = true,
            desc = "Goto previous cell"
        })
    end,
}
