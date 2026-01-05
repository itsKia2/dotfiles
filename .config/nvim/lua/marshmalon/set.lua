vim.cmd.colorscheme("tokyonight")

vim.opt.clipboard = "unnamedplus" -- use system keyboard for yank

vim.opt.nu = true -- set line numbers -- set line numbers
vim.opt.relativenumber = false -- use relative line numbers

-- set tab size to 2 spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.incsearch = true -- incremental search

vim.opt.termguicolors = true

vim.diagnostic.config({
  virtual_text = {
    severity = vim.diagnostic.severity.ERROR,
    spacing = 4,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false, scope = "line" })
  end,
})
