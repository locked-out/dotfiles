vim.opt.colorcolumn = "80"

vim.fn.sign_define('DapBreakpoint', {text='', texthl='ErrorMsg', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointCondition', {text='', texthl='ErrorMsg'})
vim.fn.sign_define('DapLogPoint', {text='', texthl='ErrorMsg'})
vim.fn.sign_define('DapStopped', {text='', texthl='String'})
vim.opt.shell = "/bin/fish"
