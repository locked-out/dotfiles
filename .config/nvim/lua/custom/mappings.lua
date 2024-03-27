local M = {}

M.disabled = {
  n = {
    -- LSP
    ["<leader>D"] = "",
    ["<leader>ra"] = "",
    ["<leader>ca"] = "",
    ["<leader>f"] = "",
    ["<leader>q"] = "",
    ["<leader>wa"] = "",
    ["<leader>wr"] = "",
    ["<leader>wl"] = "",
    ["<leader>fm"] = "",

    -- Line numbers
    ["<leader>n"] = "",
    ["<leader>rn"] = "",

       -- git
    ["<leader>cm"] = "",
    ["<leader>gt"] = "",
    ["<leader>rh"] = "",
    ["<leader>ph"] = "",
    ["<leader>td"] = "",

    -- pick a hidden term
    ["<leader>pt"] = "",

    -- theme switcher
    ["<leader>th"] = "",
    ["<leader>ma"] = "",


    -- jump to current context
    ["<leader>cc"] = "",
    ["<leader>ch"] = "",
  }
}

M.general = {
  n = {
    ["<leader>nn"] = { "<cmd> set nu! <CR>", "Toggle line number" },
    ["<leader>nr"] = { "<cmd> set rnu! <CR>", "Toggle relative number" },
  }
}

M.nvchad = {
  n = {
    ["<leader>Nt"] = { "<cmd> Telescope themes <CR>", "Nvchad themes" },
    ["<leader>Nc"] = { "<cmd> NvCheatsheet <CR>", "Mapping cheatsheet" },
  }
}

M.blankline = {
  n = {
    ["<leader>c"] = {
      function()
        local ok, start = require("indent_blankline.utils").get_current_context(
          vim.g.indent_blankline_context_patterns,
          vim.g.indent_blankline_use_treesitter_scope
        )

        if ok then
          vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
          vim.cmd [[normal! _]]
        end
      end,

      "Jump to current context",
    },
  }
}

M.gitsigns = {
  n = {
    ["<leader>gr"] = {
      function()
        require("gitsigns").reset_hunk()
      end,
      "Reset hunk",
    },

    ["<leader>gp"] = {
      function()
        require("gitsigns").preview_hunk()
      end,
      "Preview hunk",
    },

    ["<leader>gt"] = {
      function()
        require("gitsigns").toggle_deleted()
      end,
      "Toggle deleted",
    },
    ["<leader>gd"] = {
      function()
        require("gitsigns").diffthis()
      end,
      "Diff this",
    }
  }
}

M.telescope = {
  n = {
    -- git
    ["<leader>gc"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
    ["<leader>gs"] = { "<cmd> Telescope git_status <CR>", "Git status" },

    -- pick a hidden term
    ["<leader>ft"] = { "<cmd> Telescope terms <CR>", "Pick hidden term" },

    -- theme switcher
    -- ["<leader>th"] = { "<cmd> Telescope themes <CR>", "Nvchad themes" },
    ["<leader>fm"] = { "<cmd> Telescope marks <CR>", "telescope bookmarks" },
  }
}

M.lspconfig = {
  n = {
    ["<leader>lD"] = {
      function()
        vim.lsp.buf.declaration()
      end,
      "LSP declaration",
    },

    ["<leader>ld"] = {
      function()
        vim.lsp.buf.definition()
      end,
      "LSP definition",
    },

    ["<leader>lK"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "LSP hover",
    },

    ["<leader>li"] = {
      function()
        vim.lsp.buf.implementation()
      end,
      "LSP implementation",
    },

    ["<leader>ls"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "LSP signature help",
    },

    ["<leader>lT"] = {
      function()
        vim.lsp.buf.type_definition()
      end,
      "LSP definition type",
    },

    ["<leader>lr"] = {
      function()
        require("nvchad.renamer").open()
      end,
      "LSP rename",
    },

    ["<leader>la"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },

    ["<leader>lR"] = {
      function()
        vim.lsp.buf.references()
      end,
      "LSP references",
    },

    ["<leader>lf"] = {
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      "Floating diagnostic",
    },

    ["<leader>lq"] = {
      function()
        vim.diagnostic.setloclist()
      end,
      "Diagnostic setloclist",
    },

    ["<leader>lwa"] = {
      function()
        vim.lsp.buf.add_workspace_folder()
      end,
      "Add workspace folder",
    },

    ["<leader>lwr"] = {
      function()
        vim.lsp.buf.remove_workspace_folder()
      end,
      "Remove workspace folder",
    },

    ["<leader>lwl"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      "List workspace folders",
    },
    ["<leader>lF"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "LSP formatting",
    },
  },
}


return M
