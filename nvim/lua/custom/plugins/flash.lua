return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  ---@type Flash.Config
  opts = {
    -- Optional: tweak Flash behavior here
    labels = 'asdfghjklqwertyuiopzxcvbnm',
    search = {
      multi_window = true, -- set to true to jump across windows
      forward = false,
      wrap = false,
    },
    modes = {
      char = {
        enabled = true,
        keys = { 'f', 'F', 't', 'T' }, -- replace built-in motions
      },
    },
  },
  keys = {
    -- Basic Flash jump
    {
      's',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump()
      end,
      desc = 'Flash jump',
    },

    -- Jump to word
    {
      'S',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump { pattern = vim.fn.expand '<cword>' }
      end,
      desc = 'Flash to word under cursor',
    },

    -- Remote jump (across windows)
    {
      'r',
      mode = 'o',
      function()
        require('flash').remote()
      end,
      desc = 'Remote Flash jump',
    },

    -- Treesitter search (useful for functions, loops, etc.)
    {
      '<leader>st',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').treesitter()
      end,
      desc = 'Flash Treesitter',
    },

    -- Toggle Flash search in command line
    {
      '<c-s>',
      mode = 'c',
      function()
        require('flash').toggle()
      end,
      desc = 'Toggle Flash Search',
    },
  },
}
