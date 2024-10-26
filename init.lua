-- A TAB character looks like 4 spaces
vim.o.tabstop = 4
-- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.expandtab = true
-- Number of spaces inserted instead of a TAB character
vim.o.softtabstop = 4
-- Number of spaces inserted when indenting
vim.o.shiftwidth = 4

vim.o.smartindent = true

-- Highlight cursor line
vim.o.cursorline = true
-- Keep status line for all windows at bottom of screen
-- https://github.com/neovim/neovim/pull/17266
vim.o.laststatus = 3
-- Hide commandline
-- vim.o.cmdheight=0

-- Start scrolling before cursor at edge of screen
vim.o.scrolloff = 5

-- Use smartcase in seach, i.e. ignore case excpet when capitalized letters appear in seach.
-- Note that \c and \C can be made to override this.
vim.o.ignorecase = true
vim.o.smartcase = true

-- Disable noisy diagnostic messages. Use only underline.
vim.diagnostic.config({
    virtual_text = false,
    signs = false,
})

vim.o.breakindent = true

--  How quickly swap file will be written to disk.
vim.o.updatetime = 250 -- ms, default: 4000

-- How whitespaces are drawn:
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Show preview when subtituing:
vim.opt.inccommand = 'split'

-- Fold options:
vim.opt.foldcolumn = 'auto'

-- Line numbers:
vim.opt.number = false
vim.opt.relativenumber = true
vim.opt.numberwidth = 3
-- Note about above:
--
--     Relative line numbers are useful, absolute line numbers less so.
--
--     Option numberwidth controls the minimun number of columns to use for the line number.
--     By default it is 4 which is enough for 3 digit numbers. As we want only the relative numbers
--     and it is assumed that they are always 1 or 2 digits long, we can set numberwidth to 3.

-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Keymaps:
-- Make sure to set `map[localleader` before lazy so your mappings are correct-
vim.g.mapleader = " "
vim.g.maplocalleader = " "
    -- Note about above:
    --
    -- In a global plugin <Leader> should be used and in a filetype plugin
    -- <LocalLeader>.  "mapleader" and "maplocalleader" can be equal.  Although, if
    -- you make them different, there is a smaller chance of mappings from global
    -- plugins to clash with mappings for filetype plugins.  For example, you could
    -- keep "mapleader" at the default backslash, and set "maplocalleader" to an
    -- underscore.

vim.keymap.set({ 'n', 'v'} , '<Space>', '<Nop>') -- Maps keymaps colliding with leader to noop.
    -- Note about above:
    --
    -- For some reason vim.keymap.del({mode}, {lsh}) can not be used to delete
    -- the default keymaps in nvim. It can only be used to delete user-defined maps.
    -- The solution is to map the unwanted key to noop.

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', {
    desc = "Exit terminal mode"
})

vim.keymap.set({'i', 't'}, '<A-h>', '<C-\\><C-N><C-w>h', {
    desc = "Move to left [windows]",
})
vim.keymap.set({'i', 't'}, '<A-j>', '<C-\\><C-N><C-w>j', {
    desc = "Move to down [windows]",
})
vim.keymap.set({'i', 't'}, '<A-k>', '<C-\\><C-N><C-w>k', {
    desc = "Move to up [windows]",
})
vim.keymap.set({'i', 't'}, '<A-l>', '<C-\\><C-N><C-w>l', {
    desc = "Move to right [windows]",
})
vim.keymap.set('n', '<A-h>', '<C-w>h', {
    desc = "Move to left [windows]",
})
vim.keymap.set('n', '<A-j>', '<C-w>j', {
    desc = "Move to down [windows]",
})
vim.keymap.set('n', '<A-k>', '<C-w>k', {
    desc = "Move to up [windows]",
})
vim.keymap.set('n', '<A-l>', '<C-w>l', {
    desc = "Move to right [windows]",
})
vim.keymap.set('n', '<leader>.', '<CMD>term<CR>', {
    desc = "Open terminal",
})

-- Option keymaps:
vim.keymap.set({ 'n', 'v' }, '<leader>ol', '<CMD>set nu!<CR>', {
    desc = "Line numbers [toggle]",
})
vim.keymap.set({ 'n', 'v' }, '<leader>or', '<CMD>set rnu!<CR>', {
    desc = "Relative line numbers [toggle]",
})
vim.keymap.set({ 'n', 'v' }, '<leader>ob',
    '<CMD>exec &bg=="light"? "set bg=dark" : "set bg=light"<CR>',
    { desc = "Background light/dark [toggle]", }
)

-- Fold method keymaps:

vim.keymap.set({ 'n', 'v' }, '<leader>ofm', '<CMD>set fdm=manual<CR>', {
    desc = "Manual",
})
vim.keymap.set({ 'n', 'v' }, '<leader>ofi', '<CMD>set fdm=indent<CR>', {
    desc = "Indent",
})
vim.keymap.set({ 'n', 'v' }, '<leader>ofd', '<CMD>set fdm=dff<CR>', {
    desc = "Diff",
})
vim.keymap.set({ 'n', 'v' }, '<leader>oft',
    function()
        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end,
    { desc = "treesitter.foldexpr" }
)

