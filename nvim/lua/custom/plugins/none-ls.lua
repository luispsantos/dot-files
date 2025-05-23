return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
    'jayp0521/mason-null-ls.nvim', -- ensure dependencies are installed
  },
  config = function()
    local null_ls = require 'null-ls'
    local formatting = null_ls.builtins.formatting -- to setup formatters
    local diagnostics = null_ls.builtins.diagnostics -- to setup linters
    local code_actions = null_ls.builtins.code_actions -- to setup code actions

    -- list of formatters & linters for mason to install
    require('mason-null-ls').setup {
      debug = true, -- Enable debug mode
      ensure_installed = {
        'prettier', -- ts/js formatter
        'stylua', -- lua formatter
        'shfmt',
        'gofumpt', -- stricter go formatter
        'ruff',
        'eslint_d', -- added eslint_d
        -- 'mypy',
      },
      -- auto-install configured formatters & linters (with null-ls)
      automatic_installation = true,
    }

    local sources = {
      diagnostics.checkmake,
      -- Add eslint_d for diagnostics
      require('none-ls.diagnostics.eslint_d').with {
        condition = function(utils)
          return utils.root_has_file {
            'eslint.config.js',
            '.eslintrc.js',
            '.eslintrc.cjs',
            '.eslintrc.json',
            '.eslintrc.yaml',
            '.eslintrc.yml',
            '.eslintrc',
          }
        end,
      },
      -- Add eslint_d for formatting
      -- require('none-ls.formatting.eslint_d').with {
      --   condition = function(utils)
      --     return utils.root_has_file {
      --       '.eslintrc.js',
      --       '.eslintrc.cjs',
      --       '.eslintrc.json',
      --       '.eslintrc.yaml',
      --       '.eslintrc.yml',
      --       '.eslintrc',
      --     }
      --   end,
      -- },
      -- Add eslint_d for code actions
      require('none-ls.code_actions.eslint_d').with {
        condition = function(utils)
          return utils.root_has_file {
            'eslint.config.js',
            '.eslintrc.js',
            '.eslintrc.cjs',
            '.eslintrc.json',
            '.eslintrc.yaml',
            '.eslintrc.yml',
            '.eslintrc',
          }
        end,
      },
      formatting.prettier.with {
        filetypes = {
          'html',
          'json',
          'yaml',
          'markdown',
          -- Include JS/TS files only if ESLint isn't available for them
          condition = function(utils)
            return not utils.root_has_file {
              'eslint.config.js',
              '.eslintrc.js',
              '.eslintrc.json',
            }
          end,
        },
      },
      formatting.stylua,
      formatting.shfmt.with { args = { '-i', '4' } },
      formatting.terraform_fmt,
      formatting.gofumpt,
      require('none-ls.formatting.ruff').with { extra_args = { '--extend-select', 'I' } },
      require 'none-ls.formatting.ruff_format',
    }

    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
    null_ls.setup {
      -- debug = true, -- Enable debug mode. Inspect logs with :NullLsLog.
      sources = sources,
      -- you can reuse a shared lspconfig on_attach callback here
      on_attach = function(client, bufnr)
        if client.supports_method 'textDocument/formatting' then
          vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format { async = false }
            end,
          })
        end
      end,
      capabilities = {
        offsetEncoding = { 'utf-16' },
      },
    }
  end,
}
