return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
			'nvim-lua/plenary.nvim',
			'BurntSushi/ripgrep'
    },
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "" },
		},
    lazy = false,
}
