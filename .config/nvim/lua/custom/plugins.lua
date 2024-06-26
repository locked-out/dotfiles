
local plugins = {
  {
    "nvim-treesitter/nvim-treesitter" ,
    opts = {
      ensure_installed = {
        -- defaults
        "vim",
        "lua",

        "c",
        "cpp",
        "html",
        "css",
        "json",
        "bash",
        "python",
        "javascript"
      }
    }
  },
  {
    "neovim/nvim-lspconfig",
    config = function ()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "karb94/neoscroll.nvim",
    config = function ()
      require('neoscroll').setup()
    end,
    keys = {"<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb"}
  },
  {
    'echasnovski/mini.move',
    version = false,
    config = function ()
      require("mini.move").setup()
    end,
    keys = {'<M-h>', '<M-l>', '<M-j>', '<M-k>'}
  },
  {
    'mfussenegger/nvim-dap',
    config = function ()
      dofile(vim.g.base46_cache .. "dap")
      require "custom.configs.dapconfig"
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies={
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio',
    },
    config = function()
      require("dapui").setup()
    end
  },
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      local cfg = require "custom.configs.dashboard"
      require('dashboard').setup (cfg)
    end,
    dependencies = { {'nvim-tree/nvim-web-devicons'}, {"nvim-treesitter/nvim-treesitter"}}
  },
  {
    'theHamsta/nvim-dap-virtual-text',
    dependencies={
      'mfussenegger/nvim-dap',
      'nvim-treesitter/nvim-treesitter'
    },
    config = function()
      require("nvim-dap-virtual-text").setup({['only_first_definition']=false})
    end,
  },
  {
    'akinsho/git-conflict.nvim',
    version = "*",
    config = function (_, opts)
      dofile(vim.g.base46_cache .. "git")
      require('git-conflict').setup(opts);
    end,
    opts = {
      disable_diagnostics = true,
      default_mappings = false
    },
    event = {
      "BufRead"
    }
  },
  {
    "aznhe21/actions-preview.nvim",
    opts = {
      telescope = {
        layout_strategy = 'vertical',
        layout_config = {
          vertical = {
            preview_cutoff = 0,
            preview_height = 0.5
          },
        },
      }
    }
  },
  {
    'echasnovski/mini.surround', version = '*', event='VeryLazy',
    init = function ()
      -- Disabling [s] for use in mini.surround
      vim.keymap.set({ 'n', 'x' }, 's', '<Nop>')
    end,
    config = function(_, opts)
      require('mini.surround').setup(opts)
    end
  },
}

return plugins
