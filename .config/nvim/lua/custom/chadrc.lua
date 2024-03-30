---@type ChadrcConfig 
 local M = {}
 M.ui = {
  theme = 'catppuccin',
  extended_integrations = {'dap'}, -- these aren't compiled by default, ex: "alpha", "notify"
}
 M.plugins = "custom.plugins"
 M.mappings = require "custom.mappings"
 return M
