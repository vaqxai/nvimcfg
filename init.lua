-- disable netrw for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Only for cygwin/fish
-- vim.cmd("set shellslash")

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Example using a list of specs with the default options
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = "\\" -- Same for `maplocalleader`

require("lazy").setup({
    {
        "hedyhli/outline.nvim",
        lazy = true,
        cmd = { "Outline", "OutlineOpen" },
        keys = {
            { "<Leader>o", "<cmd>Outline<CR>", desc = "Toggle outline"},
        },
        opts = {
            -- Custom config
        }
    },
    "github/copilot.vim",
    {
        "voldikss/vim-floaterm",
        keys = {
            { "<Leader>tt", "<cmd>FloatermToggle<CR>", desc = "Toggle terminal"},
            { "<Leader>to", "<cmd>FloatermNew --position=bottom powershell<CR>", desc = "Open terminal"},
            { "<Leader>tp", "<cmd>FloatermPrev<CR>", desc = "Previous terminal"},
            { "<Leader>tn", "<cmd>FloatermNext<CR>", desc = "Next terminal"},
            { "<Leader>tk", "<cmd>FloatermKill<CR>", desc = "Kill terminal"},
            { "<ESC>", "<C-\\><C-n>", desc = "Exit Terminal", mode = "t"},
        },
    },
    "kristijanhusak/vim-dadbod-ui",
	"mfussenegger/nvim-dap",
    "ludovicchabant/vim-gutentags",
	"nvim-treesitter/nvim-treesitter",
	"lewis6991/hover.nvim",
	"Wansmer/symbol-usage.nvim",
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
      end,
      opts = {}
    },
	{ "folke/neoconf.nvim", cmd = "Neoconf" },
	"folke/neodev.nvim",
	"junegunn/vim-easy-align",
    {
        "nvim-tree/nvim-tree.lua",
        init = function()
            vim.opt.termguicolors = true
            require("nvim-tree").setup({
                sync_root_with_cwd = true,
                prefer_startup_root = true,
            })
            vim.cmd("nnoremap <silent> <Leader>e :NvimTreeToggle<CR>")
        end,
    },
    {
	   "Shatur/neovim-ayu",
       lazy = false,
       priority = 1000,
       config = function()
           vim.cmd([[colorscheme ayu]])
       end,
    },
	"rebelot/kanagawa.nvim",
	"rust-lang/rust.vim",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	{ "mrcjkb/rustaceanvim", lazy = false },
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-nvim-lua",
	"hrsh7th/cmp-nvim-lsp-signature-help",
	"hrsh7th/cmp-vsnip",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-buffer",
	"hrsh7th/vim-vsnip",
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	"nvim-lua/plenary.nvim",
	"dawsers/telescope-locate.nvim",
	"tpope/vim-vinegar",
	"tpope/vim-unimpaired",
	"junegunn/fzf",
	"junegunn/fzf.vim",
	"rmagatti/auto-session",
	"nanozuki/tabby.nvim",
	"kylechui/nvim-surround",
	"tpope/vim-commentary",
	"stevearc/conform.nvim",
	"tpope/vim-dadbod",
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		-- use opts = {} for passing setup options
		-- this is equalent to setup({}) function
	},
	"rcarriga/nvim-notify", -- optional
	"stevearc/dressing.nvim", -- optional, UI for :JupyniumKernelSelect
	"diegoulloao/neofusion.nvim",
	{
		"echasnovski/mini.hipatterns",
		event = "VeryLazy",
		dependencies = { "GCBallesteros/NotebookNavigator.nvim" },
		opts = function()
			local nn = require("notebook-navigator")

			local opts = { highlighters = { cells = nn.minihipatterns_spec } }
			return opts
		end,
	},
	-- "meatballs/notebook.nvim",
	{
		"GCBallesteros/NotebookNavigator.nvim",
		keys = {
			{
				"]h",
				function()
					require("notebook-navigator").move_cell("d")
				end,
			},
			{
				"[h",
				function()
					require("notebook-navigator").move_cell("u")
				end,
			},
			{ "<leader>X", "<cmd>lua require('notebook-navigator').run_cell()<cr>" },
			{ "<leader>x", "<cmd>lua require('notebook-navigator').run_and_move()<cr>" },
		},
		dependencies = {
			"echasnovski/mini.comment",
			"hkupty/iron.nvim", -- repl provider
			-- "akinsho/toggleterm.nvim", -- alternative repl provider
			-- "benlubas/molten-nvim", -- alternative repl provider
			"anuvyklack/hydra.nvim",
		},
		event = "VeryLazy",
		config = function()
			local nn = require("notebook-navigator")
			nn.setup({ activate_hydra_keys = "<leader>h" })
		end,
	},
	{
		"GCBallesteros/jupytext.nvim",
		config = true,
		-- Depending on your nvim distro or config you may need to make the loading not lazy
		lazy = false,
	},
	{
		"nanozuki/tabby.nvim",
		event = "VimEnter",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			-- configs...
		end,
	},
})

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)

