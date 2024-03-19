return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
    },
    event = { "InsertEnter", "CmdlineEnter" },
    -- Rest of the setup found in lspconfig.lua
}
