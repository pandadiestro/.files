vim.loader.enable()

--
local disabled_built_ins = {
    "netrw",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit",
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end
--

vim.o.shadafile = "NONE"
vim.o.lazyredraw = true

vim.o.termguicolors = true
vim.o.number = true

vim.o.smartindent = true
vim.o.expandtab = true

vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4

vim.o.backspace = "indent,eol,start"
vim.o.clipboard = "unnamed,unnamedplus"

vim.o.hidden = true
vim.o.mouse = "a"
vim.o.keymodel = "startsel"

vim.o.linebreak = true
vim.o.encoding = "utf-8"

-- set to not generate backups to prevent problems
vim.o.backup = false
vim.o.writebackup = false

-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
-- delays and poor user experience
vim.o.updatetime = 600

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved
vim.o.signcolumn = "yes"
vim.o.guicursor = "i:block"
vim.o.cmdheight = 0
vim.o.textwidth = 80

-- Some important global variables
vim.g.mapleader = ' '

vim.g['nvim_markdown_preview_format'] = 'markdown'
vim.g['netrw_liststyle'] = 0
vim.g['netrw_fastbrowse'] = 0
vim.g['netrw_altfile'] = 0
vim.g['netrw_banner'] = 0
vim.g['vim_svelte_plugin_use_typescript'] = 1
vim.g['zig_fmt_parse_errors'] = 0
vim.g['zig_fmt_autosave'] = 0

vim.api.nvim_create_autocmd("FileType", {
    pattern = 'netrw',
    callback = function()
        vim.opt_local.bufhidden = 'delete'
    end
})

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = '*.mds',
    callback = function()
        vim.api.nvim_exec('set filetype=svelte', false)
    end
})
--

local globalopts = {noremap = true, silent = true}

-- Basic mappings
vim.keymap.set("i", "<C-Right>", "<Esc>ea", globalopts)
vim.keymap.set("n", "<C-Right>", "e", globalopts)
vim.keymap.set("x", "<C-Right>", "e", globalopts)

vim.keymap.set("i", "<C-S-Right>", "<C-o>ve", globalopts)
vim.keymap.set("n", "<C-S-Right>", "ve", globalopts)
vim.keymap.set("x", "<C-S-Right>", "e", globalopts)

vim.keymap.set("i", "<C-Left>", "<C-o>b", globalopts)
vim.keymap.set("n", "<C-Left>", "b", globalopts)
vim.keymap.set("x", "<C-Left>", "b", globalopts)

vim.keymap.set("i", "<C-S-Left>", "<C-o>vb", globalopts)
vim.keymap.set("n", "<C-S-Left>", "vb", globalopts)
vim.keymap.set("x", "<C-S-Left>", "b", globalopts)

vim.keymap.set("i", "<C-z>", "<C-o>u", globalopts)
vim.keymap.set("i", "<C-y>", "<C-o><C-r>", globalopts)

vim.keymap.set("x", "<Tab>", ">gv", globalopts)
vim.keymap.set("x", "<S-Tab>", "<gv", globalopts)
vim.keymap.set("x", "<BS>", "x", globalopts)
vim.keymap.set("n", "<C-o>", ":bp<CR>", globalopts)
vim.keymap.set("n", "<C-p>", ":bn<CR>", globalopts)
vim.keymap.set("n", "<M-w>", ":bw<CR>", globalopts)

vim.keymap.set("i", "<C-BS>", "<C-w>", globalopts)
vim.keymap.set("i", "<C-Del>", "<C-o>dw", globalopts)

vim.keymap.set("t", "<Esc>", "<C-\\><C-N>", globalopts)
--

-- Actually cool mappings
-- duplicate lines in normal mode
vim.keymap.set("n", "<C-d>", ":t.<CR>", globalopts)
--

-- Useful stuff
vim.api.nvim_create_user_command('Words', '!wc -w "%"', { nargs = '?' })
vim.api.nvim_create_user_command('JSONpretty', '%!jq .', { nargs = '?' })
--

require('paq') {
    'savq/paq-nvim',                            -- paq self management
    'tpope/vim-sensible',                       -- nice defaults
    'elihunter173/dirbuf.nvim',                 -- minimalistic netrw replacement
    'echasnovski/mini.starter',                 -- minimalist start screen

    'neovim/nvim-lspconfig',                    -- lsp config block
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',
    'dcampos/nvim-snippy',
    'dcampos/cmp-snippy',
    'leafOfTree/vim-svelte-plugin',

    'kvrohit/rasmus.nvim',                      -- minimalist lua theme
    'NvChad/nvim-colorizer.lua',                -- CSS color preview
    'nvim-tree/nvim-web-devicons',              -- pretty icons

    'lambdalisue/suda.vim',                     -- sudo without leaving regular session
    'm4xshen/autoclose.nvim',                   -- easier to configure autopairs
    'pandadiestro/nvim-markdown-preview',       -- my fork of the in-browser markdown preview plugin
    'chaoren/vim-wordmotion',                   -- better word motion for programming
    {
        'willothy/moveline.nvim',
        build = 'make',
    },
    'brenton-leighton/multiple-cursors.nvim',   -- multicursors, but lua
    'nvim-lualine/lualine.nvim',                -- faster statusline
    'echasnovski/mini.trailspace',              -- minimalistic trailing space solution
  --'dstein64/vim-startuptime',                 -- benchmarking plugin
    'jidn/vim-dbml',
}

