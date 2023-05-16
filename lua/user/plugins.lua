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
  use 'godlygeek/tabular'

  -- Vim Commentary: tpope/vim-commentary
  use 'tpope/vim-commentary'

  -- Vim Eunuch: tpope/vim-eunuch
  use 'tpope/vim-eunuch'

  -- Vim Surround: tpope/vim-surround
  use 'tpope/vim-surround'

  -- Neovim TS Rainbow: p00f/nvim-ts-rainbow
  use 'p00f/nvim-ts-rainbow'

  -- Completion and Snippets
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'onsails/lspkind-nvim',
      { 'tzachar/cmp-tabnine', run = './install.sh' },
      'hrsh7th/vim-vsnip',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/cmp-calc',
      'hrsh7th/cmp-emoji',
      'hrsh7th/cmp-cmdline',
      'f3fora/cmp-spell',
      'ray-x/cmp-treesitter',
      'saadparwaiz1/cmp_luasnip',
    }
  }

  -- Colorschemes
  use 'morhetz/gruvbox'
  use 'overcache/NeoSolarized'
  use 'shaunsingh/nord.nvim'
  use 'rakr/vim-one'
  use 'NLKNguyen/papercolor-theme'
  use 'folke/tokyonight.nvim'

  -- Utility
  use 'direnv/direnv.vim'          -- Plugin for automatically loading/unloading environment variables using direnv
  use 'junegunn/goyo.vim'          -- Distraction-free writing mode
  use 'tpope/vim-fugitive'         -- Git wrapper for Vim
  use 'lewis6991/impatient.nvim'   -- Lazy loading plugin for speeding up startup time
  use 'nvim-lua/plenary.nvim'      -- Lua utility functions for Neovim plugins and scripts
  use 'moll/vim-bbye'              -- Delete buffer without closing the window
  use 'l3mon4d3/luasnip'           -- Snippet manager
  use 'karb94/neoscroll.nvim'      -- Smooth scrolling
  use 'folke/which-key.nvim'       -- Plugin for displaying keybindings
  use 'nvim-tree/nvim-tree.lua'    -- File explorer
  use 'gpanders/editorconfig.nvim' -- Plugin for loading EditorConfig settings

  -- UI
  use 'akinsho/bufferline.nvim'             -- Plugin for displaying buffers in the command bar
  use 'NTBBloodbath/galaxyline.nvim'        -- Statusline plugin
  use 'nvim-tree/nvim-web-devicons'         -- Plugin for file type icons in Neovim file explorer
  use 'lewis6991/gitsigns.nvim'             -- Git status in the sign column
  use 'lukas-reineke/indent-blankline.nvim' -- Plugin for displaying indentation levels

  -- LSP: provides LSP integration and features
  use 'kkharji/lspsaga.nvim'            -- adds additional LSP features and UI improvements
  use 'jose-elias-alvarez/null-ls.nvim' -- provides a lightweight LSP client that extends the language server protocol
  use 'neovim/nvim-lspconfig'           -- configures neovim's built-in LSP client
  use 'nvim-treesitter/nvim-treesitter' -- enhances syntax highlighting and adds more advanced features to supported languages
  use 'github/Copilot.vim'              -- provides support for the OpenAI code completion tool, Copilot

  -- Terminal: provides terminal-related features
  use 'akinsho/toggleterm.nvim' -- provides a toggleable terminal that can be opened and closed with a single keystroke
  use 'pantharshit00/vim-prisma' -- syntax highlighting for Prisma

  -- Language Specific: provides language-specific features
  use 'sheerun/vim-polyglot'                         -- adds support for many languages, including syntax highlighting, indentation, and other language-specific features
  use 'ethanholz/nvim-lastplace'                     -- automatically jumps to the last edited position in a file
  use 'ahmedkhalf/project.nvim'                      -- provides project management features
  use 'williamboman/mason.nvim'                      -- provides syntax highlighting and other features for the Mason templating language
  use 'https://git.sr.ht/~whynothugo/lsp_lines.nvim' -- adds line diagnostics to the sign column for supported filetypes

  -- Telescope: provides a fuzzy finder for neovim
  use 'nvim-telescope/telescope.nvim'              -- provides core functionality for the fuzzy finder
  use 'nvim-telescope/telescope-file-browser.nvim' -- adds a file browser to the fuzzy finder
  use({
    'nvim-telescope/telescope-fzf-native.nvim',
    run =
    'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  })
  use 'nvim-telescope/telescope-symbols.nvim'   -- adds symbol searching to the fuzzy finder
  use 'jvgrootveld/telescope-zoxide'            -- adds integration with the Zoxide directory jump tool
  use 'nvim-telescope/telescope-ui-select.nvim' -- provides a UI for selecting multiple results in the fuzzy finder

  use 'f-person/auto-dark-mode.nvim'
require('packer').use { 'mhartington/formatter.nvim' }


  -- more
  --
use 'instant-markdown/vim-instant-markdown'

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
