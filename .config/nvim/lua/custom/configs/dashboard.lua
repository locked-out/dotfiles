local M = {}

vim.api.nvim_set_hl(0, "DashboardHeader", { link = "Comment" })
vim.api.nvim_set_hl(0, "DashboardShortCut", {link = "Structure"})
vim.api.nvim_set_hl(0, "DashboardProjectTitle", {link = "Function"})
vim.api.nvim_set_hl(0, "DashboardProjectTitleIco", {link = "Function"})
vim.api.nvim_set_hl(0, "DashboardMruTitle", {link = "Function"})
vim.api.nvim_set_hl(0, "DashboardMruIcon", {link = "Function"})
--
M.config = {
  header = {
"          __.--,             ",
"     ,--'~-.,;=/             ",
"    {  /,”” ‘ |              ",
"     `|\\_ (@\\(@\\_            ",
"      \\(  _____(./           ",
"      | `-~--~-‘\\            ",
"      | /   /  , \\           ",
"      | |   (\\  \\  \\         ",
"     _\\_|.-‘` `’| ,-= )      ",
"    (_  ,\\ ____  \\  ,/       ",
"      \\  |--===--(,,/        ",
"       ```========-/         ",
"         \\_______ /          ",
"  SOMEBODY TOUCHA MY SPAGHET!",
"                             ",
},
	-- "                                                                       ",
	-- "  ██████   █████                   █████   █████  ███                  ",
	-- " ░░██████ ░░███                   ░░███   ░░███  ░░░                   ",
	-- "  ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████   ",
	-- "  ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███  ",
	-- "  ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███  ",
	-- "  ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███  ",
	-- "  █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████ ",
	-- " ░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░  ",
	-- "                                                                       ",
  shortcut = {
    { desc = '󰊳 Update', group = 'String', action = 'Lazy update', key = 'u' },
    {
      desc = ' Files',
      group = 'Label',
      action = 'Telescope find_files',
      key = 'f',
    },
    {
      desc = ' dotfiles',
      group = 'Number',
      action = 'cd ~/.config/ | enew | NvimTreeToggle',
      key = 'd',
    },
  },
  project = {
    action = function (path)
      vim.cmd('cd ' .. path)
      vim.cmd('enew')
      vim.cmd('NvimTreeToggle')
    end
  },
  footer = {},
}
return M
