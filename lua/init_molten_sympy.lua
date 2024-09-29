vim.api.nvim_buf_set_lines(0, 0, -1, false, {
    "from sympy import *",
    "x, y, z, t = symbols('x y z t')",
    "k, m, n = symbols('k m n', integer=True)",
    "f, g, h = symbols('f g h', cls=Function)",
    "init_printing(use_latex=False)",
    "",
})

vim.fn.MoltenEvaluateRange(1, 5)
