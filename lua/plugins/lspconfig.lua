local M = { "neovim/nvim-lspconfig" }

M.dependencies = {
    "neovim/nvim-lspconfig",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    {
        "j-hui/fidget.nvim",
        opts = {},
    },
}

-- cmp setup at bottom of this function
function M.config()
    -- Setup language servers.
    local lspconfig = require('lspconfig')
    lspconfig.pyright.setup {}
    lspconfig.clangd.setup{}
    lspconfig.gdscript.setup{}
    lspconfig.gdshader_lsp.setup{}
    lspconfig.bashls.setup{}

    -- Global mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {
        desc = "Open diagnostics (external tools)",
    })
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {
        desc = "Goto Previous diagnostic",
    })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {
        desc = "Goto Next diagnostic",
    })
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, {
        desc = "Add buffer diagnostics to the location list",
    })

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, vim.tbl_deep_extend("error", opts, {
            desc = "Goto Declaration",
        }))
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_deep_extend("error", opts, {
            desc = "Goto Definition",
        }))
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_deep_extend("error", opts, {
            desc = "Hover information",
        }))
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, vim.tbl_deep_extend("error", opts, {
            desc = "Goto Implementation",
        }))
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, vim.tbl_deep_extend("error", opts, {
            desc = "Signature help",
        }))

        -- Set label for "<leader>w" using which-key notation
        require("which-key").register({ ["<leader>w"] = { name = "Lsp Workspaces" } })
        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, vim.tbl_deep_extend("error", opts, {
            desc = "Add Workspace folder",
        }))
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, vim.tbl_deep_extend("error", opts, {
            desc = "Remove Workspace folder",
        }))
        vim.keymap.set('n', '<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, vim.tbl_deep_extend("error", opts, {
                desc = "List Workspace forlder",
            }))
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, vim.tbl_deep_extend("error", opts, {
            desc = "Type definition",
        }))
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, vim.tbl_deep_extend("error", opts, {
            desc = "Rename",
        }))
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, vim.tbl_deep_extend("error", opts, {
            desc = "Code Action",
        }))
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, vim.tbl_deep_extend("error", opts, {
            desc = "Goto references",
        }))
        vim.keymap.set({ 'n', 'v'}, '<leader>v', function() vim.lsp.buf.format { async = true } end,
                vim.tbl_deep_extend("error", opts, {
                desc = "Format file",
        }))
      end,
    })

    ---------------
    -- cmp setup --
    ---------------
    -- Enable some language servers with the additional completion capabilities offered by nvim-cmp
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local servers = { 'clangd',  'pyright' }
    for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
            -- on_attach = my_custom_on_attach,
            capabilities = capabilities,
        }
    end

    -- nvim-cmp setup
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    cmp.setup {
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
            ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
            -- C-b (back) C-f (forward) for snippet placeholder navigation.
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            },
            ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { 'i', 's' }),
        }),
        sources = {
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'path' },
        },
    }
end
return M
