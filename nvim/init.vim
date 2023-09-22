set number
set relativenumber

set autoindent
set expandtab

set shiftwidth=4
set tabstop=4
set softtabstop=4

set backspace=2
set clipboard+=unnamedplus

set hidden
set mouse=a
set keymodel=startsel

" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence
set encoding=utf-8

" set to not generate backups to prevent problems
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

set guicursor=i:block
" I use a vertical bar cursor in my terminal as default
" au VimLeave * set guicursor=a:ver100

call plug#begin()

"Plug 'rafi/awesome-vim-colorschemes' "interesting colorschemes
"Plug 'tribela/vim-transparent' "transparent bg
"Plug 'preservim/nerdtree' "File tree plugin
Plug 'lewis6991/impatient.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'} "coc Completion

Plug 'echasnovski/mini.starter'

Plug 'mg979/vim-visual-multi' "multiple cursors
Plug 'sainnhe/gruvbox-material' "nice gruvbox material theme
Plug 'ap/vim-css-color' "CSS Color Preview
Plug 'nvim-tree/nvim-web-devicons' "pretty icons

Plug 'lambdalisue/suda.vim' "sudo
Plug 'jiangmiao/auto-pairs' "autoclosing for {[()]} etc
Plug 'pandadiestro/nvim-markdown-preview'
Plug 'chaoren/vim-wordmotion'

Plug 'nvim-lualine/lualine.nvim' "faster statusline

call plug#end()

lua require('impatient')

inoremap <silent> <C-Z> <C-O>u
xnoremap <silent> <Tab> >gv
xnoremap <silent> <S-Tab> <gv

xnoremap <BS> x

nmap <silent> <C-o> :bp <CR>
nmap <silent> <C-p> :bn <CR>

noremap <C-Right> e
inoremap <C-Right> <C-o>e<C-o>l

imap <silent>   <C-BS>    <C-w>
imap <silent>   <C-Del>   <C-o>dw

let g:nvim_markdown_preview_format = 'markdown'
let g:coc_disable_startup_warning = 1
let g:netrw_liststyle = 0
let g:netrw_fastbrowse = 0
let g:netrw_altfile = 0
let g:netrw_banner = 0

autocmd FileType netrw setl bufhidden=delete

nnoremap <silent> <M-w> :bw<CR>
nnoremap <silent> <C-t> :Ex<CR>

"--------devicons---------------
lua << END
require('nvim-web-devicons').setup{
    color_icons = false;
}
END


"---------some useful stuff-----------------
command JSONpretty %!jq .
command Words !wc -w %


"------ gruvbox colorscheme ---------
if has('termguicolors')
  set termguicolors
endif

let g:gruvbox_material_foreground='mix'
let g:gruvbox_material_disable_italic_comment=1
let g:gruvbox_material_transparent_background=1
let g:gruvbox_material_better_performance=1
let g:gruvbox_material_current_word='bold'

colorscheme gruvbox-material

" ----- move lines -----------
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

"NOTE: multiline movement support, thanks LunarVim
vnoremap <silent><C-S-Up> :m '<-2<CR>gv=gv
vnoremap <silent><C-S-Down> :m '>+1<CR>gv=gv

" --------- duplicate lines in normal mode ------------
nmap <C-D> :t.<CR>

" ------------ texlab config -------
hi default CocUnderline cterm=underline gui=undercurl

" --------startup config--------------
lua << END
require('mini.starter').setup{
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
END
" ---------lualine config-----------
lua << END
vim.fn.matchadd('errorMsg', [[\s\+$]])

require('lualine').setup{
    options = {
        disabled_filetypes = { 'nerdtree', 'vim-plug', 'netrw', 'starter' },
        theme = 'auto',
        section_separators = '',
        component_separators = '',
    },
    sections = {
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
END

" NOTE: stolen config hehe
" ---------- coc settings ---------
let g:coc_node_path = "/home/bauer/.nvm/versions/node/v18.15.0/bin/node"

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-y> and <C-b> to scroll flot windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-y> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-y>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-y> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-y> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-y>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>a

