return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
       local configs = require("nvim-treesitter.configs")

       configs.setup({
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
           }
       })
    end
}
