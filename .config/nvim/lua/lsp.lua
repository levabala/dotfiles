-- local navic = require("nvim-navic")

require "lsp_signature".setup({})
require('oil').setup({
    keymaps = {
        ["g?"] = "actions.show_help",
        ["<C-l>"] = "actions.select",
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<C-j>"] = "actions.refresh",
        ["<C-h>"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["g."] = "actions.toggle_hidden",
    },
    use_default_keymaps = false,
    skip_confirm_for_simple_edits = true,
})

local function filter(arr, fn)
  if type(arr) ~= "table" then
    return arr
  end

  local filtered = {}
  for k, v in pairs(arr) do
    if fn(v, k, arr) then
      table.insert(filtered, v)
    end
  end

  return filtered
end

local function filterNodeModules(value)
  return string.match(value.filename, 'node_modules') == nil
end

local function filterNotAutoImport(value)
    print("here i am")
    print(vim.inspect(value))
  return string.match(value.filename, 'Add import') ~= nil
end

local function on_list(options, filterFunc, forceOpen)
  local items = options.items
  if #items > 1 then
    items = filter(items, filterFunc)
  end

  vim.fn.setqflist({}, ' ', { title = options.title, items = items, context = options.context })

  local mode = (#items > 1 or forceOpen) and 'copen' or 'cfirst'
  vim.api.nvim_command(mode)
end

local function on_list_node_modules(options)
    return on_list(options, filterNodeModules)
end

local function on_list_not_auto_import(options)
    return on_list(options, filterNotAutoImport, true)
end

--
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local setup_keymaps = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition{on_list=on_list_node_modules} end, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gr', function() 
    vim.lsp.buf.references({ includeDeclarations = false})
  end, bufopts)
  vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<space>ci', function() vim.lsp.buf.code_action{on_list=on_list_not_auto_import} end, bufopts)
end

local setup_keymaps_formatting = function(client, bufnr)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
  vim.keymap.set('v', '<space>f', vim.lsp.buf.format, bufopts)

  -- vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local on_attach = function(client, bufnr)
  setup_keymaps(client, bufnr)
  -- navic.attach(client, bufnr)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

-- Set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        require("null-ls").builtins.formatting.prettierd.with({
            disabled_filetypes = { "scss" },
        }),
        require("null-ls").builtins.formatting.stylelint
    },
    debug = true,
    log_level = "debug",
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        setup_keymaps_formatting(client, bufnr)
    end,
})

require('lspconfig')['eslint'].setup {
    filetypes = {
      'javascript',
      'javascriptreact',
      'javascript.jsx',
      'typescript',
      'typescriptreact',
      'typescript.tsx',
    },
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        on_attach(client, bufnr)
    end,
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

enablePoints={false}
require'lspconfig'.cssls.setup{
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        on_attach(client, bufnr)
    end,
}

require('lspconfig').stylelint_lsp.setup{
    filetypes = {
      'scss',
    },
    settings = {
        stylelintplus = {
        }
    },
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        on_attach(client, bufnr)
    end,
}

require("typescript").setup({
    go_to_source_definition = {
        fallback = true,
    },
    server = {
        on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = false
            on_attach(client, bufnr)
        end,
        flags = lsp_flags,
    },
    capabilities = capabilities
})

require'lspconfig'.lua_ls.setup{
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        on_attach(client, bufnr)
    end,
}

require'lspconfig'.rust_analyzer.setup{
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        on_attach(client, bufnr)
    end,
}

-- TODO: move outside lsp.lua?
require'nvim-treesitter.configs'.setup{
  indent = {
    enable = true
  },
  highlight={
    enable = true
  },
  context_commentstring = {
    enable = true
  },
  autotag = {
    enable = true,
  },
  -- incremental_selection = {
  --   enable = true,
  --   keymaps = {
  --     init_selection = '<CR>',
  --     scope_incremental = '<CR>',
  --     node_incremental = '<TAB>',
  --     node_decremental = '<S-TAB>',
  --   },
  -- },
}

-- TODO: move to other file
require("fidget").setup{}
require('leap').add_default_mappings()
require("harpoon").setup({
  menu = {
    width = vim.api.nvim_win_get_width(0) - 24,
  }
})
require("symbols-outline").setup({
    show_relative_numbers = true,
    autofold_depth = 1,
})

-- harpoon start
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
vim.keymap.set("n", "<C-l>", ui.select_menu_item)

vim.api.nvim_set_keymap('n', '<leader>h', '<cmd>lua require("harpoon.ui").nav_file(vim.v.count1)<cr>',  opts)
-- harpoon end

vim.keymap.set("n", "gl", vim.diagnostic.setqflist)
vim.api.nvim_set_keymap('n', '<leader>s', '<cmd>SymbolsOutline<cr>',  opts)

-- require("nvim-tree").setup()
-- require('toggle_lsp_diagnostics').init({
--     -- somehow disable update_in_insert?
-- })