local moveline = require('moveline')
vim.keymap.set("n", "<C-S-Up>", moveline.up, globalopts)
vim.keymap.set("n", "<C-S-Down>", moveline.down, globalopts)
vim.keymap.set("v", "<C-S-Up>", moveline.block_up, globalopts)
vim.keymap.set("v", "<C-S-Down>", moveline.block_down, globalopts)

require("dirbuf").setup {
    hash_padding = 2,
    show_hidden = true,
    sort_order = "directories_first",
    write_cmd = "DirbufSync",
}

require('multiple-cursors').setup()
vim.keymap.set("n", "<C-Down>", "<Cmd>MultipleCursorsAddDown<CR>", globalopts)
vim.keymap.set("n", "<C-j>", "<Cmd>MultipleCursorsAddDown<CR>", globalopts)
vim.keymap.set("n", "<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>", globalopts)
vim.keymap.set("n", "<C-k>", "<Cmd>MultipleCursorsAddUp<CR>", globalopts)
vim.keymap.set("x", "<C-n>", "<Cmd>MultipleCursorsAddJumpNextMatch<CR>", globalopts)

require('nvim-web-devicons').setup {
    color_icons = false,
    strict = true
}

require('colorizer').setup()

require('mini.trailspace').setup()
vim.keymap.set("n", "<leader>tw", MiniTrailspace.trim, globalopts)

require('autoclose').setup {
    options = {
        disable_when_touch = true,
        touch_regex = "[%w(%[{,\"\']",
        pair_spaces = true,
        auto_indent = true,
    },
}

