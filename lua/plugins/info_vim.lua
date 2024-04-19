return {
    url = 'https://gitlab.com/HiPhish/info.vim.git',
    lazy = false,
    keys = {
        {
            "<C-k>",
            "<Plug>(InfoUp)",
            mode = "n",
            ft = "info",
            desc = "Go to Up node.",
        },
        {
            "<C-h>",
            "<Plug>(InfoPrev)",
            mode = "n",
            ft = "info",
            desc = "Go to Prev node.",
        },
        {
            "<C-l>",
            "<Plug>(InfoNext)",
            mode = "n",
            ft = "info",
            desc = "Go to Prev node.",
        },
        {
            "m",
            "<Plug>(InfoMenu)",
            mode = "n",
            ft = "info",
            desc = "InfoMenu",
        },
        {
            "f",
            "<Plug>(InfoFollow)",
            mode = "n",
            ft = "info",
            desc = "InfoFollow",
        },
        {
            "o",
            "<Plug>(InfoGoto)",
            mode = "n",
            ft = "info",
            desc = "InfoGoto",
        },
    },
}
