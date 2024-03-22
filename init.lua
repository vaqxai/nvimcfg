local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

vim.cmd("set shellslash")

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
  "nvim-treesitter/nvim-treesitter",
  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  "folke/neodev.nvim",
  "junegunn/vim-easy-align",
  "preservim/nerdtree",
  "rebelot/kanagawa.nvim",
  "rust-lang/rust.vim",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  "mrcjkb/rustaceanvim",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/cmp-nvim-lsp-signature-help",
  "hrsh7th/cmp-vsnip",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-buffer",
  "hrsh7th/vim-vsnip",
  {"nvim-telescope/telescope.nvim", tag = '0.1.6',
	dependencies = {
		'nvim-lua/plenary.nvim'
	}
  },
  "nvim-lua/plenary.nvim",
  "dawsers/telescope-locate.nvim",
  "tpope/vim-vinegar",
  "junegunn/fzf",
  "junegunn/fzf.vim",
  "rmagatti/auto-session",
})

vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)

vim.cmd("colorscheme kanagawa")
vim.cmd("set relativenumber")
vim.cmd("set hidden")
vim.cmd("set ts=4")

require("mason").setup({
	ui = {
		icons = {
			package_installed = "X",
			package_pending = "...",
			package_uninstalled = "O",
		},
	}
})
require("mason-lspconfig").setup()

local sign = function(opts)
	vim.fn.sign_define(opts.name, {
		texthl = opts.name,
		text = opts.text,
		numhl = ''
	})
end

sign({name = 'DiagnosticSignError', text = '!'})
sign({name = 'DiagnosticSignWarn', text = '?'})
sign({name = 'DiagnosticSignHint', text = '~'})
sign({name = 'DiagnosticSignInfo', text = '.'})

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

vim.opt.completeopt = {'menuone', 'noselect', 'noinsert' }
vim.opt.shortmess = vim.opt.shortmess + { c = true }
vim.api.nvim_set_option('updatetime', 300)

vim.cmd([[
	set signcolumn=yes
	autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

local cmp = require('cmp')

cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  -- Installed sources:
  sources = {
    { name = 'path' },                              -- file paths
    { name = 'nvim_lsp', keyword_length = 3 },      -- from language server
    { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
    { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
    { name = 'buffer', keyword_length = 2 },        -- source current buffer
    { name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip 
    { name = 'calc'},                               -- source for math calculation
  },
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  formatting = {
      fields = {'menu', 'abbr', 'kind'},
      format = function(entry, item)
          local menu_icon ={
              nvim_lsp = 'λ',
              vsnip = '⋗',
              buffer = 'Ω',
              path = '🖫',
          }
          item.menu = menu_icon[entry.source.name]
          return item
      end,
  },
})

require('telescope').setup()

local ts_builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', ts_builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', ts_builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', ts_builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', ts_builtin.help_tags, {})


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
]])

vim.cmd("set grepprg=rg\\ --vimgrep\\ --smart-case\\ --follow")

require("auto-session").setup({
		auto_session_root_dir = vim.fn.stdpath('data') .. "/sessions/",
})