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


-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here
    
    use({ "github/copilot.vim" })
	-- use({ "ms-jpq/coq_nvim", commit = "49189b020236002bae41f823da9ac0f73dca873f" })
	-- use({ "ms-jpq/coq.thirdparty" })
    use({ "godlygeek/tabular", commit = "339091ac4dd1f17e225fe7d57b48aff55f99b23a" })
    use({ "tpope/vim-commentary", commit = "e87cd90dc09c2a203e13af9704bd0ef79303d755" })
    use({ "tpope/vim-eunuch", commit = "291ef1f8c8996ca7715df1032a35a27b12d7b5cf" })
    use({ "tpope/vim-surround", commit = "3d188ed2113431cf8dac77be61b842acb64433d9" })
    use({ "p00f/nvim-ts-rainbow", commit = "064fd6c0a15fae7f876c2c6dd4524ca3fad96750" })
    use { 'hrsh7th/nvim-cmp', requires = { 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-path', 'hrsh7th/cmp-nvim-lua', 'onsails/lspkind-nvim' } }
    use { 'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp' }
    use { 'hrsh7th/vim-vsnip', requires = 'hrsh7th/nvim-cmp' }
    use { 'hrsh7th/cmp-vsnip', requires = 'hrsh7th/nvim-cmp' }
    use { 'hrsh7th/cmp-calc', requires = 'hrsh7th/nvim-cmp' }
    use { 'hrsh7th/cmp-emoji', requires = 'hrsh7th/nvim-cmp' }
    use { 'hrsh7th/cmp-path', requires = 'hrsh7th/nvim-cmp' }
    use({ "hrsh7th/cmp-cmdline", commit = "8bc9c4a34b223888b7ffbe45c4fe39a7bee5b74d" })
    use({ "hrsh7th/cmp-buffer", commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" })
    use({ "saadparwaiz1/cmp_luasnip", commit = "18095520391186d634a0045dacaa346291096566" })
    use({ "hrsh7th/cmp-nvim-lsp" })
    use({ "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" })
    use({ "hrsh7th/cmp-path", commit = "91ff86cd9c29299a64f968ebb45846c485725f23" })
    use({ "f3fora/cmp-spell", commit = "60584cb75e5e8bba5a0c9e4c3ab0791e0698bffa" })
    use({ "ray-x/cmp-treesitter", commit = "b40178b780d547bcf131c684bc5fd41af17d05f2" })
    use({ "hrsh7th/cmp-calc", commit = "50792f34a628ea6eb31d2c90e8df174671e4e7a0" })
    use {
      'morhetz/gruvbox',
      requires = { 'rktjmp/lush.nvim' },
      config = function()
        vim.g.gruvbox_italic = 1
        vim.g.gruvbox_contrast_dark = 'hard'
        vim.g.gruvbox_contrast_light = 'hard'
      end
    }
    use 'overcache/NeoSolarized'
    use 'shaunsingh/nord.nvim'
    use 'rakr/vim-one'
    use 'NLKNguyen/papercolor-theme'

    use({ "folke/tokyonight.nvim", commit = "62b4e89ea1766baa3b5343ca77d62c817f5f48d0" })
    use({ "direnv/direnv.vim", commit = "4c858b8cd8cbfac998534096e6ffb710d7a07358" })
    use({ "junegunn/goyo.vim", commit = "7f5d35a65510083ea5c2d0941797244b9963d4a9" })
    use({ "tpope/vim-fugitive", commit = "23b9b9b2a3b88bdefee8dfd1126efb91e34e1a57" })
    use({ "lewis6991/impatient.nvim", commit = "d3dd30ff0b811756e735eb9020609fa315bfbbcc" })
    use({ "nvim-lua/plenary.nvim", commit = "4b7e52044bbb84242158d977a50c4cbcd85070c7" })
    use({ "moll/vim-bbye" })
    use({ "l3mon4d3/luasnip", commit = "59bb7ea0d26524cef0fce6dcf6192963ec232fdf" })
    use({ "hrsh7th/nvim-cmp", commit = "8a9e8a89eec87f86b6245d77f313a040a94081c1" })
    use({ "karb94/neoscroll.nvim", commit = "54c5c419f6ee2b35557b3a6a7d631724234ba97a" })
    use({ "folke/which-key.nvim", commit = "61553aeb3d5ca8c11eea8be6eadf478062982ac9" })
    use({ "nvim-tree/nvim-tree.lua", commit = "e38e061710c593d9b88c8ebb2c48f2842c89dc31" })
    use({ "gpanders/editorconfig.nvim" })
 	use({ "akinsho/bufferline.nvim", commit = "c78b3ecf9539a719828bca82fc7ddb9b3ba0c353" })
 	use({ "NTBBloodbath/galaxyline.nvim", commit = "4d4f5fc8e20a10824117e5beea7ec6e445466a8f" })
 	use({ "nvim-tree/nvim-web-devicons", commit = "3b1b794bc17b7ac3df3ae471f1c18f18d1a0f958" })
 	use({ "lewis6991/gitsigns.nvim", commit = "9ff7dfb051e5104088ff80556203634fc8f8546d" })
 	use({ "lukas-reineke/indent-blankline.nvim", commit = "db7cbcb40cc00fc5d6074d7569fb37197705e7f6" })
 	use({ "kkharji/lspsaga.nvim", commit = "9ec569a49aa7ff265764081acff9e5da839c13fe" })
 	use({ "jose-elias-alvarez/null-ls.nvim", commit = "07d4ed4c6b561914aafd787453a685598bec510f" })
 	use({ "neovim/nvim-lspconfig", commit = "0fd98b0d01bfc5603e56a959acb8e875e4039ac7" })
 	use({ "nvim-treesitter/nvim-treesitter", commit = "24caa23402247cf03cfcdd54de8cdb8ed00690ba" })
 	use({ "nvim-telescope/telescope.nvim" })
 	use({ "nvim-telescope/telescope-file-browser.nvim", commit = "2429ecfd2d76e3eb6c9f8d8ba2c6ce328975a95a" })
	use({'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',  commit = "580b6c48651cabb63455e97d7e131ed557b8c7e2" })
 	use({ "nvim-telescope/telescope-symbols.nvim", commit = "f7d7c84873c95c7bd5682783dd66f84170231704" })
 	use({ "jvgrootveld/telescope-zoxide", commit = "856af0d83d2e167b5efa080567456c1578647abe" })
 	use({ "nvim-telescope/telescope-ui-select.nvim", commit = "62ea5e58c7bbe191297b983a9e7e89420f581369" })
 	use({ "akinsho/toggleterm.nvim", commit = "3ba683827c623affb4d9aa518e97b34db2623093" })
 	use({ "sheerun/vim-polyglot", commit = "bc8a81d3592dab86334f27d1d43c080ebf680d42" })
 	use({ "ethanholz/nvim-lastplace", commit = "ecced899435c6bcdd81becb5efc6d5751d0dc4c8" })
 	use({ "ahmedkhalf/project.nvim", commit = "685bc8e3890d2feb07ccf919522c97f7d33b94e4" })
 	use({ "williamboman/mason.nvim", commit = "1c23135467af667c61aef72a7c08b9a032c50a52" })
    use({
      "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
      config = function()
        require("lsp_lines").setup()
      end,
    })

-- 	use({ "wbthomason/packer.nvim", commit = "00ec5adef58c5ff9a07f11f45903b9dbbaa1b422" }) -- Have packer manage itself
-- 	use({ "nvim-lua/plenary.nvim" }) -- Useful lua functions used by lots of plugins
-- 	use({ "windwp/nvim-autopairs", commit = "fa6876f832ea1b71801c4e481d8feca9a36215ec" }) -- Autopairs, integrates with both cmp and treesitter
-- 	use({ "numToStr/Comment.nvim", commit = "2c26a00f32b190390b664e56e32fd5347613b9e2" })
-- 	use({ "JoosepAlviste/nvim-ts-context-commentstring", commit = "88343753dbe81c227a1c1fd2c8d764afb8d36269" })
-- 	use({ "kyazdani42/nvim-web-devicons", commit = "8d2c5337f0a2d0a17de8e751876eeb192b32310e" })
-- 	use({ "kyazdani42/nvim-tree.lua", commit = "bdb6d4a25410da35bbf7ce0dbdaa8d60432bc243" })
-- 	use({ "akinsho/bufferline.nvim", commit = "c78b3ecf9539a719828bca82fc7ddb9b3ba0c353" })
-- 	use({ "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" })
-- 	use({ "nvim-lualine/lualine.nvim", commit = "3362b28f917acc37538b1047f187ff1b5645ecdd" })
-- 	use({ "akinsho/toggleterm.nvim", commit = "aaeed9e02167c5e8f00f25156895a6fd95403af8" })
-- 	use({ "ahmedkhalf/project.nvim", commit = "541115e762764bc44d7d3bf501b6e367842d3d4f" })
-- 	use({ "lewis6991/impatient.nvim", commit = "969f2c5c90457612c09cf2a13fee1adaa986d350" })
-- 	use({ "lukas-reineke/indent-blankline.nvim", commit = "6177a59552e35dfb69e1493fd68194e673dc3ee2" })
-- 	use({ "goolord/alpha-nvim", commit = "ef27a59e5b4d7b1c2fe1950da3fe5b1c5f3b4c94" })
-- 	use("folke/which-key.nvim")
--   use("kylechui/nvim-surround")

--   -- Rust
--   use('simrat39/rust-tools.nvim')

-- 	-- Colorschemes
-- 	use({ "folke/tokyonight.nvim", commit = "8223c970677e4d88c9b6b6d81bda23daf11062bb" })
-- 	use("lunarvim/darkplus.nvim")
--   use("overcache/NeoSolarized")
--   use('arcticicestudio/nord-vim')

-- 	-- cmp plugins
-- 	use({ "hrsh7th/nvim-cmp", commit = "df6734aa018d6feb4d76ba6bda94b1aeac2b378a" }) -- The completion plugin
-- 	use({ "hrsh7th/cmp-buffer", commit = "62fc67a2b0205136bc3e312664624ba2ab4a9323" }) -- buffer completions
-- 	use({ "hrsh7th/cmp-path", commit = "466b6b8270f7ba89abd59f402c73f63c7331ff6e" }) -- path completions
-- 	use({ "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" }) -- snippet completions
-- 	use({ "hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" })
-- 	use({ "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" })
--   use({ 'saecki/crates.nvim', tag = 'v0.2.1' })
--   use({ 'David-Kunz/cmp-npm'})


-- 	-- snippets
-- 	use({ "L3MON4D3/LuaSnip", commit = "79b2019c68a2ff5ae4d732d50746c901dd45603a" }) --snippet engine
--   use({ "rafamadriz/friendly-snippets", commit = "d27a83a363e61009278b6598703a763ce9c8e617" }) -- a bunch of snippets to use
-- 	use({ "honza/vim-snippets" }) -- a bunch of snippets to use


-- 	-- LSP
-- 	use({ "neovim/nvim-lspconfig", commit = "148c99bd09b44cf3605151a06869f6b4d4c24455" }) -- enable LSP
-- 	use({ "williamboman/nvim-lsp-installer", commit = "e9f13d7acaa60aff91c58b923002228668c8c9e6" }) -- simple to use language server installer
-- 	use({ "jose-elias-alvarez/null-ls.nvim", commit = "ff40739e5be6581899b43385997e39eecdbf9465" }) -- for formatters and linters

-- 	-- Telescope
-- 	use({ "nvim-telescope/telescope.nvim" })
-- 	use({ "nvim-telescope/telescope-media-files.nvim" })

-- 	-- Treesitter
-- 	use({
-- 		"nvim-treesitter/nvim-treesitter", commit = "67fb8939ff1f7e29659f5c4efe50a5689e3458bc", run = ":TSUpdate"
-- 	})
--   use({ "p00f/nvim-ts-rainbow" })

-- 	-- Git
-- 	use({ "lewis6991/gitsigns.nvim", commit = "c18e016864c92ecf9775abea1baaa161c28082c3" })

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
