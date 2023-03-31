local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

vim.cmd [[packadd packer.nvim]]

local ok, packer = pcall(require, "packer")
if not ok then
  return
end

packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float {}
    end,
  }
}

return packer.startup(function(use)
  -- Packer installs Packer
  use 'wbthomason/packer.nvim'

  -- Common utilities
  use 'nvim-lua/plenary.nvim'

  -- Colorscheme
  -- use 'martinsione/darkplus.nvim'

  use { "catppuccin/nvim", as = "catppuccin" }

  -- File icons
  use {
    "kyazdani42/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup {}
    end
  }

  -- Statusline
  use 'nvim-lualine/lualine.nvim'

  -- Tabs
  use {
    'akinsho/bufferline.nvim',
    tag = "v3.*",
    requires = 'nvim-tree/nvim-web-devicons'
  }

  use {
    -- Telescope integration
    'nvim-telescope/telescope.nvim',
    'nvim-telescope/telescope-file-browser.nvim'
  }

  use 'tpope/vim-commentary'

  -- TreeSitter for source code parsing
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }

  -- Additional text objects via treesitter
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
    }
  }

  use {
    -- LSP Support
    { 'neovim/nvim-lspconfig' },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },

    -- Autocompletion
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-nvim-lua' },

    -- Snippets
    { 'L3MON4D3/LuaSnip' },
    { 'rafamadriz/friendly-snippets' },

    { 'j-hui/fidget.nvim' },
  }

  -- LSP
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'jose-elias-alvarez/typescript.nvim'

  -- Pairs and Tags
  use {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup {}
    end
  }

  use {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup {}
    end
  }

  -- Which key
  use "folke/which-key.nvim"

  use "gpanders/editorconfig.nvim"
  use "tpope/vim-dispatch"
  use "datamadsen/vim-compiler-plugin-for-dotnet"

  use "bkad/CamelCaseMotion"

  if packer_bootstrap then
    require('packer').sync()
  end
end)
