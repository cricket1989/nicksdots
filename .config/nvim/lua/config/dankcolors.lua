return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#131314',
				base01 = '#131314',
				base02 = '#80838a',
				base03 = '#80838a',
				base04 = '#d2d7df',
				base05 = '#f8faff',
				base06 = '#f8faff',
				base07 = '#f8faff',
				base08 = '#ff9fba',
				base09 = '#ff9fba',
				base0A = '#d4ddea',
				base0B = '#a5ffb2',
				base0C = '#f2f7ff',
				base0D = '#d4ddea',
				base0E = '#ebf3ff',
				base0F = '#ebf3ff',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#80838a',
				fg = '#f8faff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#d4ddea',
				fg = '#131314',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#80838a' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#f2f7ff', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#ebf3ff',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#d4ddea',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#d4ddea',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#f2f7ff',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#a5ffb2',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#d2d7df' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#d2d7df' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#80838a',
				italic = true
			})

			local current_file_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
			if not _G._matugen_theme_watcher then
				local uv = vim.uv or vim.loop
				_G._matugen_theme_watcher = uv.new_fs_event()
				_G._matugen_theme_watcher:start(current_file_path, {}, vim.schedule_wrap(function()
					local new_spec = dofile(current_file_path)
					if new_spec and new_spec[1] and new_spec[1].config then
						new_spec[1].config()
						print("Theme reload")
					end
				end))
			end
		end
	}
}
