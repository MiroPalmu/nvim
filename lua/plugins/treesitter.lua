matchup_plugin_spec = {
    "andymass/vim-matchup",
    setup = function()
        vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
}

return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        matchup_plugin_spec,
    },
    build = ":TSUpdate",
    config = function () 
       local configs = require("nvim-treesitter.configs")

       configs.setup({
           -- Enables interoperation with matchup plugin.
           -- From: https://github.com/andymass/vim-matchup#tree-sitter-integration
           matchup = {
               enable = true,
           },
           ensure_installed = {
               "bash",
               "git_config",
               "git_rebase",
               "gitattributes",
               "gitcommit",
               "gitignore",
               "meson",
               "ninja",
               "make",
               "cmake",
               "regex",
               "latex",
               "lua",
               "vim",
               "vimdoc",
               "c",
               "cpp",
               "python",
               "markdown",
            },
           sync_install = false,
           highlight = { enable = true },
           indent = { enable = true },
           additionnal_vim_regex_highlighting = false,

           incremental_selection = {
               enable = true,
               keymaps = {
                   init_selection = "gnn", -- set to `false` to disable one of the mappings
                   node_incremental = "grn",
                   scope_incremental = "grc",
                   node_decremental = "grm",
               }
           },
       })
    end
}
