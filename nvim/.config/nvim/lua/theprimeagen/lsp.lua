local sumneko_root_path = "/home/chris/personal/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Setup nvim-cmp.
local cmp = require("cmp")
local source_mapping = {
	buffer = "[Buffer]",
	nvim_lsp = "[LSP]",
	nvim_lua = "[Lua]",
	cmp_tabnine = "[TN]",
	path = "[Path]",
}
local lspkind = require("lspkind")
require('lspkind').init({
    with_text = true,
})

cmp.setup({
    preselect = true,
    completion = { completeopt = 'menu,menuone,noinsert' },
    snippet = {
        expand = function(args)
            -- For `vsnip` user.
            -- vim.fn["vsnip#anonymous"](args.body)

            -- For `luasnip` user.
            require("luasnip").lsp_expand(args.body)

            -- For `ultisnips` user.
            -- vim.fn["UltiSnips#Anon"](args.body)
        end,
    },
    mapping = {
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif require('luasnip').expand_or_jumpable() then
                require('luasnip').expand_or_jump()
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif require('luasnip').jumpable(-1) then
                require('luasnip').jump(-1)
            else
                fallback()
            end
        end,
   },
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind]
            local menu = source_mapping[entry.source.name]
            if entry.source.name == 'cmp_tabnine' then
                if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
                    menu = entry.completion_item.data.detail .. ' ' .. menu
                end
                vim_item.kind = ''
            end
            vim_item.menu = menu
            return vim_item
        end
    },

    sources = {
        -- tabnine completion? yayaya

        -- { name = "cmp_tabnine" },

        { name = "nvim_lsp" },

        -- For vsnip user.
        -- { name = 'vsnip' },

        -- For luasnip user.
        { name = "luasnip" },

        -- For ultisnips user.
        -- { name = 'ultisnips' },

        { name = "buffer" },
    },
})

local tabnine = require('cmp_tabnine.config')
tabnine:setup({
    max_lines = 1000,
    max_num_results = 20,
    sort = true,
	run_on_every_keystroke = true,
	snippet_placeholder = '..',
})

local function config(_config)
	return vim.tbl_deep_extend("force", {
		capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
	}, _config or {})
end

require("lspconfig").tsserver.setup(config({
    root_dir = function()
        print("TypeScript-Rootdir", vim.loop.cwd())
        return vim.loop.cwd()
    end,
}))

require("lspconfig").ccls.setup(config({
    init_options = {
        cache = {
            directory = ".ccls-cache";
        }
    },
    root_dir = function()
        print("clangd-Rootdir", vim.loop.cwd())
		return vim.loop.cwd()
	end,
}))

require("lspconfig").pylsp.setup(config({
    cmd = { "pylsp" },
    filetypes = { "python" },
    single_file_support = true,
    root_dir = function()
        print("Python-Rootdir", vim.loop.cwd())
        return vim.loop.cwd()
    end,
}))

require("lspconfig").svelte.setup(config({
    root_dir = function()
        print("Svelte-Rootdir", vim.loop.cwd())
        return vim.loop.cwd()
    end,
}))

require("lspconfig").cssls.setup(config({
    root_dir = function()
        print("cssls-Rootdir", vim.loop.cwd())
        return vim.loop.cwd()
    end,
    cmd = {"css-languageserver", "--stdio"},
}))

require("lspconfig").gopls.setup(config({
	cmd = { "gopls", "serve" },
    root_dir = function()
        print("Go-Rootdir", vim.loop.cwd())
        return vim.loop.cwd()
    end,
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
		},
	},
}))

-- who even uses this?
require("lspconfig").rust_analyzer.setup(config({
    cmd = { "rustup", "run", "stable", "rust-analyzer"},
    root_dir = function()
        print("Rust-Rootdir", vim.loop.cwd())
        return vim.loop.cwd()
    end,
    --[[
    settings = {
        rust = {
            unstable_features = true,
            build_on_save = false,
            all_features = true,
        },
    }
    --]]
}))

require("lspconfig").sumneko_lua.setup(config({
	cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = vim.split(package.path, ";"),
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
			},
		},
	},
}))

local opts = {
	-- whether to highlight the currently hovered symbol
	-- disable if your cpu usage is higher than you want it
	-- or you just hate the highlight
	-- default: true
	highlight_hovered_item = true,

	-- whether to show outline guides
	-- default: true
	show_guides = true,
}

require("symbols-outline").setup(opts)

local snippets_paths = function()
	local plugins = { "friendly-snippets" }
	local paths = {}
	local path
	local root_path = vim.env.HOME .. "/.vim/plugged/"
	for _, plug in ipairs(plugins) do
		path = root_path .. plug
		if vim.fn.isdirectory(path) ~= 0 then
			table.insert(paths, path)
		end
	end
	return paths
end

require("luasnip.loaders.from_vscode").lazy_load({
	paths = snippets_paths(),
	include = nil, -- Load all languages
	exclude = {},
})

require('lspconfig').solargraph.setup(config({
    cmd = { "solargraph", "stdio" },
    filetypes = { "ruby" },
    init_options = {
        formatting = true
    },
    root_dir = function()
        print("Solargraph-Rootdir", vim.loop.cwd())
        return vim.loop.cwd()
    end,
    settings = {
        solargraph = {
            diagnostics = true
        },
    }
}))
require'lspconfig'.terraform_lsp.setup(config({
    root_dir = function()
        print("Terraform-Rootdir", vim.loop.cwd())
        return vim.loop.cwd()
    end,
}))
--[[
require('lspconfig').yamlls.setup(config({
    root_dir = function()
        print("YAML-Rootdir", vim.loop.cwd())
        return vim.loop.cwd()
    end,
    settings = {
        yaml = {
            schemas = {
                ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.k8s.yaml",
            },
        },
    }
}))--]]

require('lspconfig').ansiblels.setup(config({
    root_dir = function()
        print("Ansible-Rootdir", vim.loop.cwd())
        return vim.loop.cwd()
    end,
    cmd = { "ansible-language-server", "--stdio" },
    filetypes = { "yaml", "yaml.ansible" },
    settings = {
        ansible = {
            ansible = {
                path = "ansible"
            },
            ansibleLint = {
                enabled = true,
                path = "ansible-lint"
            },
            executionEnvironment = {
                enabled = false
            },
            python = {
                interpreterPath = "python"
            },
        },
    },
    single_file_support = true,
}))

require'lspconfig'.ocamllsp.setup(config({
    cmd = { "ocamllsp" },
    filetypes = { "ocaml", "ocaml.menhir", "ocaml.interface", "ocaml.ocamllex", "reason" },
    root_dir = function()
        print("OCaml-Rootdir", vim.loop.cwd())
        return vim.loop.cwd()
    end,
}))
