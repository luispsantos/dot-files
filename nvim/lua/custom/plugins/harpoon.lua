return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()

    vim.keymap.set('n', '<leader>ha', function()
      harpoon:list():add()
    end, { desc = 'Harpoon: Add file' })
    vim.keymap.set('n', '<C-e>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Harpoon: Toggle quick menu' })

    vim.keymap.set('n', '<C-m>', function()
      harpoon:list():select(1)
    end)
    vim.keymap.set('n', '<C-n>', function()
      harpoon:list():select(2)
    end)
    vim.keymap.set('n', '<C-b>', function()
      harpoon:list():select(3)
    end)
    vim.keymap.set('n', '<C-v>', function()
      harpoon:list():select(4)
    end)
    --
    -- Remove current file from Harpoon list
    vim.keymap.set('n', '<leader>hr', function()
      harpoon:list():remove()
    end, { desc = 'Harpoon: Remove file' })

    -- Remove specific file by index from Harpoon list
    vim.keymap.set('n', '<leader>hR', function()
      local index = tonumber(vim.fn.input 'Remove index: ')
      if index then
        harpoon:list():remove_at(index)
      end
    end, { desc = 'Harpoon: Remove file by index' })

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', '<leader>hp', function()
      harpoon:list():prev()
    end, { desc = 'Harpoon: Previous file' })
    vim.keymap.set('n', '<leader>hn', function()
      harpoon:list():next()
    end, { desc = 'Harpoon: Next file' })

    -- basic telescope configuration
    -- local conf = require('telescope.config').values
    -- local function toggle_telescope(harpoon_files)
    --   local file_paths = {}
    --   for _, item in ipairs(harpoon_files.items) do
    --     table.insert(file_paths, item.value)
    --   end
    --
    --   require('telescope.pickers')
    --       .new({}, {
    --         prompt_title = 'Harpoon',
    --         finder = require('telescope.finders').new_table {
    --           results = file_paths,
    --         },
    --         previewer = conf.file_previewer {},
    --         sorter = conf.generic_sorter {},
    --       })
    --       :find()
    -- end
    --
    -- vim.keymap.set('n', '<C-e>', function()
    --   toggle_telescope(harpoon:list())
    -- end, { desc = 'Open harpoon window' })
  end,
}
