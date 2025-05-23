return {
  'pmizio/typescript-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  opts = {},
  config = function()
    local api = require 'typescript-tools.api'
    local augroup = vim.api.nvim_create_augroup('TypeScriptFormatting', {})

    require('typescript-tools').setup {
      on_attach = function(client, bufnr)
        -- Disable the built-in TS formatting in favor of ESLint
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false

        -- Add keymaps for TypeScript specific functionality
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', '<leader>to', api.organize_imports, bufopts)
        vim.keymap.set('n', '<leader>tr', api.rename_file, bufopts)
        vim.keymap.set('n', '<leader>ti', api.add_missing_imports, bufopts)
        vim.keymap.set('n', '<leader>tu', api.remove_unused_imports, bufopts)

        -- Setup auto-import on save
        local import_augroup = vim.api.nvim_create_augroup('TypeScriptImports', {})
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = import_augroup,
          buffer = bufnr,
          callback = function()
            pcall(api.add_missing_imports)
            pcall(api.remove_unused_imports)
          end,
        })
      end,
      settings = {
        -- Complete JSX/TSX close tags
        jsx_close_tag = {
          enable = true,
          filetypes = { 'javascriptreact', 'typescriptreact' },
        },
        -- Include all import completion suggestions (including from node_modules)
        complete_function_calls = true,
        include_completions_with_insert_text = true,
        tsserver_file_preferences = {
          includeCompletionsForImportStatements = true,
          includeCompletionsWithSnippetText = true,
          includeAutomaticOptionalChainCompletions = true,
          includeCompletionsWithInsertText = true,
        },
      },
    }
  end,
}
