vim.loader.enable()

require("base")
require("options")

vim.g.python3_host_prog = vim.fn.expand('~/.local/share/mise/installs/python/latest/bin/python3')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"duane9/nvim-rg",
	{
    "github/copilot.vim",
    lazy = true,
  },
	-- {
	--   "neoclide/coc.nvim",
	--   branch = 'release',
	-- },
	"ckipp01/stylua-nvim",
	{
    "mrcjkb/rustaceanvim",
    version = '^5',
    lazy = false,
  },
	"nvim-lua/popup.nvim",
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	"ntk148v/vim-horizon",
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	"doums/darcula",
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"ray-x/go.nvim",
		dependencies = {
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup()
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()',
	},
	"mattn/vim-goimports",
})

require("tokyonight").setup({
	transparent = true,
	styles = {
		sidebars = "transparent",
    floats = "transparent",
	},
})
vim.cmd.colorscheme("tokyonight-moon")

vim.lsp.set_log_level("debug")

-- settings for go
require("go").setup({})
require("lspconfig").gopls.setup({
  on_attach = function()
    -- BufWritePre autocmd
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.go",
      callback = function()
        local params = vim.lsp.util.make_range_params()
        params.context = {only = {"source.organizeImports"}}
        local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
        for cid, res in pairs(result or {}) do
          for _, r in pairs(res.result or {}) do
            if r.edit then
              local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
              vim.lsp.util.apply_workspace_edit(r.edit, enc)
            end
          end
        end
        vim.lsp.buf.format({async = false})
      end
    })
  end,
})

-- settings for python
require("lspconfig").pyright.setup({})
require("lspconfig").ruff.setup({
	init_options = {
		settings = {
			-- Any extra CLI arguments for `ruff` go here.
			args = {},
		},
	},
})

-- settings for rust
-- require("lspconfig").rust_analyzer.setup({
-- 	on_attach = on_attach,
-- 	settings = {
-- 		["rust-analyzer"] = {
-- 			assist = {
-- 				importGranularity = "module",
-- 				importPrefix = "self",
-- 			},
-- 			cargo = {
-- 				loadOutDirsFromCheck = true,
-- 			},
-- 			procMacro = {
-- 				enable = true,
-- 			},
-- 		},
-- 	},
-- })
vim.g.rustaceanvim = {
  -- Plugin configuration
  tools = {
  },
  -- LSP configuration
  server = {
    on_attach = function(client, bufnr)
      -- you can also put keymaps in here
    end,
    default_settings = {
      -- rust-analyzer language server configuration
      ['rust-analyzer'] = {
      },
    },
  },
  -- DAP configuration
  dap = {
  },
}
-- require("rust-tools").setup({
-- 	tools = {
-- 		autoSetHints = true,
-- 		hover_with_actions = true,
-- 		inlay_hints = {
-- 			show_parameter_hints = false,
-- 			parameter_hints_prefix = "",
-- 			other_hints_prefix = "",
-- 		},
-- 	},
-- 	server = {
-- 		settings = {
-- 			["rust-analyzer"] = {
-- 				checkOnSave = {
-- 					command = "clippy",
-- 				},
-- 			},
-- 		},
-- 	},
-- })

-- for lua
require("stylua-nvim").setup({})
require("lspconfig").lua_ls.setup({
	settings = {
		Lua = {
			diagnostics = {
				globals = {
					"vim",
				},
			},
		},
	},
  commands = {
    Format = {
      function()
        require("stylua-nvim").format_file()
      end,
    },
  },
})

require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-j>"] = "move_selection_next",
				["<C-k>"] = "move_selection_previous",
			},
		},
	},
})

require("lualine").setup({
	options = {
		icons_enabled = false,
	},
	sections = {
		lualine_c = {
			{
				"filename",
				file_status = true,
				path = 2,
			},
		},
	},
})
