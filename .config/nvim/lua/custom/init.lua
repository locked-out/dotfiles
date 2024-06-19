vim.opt.colorcolumn = "80"
vim.opt.scrolloff = 5

vim.keymap.set("i", "jj", "<Esc>", { noremap = true })

vim.opt.shell = "/bin/fish"


vim.api.nvim_create_user_command("Tabsize",
  function (opts)
    local width = tonumber(opts.fargs[1])
    vim.opt_local.shiftwidth = width
    vim.opt_local.softtabstop = width
    vim.opt_local.tabstop = width
  end,
  { nargs = 1})
