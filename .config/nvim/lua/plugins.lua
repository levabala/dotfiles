local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local secret = vim.env.SECRET_RAW_PLUGIN_1
if secret then 
  vim.cmd('source ' .. secret)
end

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- navigation
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use { 'junegunn/fzf', run = ":call fzf#install()" }
  use { 'junegunn/fzf.vim' }
  use 'tpope/vim-vinegar'
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
  }
  use 'ggandor/leap.nvim'
  use 'ThePrimeagen/harpoon'
  use {
    'stevearc/oil.nvim',
    config = function() require('oil').setup() end
  }
  
  -- themes
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  
  -- visual
  use 'tanvirtin/monokai.nvim'
  use 'edkolev/tmuxline.vim'
  -- use 'SmiteshP/nvim-navic'
  
  -- editing
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  use 'mbbill/undotree'
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use 'windwp/nvim-ts-autotag'
  use 'gennaro-tedesco/nvim-peekup'
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })
  use 'wfxr/minimap.vim'
  use 'tpope/vim-sleuth'
  
  -- git
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use '~/arcadia/devtools/vim/plugin_bundles/signify'
  use '~/arcadia/devtools/vim/plugin_bundles/vcscommand'
  
  -- internal
  use 'nvim-lua/plenary.nvim'
  
  -- lsp and syntax
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }
  use 'nvim-treesitter/nvim-treesitter-context'
  use 'neovim/nvim-lspconfig'
  use 'jose-elias-alvarez/typescript.nvim'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'j-hui/fidget.nvim'
  use 'ray-x/lsp_signature.nvim'
  use 'simrat39/symbols-outline.nvim'
  use({
	"L3MON4D3/LuaSnip",
	tag = "v<CurrentMajor>.*",
	run = "make install_jsregexp"
  })
  use 'mfussenegger/nvim-dap'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
