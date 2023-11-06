vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cindent = true
vim.opt.expandtab = true

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

vim.opt.backspace = "2"
vim.opt.clipboard = "unnamed,unnamedplus"

vim.opt.hidden = true
vim.opt.mouse = "a"
vim.opt.keymodel = "startsel"

vim.api.nvim_set_hl(0, "CocUnderline", { cterm=underline })

-- May need for Vim (not Neovim) since coc.nvim
-- calculates byte offset by count utf-8 byte sequence

vim.opt.encoding = "utf-8"

-- set to not generate backups to prevent problems
vim.cmd("set nobackup")
vim.cmd("set nowritebackup")

-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
-- delays and poor user experience
vim.opt.updatetime = 300

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved

vim.opt.signcolumn = "yes"
vim.opt.guicursor = "i:block"

local globalopts = {noremap = true, silent = true}

-- Basic mappings
vim.keymap.set("i", "<C-Right>", "<C-o>e<C-o>a", globalopts)
vim.keymap.set("n", "<C-Right>", "e", globalopts)
vim.keymap.set("x", "<C-Right>", "e", globalopts)

vim.keymap.set("i", "<C-Left>", "<C-o>b", globalopts)
vim.keymap.set("n", "<C-Left>", "b", globalopts)
vim.keymap.set("x", "<C-Left>", "b", globalopts)

vim.keymap.set("i", "<C-z>", "<C-o>u", globalopts)
vim.keymap.set("i", "<C-y>", "<C-o><C-r>", globalopts)

vim.keymap.set("x", "<Tab>", ">gv", globalopts)
vim.keymap.set("x", "<S-Tab>", "<gv", globalopts)
vim.keymap.set("x", "<BS>", "x", globalopts)
vim.keymap.set("n", "<C-o>", ":bp <CR>", globalopts)
vim.keymap.set("n", "<C-p>", ":bn <CR>", globalopts)
vim.keymap.set("n", "<M-w>", ":bw<CR>", globalopts)
vim.keymap.set("n", "<C-t>", ":Ex<CR>", globalopts)

vim.keymap.set("i", "<C-BS>", "<C-w>", globalopts)
vim.keymap.set("i", "<C-Del>", "<C-o>dw", globalopts)
--

-- Actually cool mappings
-- duplicate lines in normal mode
vim.keymap.set("n", "<C-d>", ":t.<CR>", globalopts)
--

require "paq" {
    'savq/paq-nvim',                        -- paq self management
    'tpope/vim-sensible',                   -- nice defaults
    'lewis6991/impatient.nvim',             -- perf improvements for the impatient
    'neoclide/coc.nvim',                    -- coc Completion

    'echasnovski/mini.starter',             -- minimalist start screen

    'mg979/vim-visual-multi',               -- multiple cursors
    'sainnhe/gruvbox-material',             -- nice gruvbox material theme
    'norcalli/nvim-colorizer.lua',          -- CSS color preview
    'nvim-tree/nvim-web-devicons',          -- pretty icons

    'lambdalisue/suda.vim',                 -- sudo without leaving regular session
    'm4xshen/autoclose.nvim',               -- easier to configure autopairs
    'pandadiestro/nvim-markdown-preview',   -- my fork of the in-browser markdown preview plugin
    'chaoren/vim-wordmotion',               -- better word motion for programming

    'nvim-lualine/lualine.nvim',            -- faster statusline
}

-- Useful commands
vim.api.nvim_create_user_command('Words', '!wc -w %', { nargs='?' })
vim.api.nvim_create_user_command('JSONpretty', '%!jq .', { nargs='?' })
--

-- Some important global variables
vim.g.mapleader = ' '

vim.g['VM_set_statusline'] = 0
vim.g['VM_silent_exit'] = 1

vim.g['nvim_markdown_preview_format'] = 'markdown'

vim.g['coc_disable_startup_warning'] = 1

vim.g['netrw_liststyle'] = 0
vim.g['netrw_fastbrowse'] = 0
vim.g['netrw_altfile'] = 0
vim.g['netrw_banner'] = 0

vim.cmd('autocmd FileType netrw setl bufhidden=delete')
--

-- Useful stuff
vim.fn.matchadd('errorMsg', [[\s\+$]]) -- detect trailing spaces
--

require('impatient')

require('nvim-web-devicons').setup {
    color_icons = false;
}

require('colorizer').setup()

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
       (•ㅅ•)      Don’t talk to
    ＿ノヽ ノ＼＿      me or my son
