vim.loader.enable()

--
local disabled_built_ins = {
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

vim.opt.shadafile = "NONE"
vim.o.lazyredraw = true

vim.o.termguicolors = true
vim.o.number = true
vim.o.relativenumber = true

vim.o.smartindent = true
vim.o.expandtab = true

vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4

vim.o.backspace = "2"
vim.o.clipboard = "unnamed,unnamedplus"

vim.o.hidden = true
vim.o.mouse = "a"
vim.o.keymodel = "startsel"

vim.o.linebreak = true


-- May need for Vim (not Neovim) since coc.nvim
-- calculates byte offset by count utf-8 byte sequence
vim.o.encoding = "utf-8"

-- set to not generate backups to prevent problems
vim.o.backup = false
vim.o.writebackup = false

-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
-- delays and poor user experience
vim.o.updatetime = 400

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved
vim.o.signcolumn = "yes"
vim.o.guicursor = "i:block"

-- Some important global variables
vim.g.mapleader = ' '

vim.g['nvim_markdown_preview_format'] = 'markdown'
vim.g['netrw_liststyle'] = 0
vim.g['netrw_fastbrowse'] = 0
vim.g['netrw_altfile'] = 0
vim.g['netrw_banner'] = 0

vim.api.nvim_create_autocmd("FileType", {
    pattern = 'netrw',
    callback = function()
        vim.opt_local.bufhidden = 'delete'
    end
})
--

local globalopts = {noremap = true, silent = true}

-- Basic mappings
vim.keymap.set("i", "<C-Right>", "<C-o>e<C-o>a", globalopts)
vim.keymap.set("n", "<C-Right>", "e", globalopts)
vim.keymap.set("x", "<C-Right>", "e", globalopts)

vim.keymap.set("i", "<C-S-Right>", "<C-o>ve", globalopts)
vim.keymap.set("n", "<C-S-Right>", "ve", globalopts)
vim.keymap.set("x", "<C-S-Right>", "e", globalopts)

vim.keymap.set("i", "<C-Left>", "<C-o>b", globalopts)
vim.keymap.set("n", "<C-Left>", "b", globalopts)
vim.keymap.set("x", "<C-Left>", "b", globalopts)

vim.keymap.set("i", "<C-z>", "<C-o>u", globalopts)
vim.keymap.set("i", "<C-y>", "<C-o><C-r>", globalopts)

vim.keymap.set("x", "<Tab>", ">gv", globalopts)
vim.keymap.set("x", "<S-Tab>", "<gv", globalopts)
vim.keymap.set("x", "<BS>", "x", globalopts)
vim.keymap.set("n", "<C-o>", ":bp<CR>", globalopts)
vim.keymap.set("n", "<C-p>", ":bn<CR>", globalopts)
vim.keymap.set("n", "<M-w>", ":bw<CR>", globalopts)
vim.keymap.set("n", "<C-t>", ":Ex<CR>", globalopts)

vim.keymap.set("i", "<C-BS>", "<C-w>", globalopts)
vim.keymap.set("i", "<C-Del>", "<C-o>dw", globalopts)

vim.keymap.set("t", "<Esc>", "<C-\\><C-N>", globalopts)
--

-- Actually cool mappings
-- duplicate lines in normal mode
vim.keymap.set("n", "<C-d>", ":t.<CR>", globalopts)
--

-- Useful commands
vim.api.nvim_create_user_command('Words', '!wc -w "%"', { nargs = '?' })
vim.api.nvim_create_user_command('JSONpretty', '%!jq .', { nargs = '?' })
--

-- swap lines
-- multiline movement support thanks to LunarVim
vim.keymap.set("v", "<C-S-Up>", ":m '<-2<CR>gv=gv", globalopts)
vim.keymap.set("v", "<C-S-Down>", ":m '>+1<CR>gv=gv", globalopts)

local api = vim.api

function swap_lines(n1, n2)
    local line1 = api.nvim_buf_get_lines(0, n1 - 1, n1, false)[1]
    local line2 = api.nvim_buf_get_lines(0, n2 - 1, n2, false)[1]
    api.nvim_buf_set_lines(0, n1 - 1, n1, false, { line2 })
    api.nvim_buf_set_lines(0, n2 - 1, n2, false, { line1 })
end

function swap_up()
    local n = api.nvim_win_get_cursor(0)[1]
    if n == 1 then
        return
    end

    swap_lines(n, n - 1)
    api.nvim_win_set_cursor(0, { n - 1, 0 })
end

function swap_down()
    local n = api.nvim_win_get_cursor(0)[1]
    local last_line = api.nvim_buf_line_count(0)
    if n == last_line then
        return
    end

    swap_lines(n, n + 1)
    api.nvim_win_set_cursor(0, { n + 1, 0 })
end

vim.keymap.set("n", "<C-S-Up>", "<CMD>lua swap_up()<CR>", globalopts)
vim.keymap.set("n", "<C-S-Down>", "<CMD>lua swap_down()<CR>", globalopts)
--

-- Useful stuff
vim.fn.matchadd('ErrorMsg', [[\s\+$]]) -- detect trailing spaces
vim.api.nvim_set_hl(0, "CocUnderline", { cterm = {underline = true}})
--

require('paq') {
    'savq/paq-nvim',                            -- paq self management
    'tpope/vim-sensible',                       -- nice defaults

    'echasnovski/mini.starter',                 -- minimalist start screen

    'neovim/nvim-lspconfig',                    -- native lsp
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',
    'dcampos/nvim-snippy',
    'dcampos/cmp-snippy',

    'brenton-leighton/multiple-cursors.nvim',   -- multicursors, but lua

    'kvrohit/rasmus.nvim',                      -- minimalist lua theme
    'NvChad/nvim-colorizer.lua',                -- CSS color preview
    'nvim-tree/nvim-web-devicons',              -- pretty icons

    'lambdalisue/suda.vim',                     -- sudo without leaving regular session
    'm4xshen/autoclose.nvim',                   -- easier to configure autopairs
    'pandadiestro/nvim-markdown-preview',       -- my fork of the in-browser markdown preview plugin
    'chaoren/vim-wordmotion',                   -- better word motion for programming

    'nvim-lualine/lualine.nvim',                -- faster statusline
    'echasnovski/mini.tabline',                 -- mini tab/buffer line
}

require('multiple-cursors').setup {  }
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

require('mini.tabline').setup()

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
⠀  ⠀   (\__/)
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
    items = { require('mini.starter').sections.builtin_actions() },
    query_updaters = '',
    footer = [[
"Talk is cheap. Show me the code."
                    -Torvalds]]
}

require('lualine').setup {
    options = {
        disabled_filetypes = { 'netrw', 'starter' },
        section_separators = '',
        component_separators = '',
        globalstatus = true
    },
    sections = {
        lualine_a = { 'mode' },
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
        lualine_c = { '%=' , 'filename'},
        lualine_y = {}
    },
}


-- rasmus configuration
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
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

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
    virtual_text = false,
    update_in_insert = true,
    signs = true,
    float = { border = "single" },
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

lspconfig['ccls'].setup {
    capabilities = capabilities,
    init_options = {
        compilationDatabaseDirectory = "build",
        index = {
            threads = 0;
        },
        clang = {
            excludeArgs = { "-frounding-math" },
        },
        cache = {
            directory = '/tmp/ccls',
        },
    },
}

lspconfig['gopls'].setup {
    cmd = {'gopls'},
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

lspconfig['tsserver'].setup {}