-- Coloscheme keymaps:

vim.keymap.set({ 'n', 'v' }, '<leader>cp', '<CMD>colorscheme peachpuff<CR>', {
    desc = "Peachpuff",
})
vim.keymap.set({ 'n', 'v' }, '<leader>ci', '<CMD>colorscheme industry<CR>', {
    desc = "Industry [black]",
})
vim.keymap.set({ 'n', 'v' }, '<leader>cd', '<CMD>colorscheme default<CR>', {
    desc = "Default",
})
vim.keymap.set({ 'n', 'v' }, '<leader>cb', '<CMD>colorscheme blue<CR>', {
    desc = "Blue",
})
vim.keymap.set({ 'n', 'v' }, '<leader>cz', '<CMD>colorscheme zellner<CR>', {
    desc = "Zellner [white]",
})
vim.keymap.set({ 'n', 'v' }, '<leader>ce', '<CMD>colorscheme everblush<CR>', {
    desc = "Everblush [plugin]",
})
vim.keymap.set({ 'n', 'v' }, '<leader>cg',
    '<CMD>colorscheme gruvbox<CR><CMD>set background=dark<CR>',
    { desc = "Gruvbox dark [plugin]", }
)
vim.keymap.set({ 'n', 'v' }, '<leader>cG',
    '<CMD>colorscheme gruvbox<CR><CMD>set background=light<CR>',
    { desc = "Gruvbox light [plugin]", }
)

-- Github Dark themes:
vim.keymap.set({'n', 'v'}, '<leader>chd<leader>',
    '<CMD>colorscheme github_dark<CR>',
    { desc = "Github Dark [plugin]", }
)
vim.keymap.set({'n', 'v'}, '<leader>chdD',
    '<CMD>colorscheme github_dark_dimmed<CR>',
    { desc = "Github Dark Dimmed [plugin]", }
)
vim.keymap.set({'n', 'v'}, '<leader>chdd',
    '<CMD>colorscheme github_dark_default<CR>',
    { desc = "Github Dark Default [plugin]", }
)
vim.keymap.set({'n', 'v'}, '<leader>chdh',
    '<CMD>colorscheme github_dark_high_contrast<CR>',
    { desc = "Github Dark Hight Contrast [plugin]", }
)
vim.keymap.set({'n', 'v'}, '<leader>chdc',
    '<CMD>colorscheme github_dark_colorblind<CR>',
    { desc = "Github Dark Colorblind [plugin]", }
)
vim.keymap.set({'n', 'v'}, '<leader>chdt',
    '<CMD>colorscheme github_dark_tritanopia<CR>',
    { desc = "Github Dark Tritanopia [plugin]", }
)

-- Github Light themes:
vim.keymap.set({'n', 'v'}, '<leader>chl<leader>',
    '<CMD>colorscheme github_light<CR>',
    { desc = "Github Light [plugin]", }
)
vim.keymap.set({'n', 'v'}, '<leader>chld',
    '<CMD>colorscheme github_light_default<CR>',
    { desc = "Github Light Default [plugin]", }
)
vim.keymap.set({'n', 'v'}, '<leader>chlh',
    '<CMD>colorscheme github_light_high_contrast<CR>',
    { desc = "Github Light High Contrast [plugin]", }
)
vim.keymap.set({'n', 'v'}, '<leader>chlc',
    '<CMD>colorscheme github_light_colorblind<CR>',
    { desc = "Github Light Light Colorblind [plugin]", }
)
vim.keymap.set({'n', 'v'}, '<leader>chlt',
    '<CMD>colorscheme github_light_tritanopia<CR>',
    { desc = "Github Light Tritanopia [plugin]", }
)

-- Shortcut for colorscheme that is used a lot atm.
vim.keymap.set({'n', 'v'}, '<leader>cc',
    '<CMD>colorscheme github_dark_dimmed<CR>',
    { desc = "Github Dark Dimmed [plugin]", }
)

-- lazy.nvim

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        -- Use plugin files from lua/plugins
        { import = "plugins" },
    },
    -- automatically check for plugin updates
    checker = { enabled = false },

    -- lazy can generate helptags from the headings in markdown readme files,
    -- so :help works even for plugins that don't have vim docs.
    -- when the readme opens with :help it will be correctly displayed as markdown
    readme = {
        enabled = true,
        root = vim.fn.stdpath("state") .. "/lazy/readme",
        files = { "README.md", "lua/**/README.md" },
        -- only generate markdown helptags for plugins that dont have docs
        skip_if_doc_exists = true,
    },
    dev = {
        ---@type string | fun(plugin: LazyPlugin): string directory where you store your local plugin projects
        path = "~/data/scratch/nvim-plugins",
        ---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
        patterns = {}, -- For example {"folke"}
        fallback = false, -- Fallback to git when local plugin doesn't exist
    },
})
