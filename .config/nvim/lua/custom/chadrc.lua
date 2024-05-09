---@type ChadrcConfig 
local M = {}
M.ui = {
  hl_override = {
    TelescopeBorder = {fg = "grey"},
    TelescopePromptPrefix = {bg = "darker_black"},
    TelescopePromptNormal = {bg = "darker_black"},
    TelescopePromptBorder = {fg = "grey", bg = "darker_black"},
    TelescopeResultsTitle = {bg = "blue"}
  },
  lsp_semantic_tokens = true,
  theme = 'catppuccin',
  extended_integrations = {'dap'}, -- these aren't compiled by default, ex: "alpha", "notify"
}
M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"
return M
