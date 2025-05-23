return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'github/copilot.vim' },
      { 'nvim-lua/plenary.nvim', branch = 'master' },
    },
    build = 'make tiktoken',
    opts = {
      model = 'claude-3.7-sonnet',
    },
    keys = {
      { '<leader>CC', '<cmd>CopilotChatOpen<cr>',    desc = 'CopilotChat' },
      { '<leader>CP', '<cmd>CopilotChatPrompts<cr>', desc = 'CopilotChat - Prompt' },
    },
  },
}
