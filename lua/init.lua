return {
    "neovim/nvim-lspconfig",
    "rhysd/vim-clang-format",
    {
        "ggandor/leap.nvim",
        config = function() require('leap').add_default_mappings() end 
    }
}
