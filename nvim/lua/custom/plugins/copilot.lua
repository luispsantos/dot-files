return {
  'github/copilot.vim',
  config = function()
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true

    -- Use Ctrl+Enter to accept Copilot suggestions
    -- <C-CR> represents Ctrl+Enter
    vim.api.nvim_set_keymap('i', '<C-j>', 'copilot#Accept("<CR>")', {
      expr = true,
      silent = true,
    })
  end,
}
