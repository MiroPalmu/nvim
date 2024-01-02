local M = { "neovim/nvim-lspconfig" }

function M.config()
    -- Setup language servers.
    local lspconfig = require('lspconfig')
    lspconfig.pyright.setup {}
    lspconfig.clangd.setup{}


    -- Global mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, {
        desc = "Open diagnostics (external tools)",
    })
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {
        desc = "Goto Previous diagnostic",
    })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {
        desc = "Goto Next diagnostic",
    })
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, {
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
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, vim.tbl_deep_extend("error", opts, {
            desc = "Add Workspace folder",
        }))
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, vim.tbl_deep_extend("error", opts, {
            desc = "Remove Workspace folder",
        }))
        vim.keymap.set('n', '<space>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, vim.tbl_deep_extend("error", opts, {
                desc = "List Workspace forlder",
            }))
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, vim.tbl_deep_extend("error", opts, {
            desc = "Type definition",
        }))
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, vim.tbl_deep_extend("error", opts, {
            desc = "Rename",
        }))
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, vim.tbl_deep_extend("error", opts, {
            desc = "Code Action",
        }))
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, vim.tbl_deep_extend("error", opts, {
            desc = "Goto references",
        }))
        vim.keymap.set('n', '<space>f', function()
          vim.lsp.buf.format { async = true }
        end, vim.tbl_deep_extend("error", opts, {
                desc = "Format file",
            }))
      end,
    })
end
return M
