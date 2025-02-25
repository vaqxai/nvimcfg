return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
    opts = {
      inlay_hints = { enabled = true }
    }
  },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },

  {
    "simrat39/symbols-outline.nvim",
    keys = {
      { "<leader>ss", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" }
    },
    config = function()
      require("symbols-outline").setup()
    end
  },
  {
    "rmagatti/auto-session",
    lazy = false,
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = {'~/', '~/Downloads', '/'},
    }
  },
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    opts = {
      enabled = true,
      message_template = " <summary> • <date> • <author> • <<sha>>",
      date_format = "%d.%m.%Y %H:%M:%S",
      virtual_text_column = 1,
    }
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = true
  }
}
