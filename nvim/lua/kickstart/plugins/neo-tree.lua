-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
      filtered_items = {
        visible = true,         -- Show hidden files
        hide_dotfiles = true,   -- Show dotfiles (e.g., .gitignore)
        hide_gitignored = true, -- Show git-ignored files
        never_show = {          -- Never show these files/folders
          '.DS_Store',
          '__pycache__',
          '.git',
          '.mypy_cache',
          '.pytest_cache',
          '.ruff_cache',
          '.cenv',
        },
      },
    },
  },
}
