vim.api.nvim_set_var('nnn#set_default_mappings', 0)
vim.api.nvim_set_var('nnn#command', 'nnn -x -c')
vim.api.nvim_set_var('nnn#layout', 
	{ 
		window = { 
			width = 0.9,
			height = 0.6,
			highlight = 'Debug'
		}
	}
)
vim.api.nvim_set_keymap('n', '<leader>n', ":NnnPicker<cr>", {silent = true})