vim.opt.nu = true
vim.opt.relativenumber = true
vim.o.statuscolumn = "%s %l %r "
vim.cmd("set hidden")
vim.cmd("set ts=4")
vim.cmd("set expandtab")
vim.cmd("set shiftwidth=4")
vim.cmd("set so=20")
vim.cmd("nnoremap <C-J> <C-W> j")
vim.cmd("nnoremap <C-K> <C-W> k")
vim.cmd("nnoremap <C-L> <C-W> l")
vim.cmd("nnoremap <C-H> <C-W> h")

require("mason").setup({
	ui = {
		icons = {
			package_installed = "X",
			package_pending = "...",
			package_uninstalled = "O",
		},
	},
})
require("neoconf").setup()
require("mason-lspconfig").setup()

local sign = function(opts)
	vim.fn.sign_define(opts.name, {
		texthl = opts.name,
		text = opts.text,
		numhl = "",
	})
end

sign({ name = "DiagnosticSignError", text = "!" })
sign({ name = "DiagnosticSignWarn", text = "?" })
sign({ name = "DiagnosticSignHint", text = "~" })
sign({ name = "DiagnosticSignInfo", text = "." })

vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	update_in_insert = true,
	underline = true,
	severity_sort = false,
	float = {
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

vim.opt.completeopt = { "menuone", "noselect", "noinsert" }
vim.opt.shortmess = vim.opt.shortmess + { c = true }
vim.api.nvim_set_option("updatetime", 300)

vim.cmd([[
	set signcolumn=yes
	autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

local cmp = require("cmp")

cmp.setup({
	-- Enable LSP snippets
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		-- Add tab support
		["<S-Tab>"] = cmp.mapping.select_prev_item(),
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<C-S-f>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
	},
	-- Installed sources:
	sources = {
		{ name = "path" }, -- file paths
		{ name = "nvim_lsp", keyword_length = 3 }, -- from language server
		{ name = "nvim_lsp_signature_help" }, -- display function signatures with current parameter emphasized
		{ name = "nvim_lua", keyword_length = 2 }, -- complete neovim's Lua runtime API such vim.lsp.*
		{ name = "buffer", keyword_length = 2 }, -- source current buffer
		{ name = "vsnip", keyword_length = 2 }, -- nvim-cmp source for vim-vsnip
		{ name = "calc" }, -- source for math calculation
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	formatting = {
		fields = { "menu", "abbr", "kind" },
		format = function(entry, item)
			local menu_icon = {
				nvim_lsp = "λ",
				vsnip = "⋗",
				buffer = "Ω",
				path = "🖫",
			}
			item.menu = menu_icon[entry.source.name]
			return item
		end,
	},
})

require("telescope").setup()

local ts_builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", ts_builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", ts_builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", ts_builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", ts_builtin.help_tags, {})

vim.cmd([[
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <Leader>f :Rg<CR>
nnoremap <silent> <Leader>/ :BLines<CR>
nnoremap <silent> <Leader>' :Marks<CR>
nnoremap <silent> <Leader>g :Commits<CR>
nnoremap <silent> <Leader>H :Helptags<CR>
nnoremap <silent> <Leader>hh :History<CR>
nnoremap <silent> <Leader>h: :History:<CR>
nnoremap <silent> <Leader>h/ :History/<CR>

" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

nnoremap <leader>n :noh<CR>
]])

vim.cmd("set grepprg=rg\\ --vimgrep\\ --smart-case\\ --follow")

require("auto-session").setup({
	auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
})

-- require('notebook').setup()
-- require('mini.hipatterns').setup()
require("jupytext").setup()
vim.o.showtabline = 2
vim.o.sessionoptions = "curdir,folds,globals,help,tabpages,terminal,winsize"

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = { "isort", "black" },
		-- Use a sub-list to run only the first available formatter
		javascript = { { "prettierd", "prettier" } },

		rust = { "rustfmt" },
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

local lspconfig = require("lspconfig")

require("mason-lspconfig").setup_handlers({
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function(server_name) -- default handler (optional)
		require("lspconfig")[server_name].setup({})
	end,
	-- Next, you can provide a dedicated handler for specific servers.
	-- For example, a handler override for the `rust_analyzer`:
	["rust_analyzer"] = function() end,
    ["lua_ls"] = function() 
        require("lspconfig").lua_ls.setup({
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' }
                    }
                }
            }
        })
    end,
})

require("hover").setup({
	init = function()
		require("hover.providers.lsp")
		require("hover.providers.gh")
		require("hover.providers.dap")
	end,
	preview_opts = {
		border = "single",
	},
	preview_windows = false,
	title = true,
	mouse_providers = {
		"LSP",
	},
	mouse_delay = 1000,
})

-- Setup keymaps
vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })
vim.keymap.set("n", "<C-p>", function()
	require("hover").hover_switch("previous")
end, { desc = "hover.nvim (previous source)" })
vim.keymap.set("n", "<C-n>", function()
	require("hover").hover_switch("next")
end, { desc = "hover.nvim (next source)" })

-- Mouse support
vim.keymap.set("n", "<MouseMove>", require("hover").hover_mouse, { desc = "hover.nvim (mouse)" })
vim.o.mousemoveevent = true

require("symbol-usage").setup({})
