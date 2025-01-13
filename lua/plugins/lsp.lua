return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
		vim.lsp.set_log_level("debug")

        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

		local on_attach = function(_, bufnr)
			local function buf_set_option(...)
				vim.api.nvim_buf_set_option(bufnr, ...)
			end

			buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

		end

		vim.keymap.set("n", "<D-d>", function() vim.lsp.buf.definition() end, {})
		vim.keymap.set("n", "<D-i>", function() vim.lsp.buf.implementation() end, {})
		vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, {})
		vim.keymap.set("n", "<leader>r", function() vim.lsp.buf.references() end, {})
		vim.keymap.set("n", "<D-r>", function() vim.lsp.buf.rename() end, {})
		vim.keymap.set("n", "<D-.>", function() vim.lsp.buf.code_action() end, {})
		vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, {})
		vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, {})
		vim.keymap.set("n", "<C-w>d", function() vim.diagnostic.open_float() end, {})
		vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, {})
		vim.keymap.set("n", "gf", function() vim.lsp.buf.format({ async = true }) end, {})

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "gopls",
				"intelephense",
				"eslint",
				"pbls",
				"pylsp",
				"golangci_lint_ls",
            },
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities,
						on_attach = on_attach
                    }
                end,
                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        },
						on_attach = on_attach
                    }
                end,
				["gopls"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.gopls.setup {
						on_attach = function(client, bufnr)
							vim.api.nvim_create_autocmd({"BufWritePre"}, {
								buffer = bufnr,
								callback = function()
									vim.lsp.buf.format({bufnr = bufnr, id = client.id})
								end,
							})
						end
					}
				end
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-Space>'] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                { name = 'buffer' },
            })
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