require('mini.starter').setup {
    header = [[
       (\__/)
       (•ㅅ•)          Don’t talk to
    ＿ノヽ ノ＼＿      me or my son
`/　`/  ⌒Ｙ⌒  Ｙ ヽ     ever again.
( 　(三ヽ人　 /　 |
|　ﾉ⌒＼ ￣￣ヽ   ノ
ヽ＿＿＿＞､＿_／
     ｜( 王 ﾉ〈 (\__/)
     /ﾐ`ー―彡\  (•ㅅ•)
    / ╰    ╯  \ /    \>
]],
    items = {
        require('mini.starter').sections.builtin_actions(),
    },
    query_updaters = '',
    footer = [[
"Talk is cheap. Show me the code."
                    -Torvalds]]
}


--- lualine setup
local function CustomMode()
    return '[' .. vim.fn.mode() .. ']'
end

local colors = {
  black        = '#282828',
  white        = '#ebdbb2',
  red          = '#fb4934',
  green        = '#b8bb26',
  blue         = '#83a598',
  yellow       = '#fe8019',
  gray         = '#a89984',
  darkgray     = '#3c3836',
  lightgray    = '#504945',
  inactivegray = '#7c6f64',
}

local CustomTheme = {
    normal = {
        a = { bg = colors.black, fg = colors.white, gui = 'bold' },
        b = { bg = colors.black, fg = colors.white },
        c = { bg = colors.black, fg = colors.white },
    },
    insert = {
        a = { bg = colors.black, fg = colors.white, gui = 'bold' },
        b = { bg = colors.black, fg = colors.white },
        c = { bg = colors.black, fg = colors.white },
    },
    visual = {
        a = { bg = colors.black, fg = colors.white, gui = 'bold' },
        b = { bg = colors.black, fg = colors.white },
        c = { bg = colors.black, fg = colors.white },
    },
    replace = {
        a = { bg = colors.black, fg = colors.white, gui = 'bold' },
        b = { bg = colors.black, fg = colors.white },
        c = { bg = colors.black, fg = colors.white },
    },
    command = {
        a = { bg = colors.black, fg = colors.white, gui = 'bold' },
        b = { bg = colors.black, fg = colors.white },
        c = { bg = colors.black, fg = colors.white },
    },
    inactive = {
        a = { bg = colors.black, fg = colors.gray},
    },
}

require('lualine').setup {
    options = {
        theme = CustomTheme,
        disabled_filetypes = { 'dirbuf', 'ministarter' },
        section_separators = '',
        component_separators = '',
        globalstatus = true
    },
    sections = {
        lualine_a = { 'fileformat', CustomMode },
        lualine_b = {
            'branch',
            'diff',
            {
                'diagnostics',
                sources = { 'nvim_diagnostic', 'nvim_lsp' },
                sections = { 'error', 'warn', 'info', 'hint' },
                symbols = { error = 'E~', warn = 'W~', info = 'I~', hint = 'H~' },
                update_in_insert = true,
                colored = false
            }
        },
        lualine_c = {
            '%=',
            {
                'filename',
                path = 1,
            },
        },
        lualine_x = { 'encoding', 'filetype' },
        lualine_y = { 'location' },
        lualine_z = {},
    },
    tabline = {
        lualine_a = {
            {
                'buffers',
                symbols = {
                    modified = ' +',  -- Text to show when the file is modified
                    alternate_file = '', -- Text to show to identify the alternate file
                },
            },
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {
            {
                'tabs',
                symbols = {
                    modified = ' +',  -- Text to show when the file is modified
                    alternate_file = '', -- Text to show to identify the alternate file
                },
            }
        },
    },
}
---

-- rasmus colorscheme configuration
vim.g.rasmus_italic_comments = false
vim.g.rasmus_transparent = true
vim.api.nvim_exec('colorscheme rasmus', false)

vim.api.nvim_set_hl(0, "ErrorMsg", {
    fg = "#FF7070",
    underline = true,
})

vim.api.nvim_set_hl(0, 'hl-LspReferenceText', {})
vim.api.nvim_set_hl(0, 'hl-LspReferenceText', {})
vim.api.nvim_set_hl(0, 'hl-LspReferenceRead', {})
vim.api.nvim_set_hl(0, 'hl-LspReferenceWrite', {})
vim.api.nvim_set_hl(0, 'LspSignatureActiveParameter', { underline = true })

vim.api.nvim_set_hl(0, "MiniTablineModifiedCurrent", {
    italic = true,
})

vim.api.nvim_set_hl(0, "MiniTablineModifiedVisible", {
    italic = true,
})

vim.api.nvim_set_hl(0, "MiniTablineModifiedHidden", {
    italic = true,
})
--


-- LSP config

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>d', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<leader>f', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- I just want my colorscheme to look the way it was intended
        --local bufnr = ev.buf
        --local client = vim.lsp.get_client_by_id(ev.data.client_id)
        --client.server_capabilities.semanticTokensProvider = nil

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)

        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)

        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})

vim.diagnostic.config({
    virtual_text = true,
    update_in_insert = true,
    signs = true,
    float = {
        border = "solid",
    },
})

vim.api.nvim_create_autocmd('CursorHold', {
    pattern = '*',
    callback = function()
        vim.diagnostic.open_float(0, {
            scope = "cursor",
            focus = false,
        })
    end
})

require('snippy').setup({
    mappings = {
        is = {
            ['<Tab>'] = 'expand_or_advance',
            ['<S-Tab>'] = 'previous',
        },
    },
})


local cmp = require('cmp')

function toggleCmp()
    if cmp.visible() then
        cmp.close()
    else
        cmp.complete()
    end
end

require('cmp').setup {
    mapping = cmp.mapping.preset.insert({
        ['<C-t>'] = toggleCmp,
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    snippet = {
        expand = function(args)
            require('snippy').expand_snippet(args.body)
        end
    },
    sources = {
        {
            name = "nvim_lsp",
        },
        {
            name = 'snippy',
        },
        {
            name = "buffer",
        },
        {
            name = "path",
        },
    }
}

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
require('cmp').setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        {
            name = 'buffer',
        },
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
require('cmp').setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        {
            name = 'path',
        },
        {
            name = 'cmdline',
        },
    }
})

-- Lspconfig capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')

lspconfig['typst_lsp'].setup{
    settings = {
        exportPdf = "onSave",
    },
}

lspconfig['ccls'].setup {
    capabilities = capabilities,
    init_options = {
        cache = {
            directory = "/tmp/ccls-cache",
        },
    },
}

lspconfig['gopls'].setup{
    capabilities = capabilities,
    settings = {
        gopls = {
            experimentalPostfixCompletions = true,
            analyses = {
                unusedparams = true,
                shadow = true,
            },
            staticcheck = true,
        },
    },
    init_options = {
        usePlaceholders = true,
    },
}


lspconfig['ts_ls'].setup {
    capabilities = capabilities,
}

lspconfig['svelte'].setup {
    capabilities = capabilities,
}

lspconfig['cssls'].setup {
    capabilities = capabilities,
}

lspconfig['arduino_language_server'].setup{
    capabilities = capabilities,
}

lspconfig['zls'].setup{
    capabilities = capabilities,
}

