vim.keymap.set('n', '<leader>hh', '<cmd>DiffviewFileHistory<cr>', { desc = 'Repo history' })

-- Avante keybindings
vim.keymap.set('n', '<leader>ab', '<cmd>AvanteClear<cr>', { desc = 'avante: clear chat' })

vim.keymap.set('n', '<leader>g', ':Neogit<CR>', { desc = 'Open Neogit' })

vim.keymap.set('n', '<leader>C', ':CopilotChat<CR>', { desc = 'Copilot Chat' })

vim.keymap.set('n', '<leader>j', ":%!jq '.'<CR>", { desc = 'Format JSON with jq' })

vim.keymap.set('n', '<leader>sw', function()
  require('telescope.builtin').grep_string { search = vim.fn.expand '<cword>' }
end, { desc = 'Find word under cursor' })

-- Navigate through diagnostics
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })

-- Open diagnostics in a floating window
vim.keymap.set('n', '<leader>dd', vim.diagnostic.open_float, { desc = 'Show diagnostic details' })

-- Open all diagnostics in quickfix list
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setqflist, { desc = 'Open all diagnostics in quickfix' })

-- Open diagnostics for current buffer in location list
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'Open buffer diagnostics in loclist' })

vim.keymap.set('n', '<leader>*', function()
  require('telescope.builtin').grep_string { search = vim.fn.expand '<cword>' }
end, { desc = 'Search word under cursor (Telescope)' })

-- Navigation key-- Colemak-DH (rstf) Navigation remaps for normal, visual, and operator-pending modes
local modes = { 'n', 'x', 'o' }
for _, mode in ipairs(modes) do
  vim.keymap.set(mode, 'r', 'h', { desc = 'Move left' })
  vim.keymap.set(mode, 's', 'j', { desc = 'Move down' })
  vim.keymap.set(mode, 'f', 'k', { desc = 'Move up' })
  vim.keymap.set(mode, 't', 'l', { desc = 'Move right' })
end -- Go file-specific settings

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'go',
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
    vim.bo.expandtab = false
  end,
})
