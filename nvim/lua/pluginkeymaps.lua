-- mini bufremove
vim.keymap.set('n', '<leader>bd', function() require("mini.bufremove").delete() end, {noremap = true})

-- mini pick
-- vim.keymap.set('n', '<leader>ff', ':Pick files<CR>', {noremap = true})
-- vim.keymap.set('n', '<leader>fg', ':Pick grep_live<CR>', {noremap = true})
-- vim.keymap.set('n', '<leader>fb', ':Pick buffers<CR>', {noremap = true})

-- mini map
vim.keymap.set('n', '<leader>ms', function() require("mini.map").toggle() end, {noremap = true})
vim.keymap.set('n', '<leader>mt', function() require("mini.map").toggle_focus() end, {noremap = true})

-- mini trailspace
vim.keymap.set('n', '<leader>t', function() require("mini.trailspace").trim() end, {noremap = true})

-- vim.keymap.set('n', '-', function() require("mini.files").open() end, {noremap = true})
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Telescope

vim.api.nvim_set_keymap('n', '<leader>fF', '<cmd>Telescope find_files<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>ff", ":Telescope file_browser<cr>", { noremap = true })
