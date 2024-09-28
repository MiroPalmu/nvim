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
        max_height = 12,
        max_width_window_percentage = math.huge,
        max_height_window_percentage = math.huge,
        window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
        tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
        HIJACK_FILE_PATTERNS = { "*.PNG", "*.JPG", "*.JPEG", "*.GIF", "*.WEBP", "*.AVIF" }, -- RENDER IMAGE FILES AS IMAGES WHEN OPENED
    },
}
return {
    "benlubas/molten-nvim",
    dependencies = {
        image_plugin_spec,
    },
    build = ":UpdateRemotePlugins",
    init = function()
        vim.g.python3_host_prog = vim.fn.expand("~/data/scratch/molten-nvim-venv/bin/python3")
        -- these are examples, not defaults. Please see the readme
        vim.g.molten_image_provider = "image.nvim"
        vim.g.molten_output_win_max_height = 20
    end,
}