`/　`/ ⌒Ｙ⌒ Ｙ  ヽ     ever again.
( 　(三ヽ人　 /　  |
|　ﾉ⌒＼ ￣￣ヽ   ノ
ヽ＿＿＿＞､＿_／
     ｜( 王 ﾉ〈 (\__/)
     /ﾐ`ー―彡\  (•ㅅ•)
    / ╰    ╯ \  /    \>]],
    query_updaters = '',
    footer = [[


"Talk is cheap. Show me the code."
                    -Torvalds]]
}

require('lualine').setup {
    options = {
        disabled_filetypes = { 'nerdtree', 'vim-plug', 'netrw', 'starter', 'fzf' },
        theme = 'auto',
        section_separators = '',
        component_separators = '',
    },
    sections = {
        lualine_a = {
            {
                'mode',
                fmt = function(mode)
                return vim.b['visual_multi'] and mode .. ' - MULTI' or mode
                end
            }
        },
        lualine_b = {
            'branch',
            'diff',
            {
                'diagnostics',
                sources = { 'nvim_diagnostic', 'coc' },
                sections = { 'error', 'warn', 'info', 'hint' },
                symbols = {error = 'E~', warn = 'W~', info = 'I~', hint = 'H~'},
                update_in_insert = true,
                colored = false
            }
        }
    },
    tabline = {
        lualine_a = {
            'buffers'
        }
    }
}

-- swap lines
-- multiline movement support thanks to LunarVim
vim.keymap.set("v", "<C-S-Up>", ":m '<-2<CR>gv=gv", globalopts)
vim.keymap.set("v", "<C-S-Down>", ":m '>+1<CR>gv=gv", globalopts)

function swap_up()
    local r, n = unpack(vim.api.nvim_win_get_cursor(0))
    if r == 1 then
        return
    else
        return ":m '>+1<CR>gv=gv"
    end
end

function swap_down()
    local r, n = unpack(vim.api.nvim_win_get_cursor(0))
    if r == 1 then
        return
    else
        return ":m '<-2<CR>gv=gv"
    end
end

-- the only remaining important part
-- of my old config without a proper
-- port in lua, TODO

vim.cmd([[
    function! s:swap_lines(n1, n2)
        let line1 = getline(a:n1)
        let line2 = getline(a:n2)
        call setline(a:n1, line2)
        call setline(a:n2, line1)
    endfunction

    function! s:swap_up()
        let n = line('.')
        if n == 1
            return
        endif

        call s:swap_lines(n, n - 1)
        exec n - 1
    endfunction

    function! s:swap_down()
        let n = line('.')
        if n == line('$')
            return
        endif

        call s:swap_lines(n, n + 1)
        exec n + 1
    endfunction

    noremap <silent> <c-s-up> :call <SID>swap_up()<CR>
    noremap <silent> <c-s-down> :call <SID>swap_down()<CR>
]])
--

-- gruvbox material variables
vim.g['gruvbox_material_foreground'] = 'mix'
vim.g['gruvbox_material_disable_italic_comment'] = 1
vim.g['gruvbox_material_transparent_background'] = 1
vim.g['gruvbox_material_better_performance'] = 1
vim.g['gruvbox_material_current_word'] = 'bold'

vim.cmd('colorscheme gruvbox-material')
--

-- Stolen coc config hehe
local keyset = vim.keymap.set
-- Autocomplete
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use Tab for trigger completion with characters ahead and navigate
-- NOTE: There's always a completion item selected by default, you may want to enable
-- no select by setting `"suggest.noselect": true` in your configuration file
-- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
-- other plugins before putting this into your config
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- Use <c-j> to trigger snippets
keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
-- Use <c-space> to trigger completion
keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

-- GoTo code navigation
keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})


-- Use K to show documentation in preview window
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})


-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})


-- Symbol renaming
keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})


-- Formatting selected code
keyset("x", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
keyset("n", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})


-- Setup formatexpr specified filetype(s)
vim.api.nvim_create_autocmd("FileType", {
    group = "CocGroup",
    pattern = "typescript,json",
    command = "setl formatexpr=CocAction('formatSelected')",
    desc = "Setup formatexpr specified filetype(s)."
})

-- Update signature help on jump placeholder
vim.api.nvim_create_autocmd("User", {
    group = "CocGroup",
    pattern = "CocJumpPlaceholder",
    command = "call CocActionAsync('showSignatureHelp')",
    desc = "Update signature help on jump placeholder"
})

-- Apply codeAction to the selected region
-- Example: `<leader>aap` for current paragraph
local opts = {silent = true, nowait = true}
keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)

-- Remap keys for apply code actions at the cursor position.
keyset("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", opts)
-- Remap keys for apply source code actions for current file.
keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
-- Apply the most preferred quickfix action on the current line.
keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)

-- Remap keys for apply refactor code actions.
keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

-- Run the Code Lens actions on the current line
keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)


-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server
keyset("x", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("o", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("x", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("o", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("x", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("o", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("x", "ac", "<Plug>(coc-classobj-a)", opts)
keyset("o", "ac", "<Plug>(coc-classobj-a)", opts)


-- Remap <C-f> and <C-b> to scroll float windows/popups
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true, expr = true}
keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
keyset("i", "<C-f>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
keyset("i", "<C-b>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)


-- Use CTRL-S for selections ranges
-- Requires 'textDocument/selectionRange' support of language server
keyset("n", "<C-s>", "<Plug>(coc-range-select)", {silent = true})
keyset("x", "<C-s>", "<Plug>(coc-range-select)", {silent = true})


-- Add `:Format` command to format current buffer
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

-- " Add `:Fold` command to fold current buffer
vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", {nargs = '?'})

-- Add `:OR` command for organize imports of the current buffer
vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

-- Add (Neo)Vim's native statusline support
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline
vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

-- Mappings for CoCList
-- code actions and coc stuff
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true}
-- Show all diagnostics
keyset("n", "<space>a", ":<C-u>CocList diagnostics<cr>", opts)
-- Manage extensions
keyset("n", "<space>e", ":<C-u>CocList extensions<cr>", opts)
-- Show commands
keyset("n", "<space>c", ":<C-u>CocList commands<cr>", opts)
-- Find symbol of current document
keyset("n", "<space>o", ":<C-u>CocList outline<cr>", opts)
-- Search workspace symbols
keyset("n", "<space>s", ":<C-u>CocList -I symbols<cr>", opts)
-- Do default action for next item
keyset("n", "<space>j", ":<C-u>CocNext<cr>", opts)
-- Do default action for previous item
keyset("n", "<space>k", ":<C-u>CocPrev<cr>", opts)
-- Resume latest coc list
keyset("n", "<space>p", ":<C-u>CocListResume<cr>", opts)
--







