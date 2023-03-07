local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})


return packer.startup(function(use)
  -- Tabular: godlygeek/tabular
  use {'godlygeek/tabular'}

  -- Vim Commentary: tpope/vim-commentary
  use {'tpope/vim-commentary'}

  -- Vim Eunuch: tpope/vim-eunuch
  use {'tpope/vim-eunuch'}

  -- Vim Surround: tpope/vim-surround
  use {'tpope/vim-surround'}

  -- Neovim TS Rainbow: p00f/nvim-ts-rainbow
  use {'p00f/nvim-ts-rainbow'}

  -- Completion and Snippets
  use {
      'hrsh7th/nvim-cmp',
      requires = {
          {'hrsh7th/cmp-buffer'},
          {'hrsh7th/cmp-nvim-lsp'},
          {'hrsh7th/cmp-path'},
          {'hrsh7th/cmp-nvim-lua'},
          {'onsails/lspkind-nvim'},
          {'tzachar/cmp-tabnine'},
          {'hrsh7th/vim-vsnip'},
          {'hrsh7th/cmp-vsnip'},
          {'hrsh7th/cmp-calc'},
          {'hrsh7th/cmp-emoji'},
          {'hrsh7th/cmp-cmdline'},
          {'f3fora/cmp-spell'},
          {'ray-x/cmp-treesitter'},
          {'saadparwaiz1/cmp_luasnip'},
      }
  }

  -- Colorschemes
  use {'morhetz/gruvbox'}
  use {'overcache/NeoSolarized'}
  use {'shaunsingh/nord.nvim'}
  use {'rakr/vim-one'}
  use {'NLKNguyen/papercolor-theme'}
  use {'folke/tokyonight.nvim'}

  -- Utility
  use {'direnv/direnv.vim'}
  use {'junegunn/goyo.vim'}
  use {'tpope/vim-fugitive'}
  use {'lewis6991/impatient.nvim'}
  use {'nvim-lua/plenary.nvim'}
  use {'moll/vim-bbye'}
  use {'l3mon4d3/luasnip'}
  use {'karb94/neoscroll.nvim'}
  use {'folke/which-key.nvim'}
  use {'nvim-tree/nvim-tree.lua'}
  use {'gpanders/editorconfig.nvim'}

  -- UI
  use {'akinsho/bufferline.nvim'}
  use {'NTBBloodbath/galaxyline.nvim'}
  use {'nvim-tree/nvim-web-devicons'}
  use {'lewis6991/gitsigns.nvim'}
  use {'lukas-reineke/indent-blankline.nvim'}

  -- LSP
  use {'kkharji/lspsaga.nvim'}
  use {'jose-elias-alvarez/null-ls.nvim'}
  use {'neovim/nvim-lspconfig'}
  use {'nvim-treesitter/nvim-treesitter'}

  -- Terminal
  use {'akinsho/toggleterm.nvim'}

  -- Language Specific
  use {'sheerun/vim-polyglot'}
  use {'ethanholz/nvim-lastplace'}
  use {'ahmedkhalf/project.nvim'}
  use {'williamboman/mason.nvim'}
  use {'https://git.sr.ht/~whynothugo/lsp_lines.nvim'}

  -- Telescope
  use {'nvim-telescope/telescope.nvim'}
  use {'nvim-telescope/telescope-file-browser.nvim'}
  use {'nvim-telescope/telescope-fzf-native.nvim'}
  use {'nvim-telescope/telescope-symbols.nvim'}
  use {'jvgrootveld/telescope-zoxide'}
  use {'nvim-telescope/telescope-ui-select.nvim'}

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
