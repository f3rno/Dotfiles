" {{{ vim-plug init

call plug#begin('~/.vim/plugins-vim')

" {{{ script libraries

Plug 'google/vim-maktaba'

" }}}
" {{{ defx

if has('nvim')
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/defx.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'kristijanhusak/defx-git'
Plug 'kristijanhusak/defx-icons'

" }}}
" {{{ lightline

Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'taohexxx/lightline-buffer'
Plug 'sainnhe/lightline_foobar.vim'
Plug 'josa42/vim-lightline-coc'

" }}}
" {{{ fzf

Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'zackhsi/fzf-tags'

" }}}
" {{{ better search (easymotion)

Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'haya14busa/incsearch-easymotion.vim'

" }}}
" {{{ syntax/languages

Plug 'dag/vim-fish'
Plug 'fatih/vim-go'
Plug 'vim-ruby/vim-ruby'
Plug 'mustache/vim-mustache-handlebars'
Plug 'gabrielelana/vim-markdown'
Plug 'hail2u/vim-css3-syntax'
Plug 'mboughaba/i3config.vim'
Plug 'smancill/conky-syntax.vim'
Plug 'sheerun/vim-yardoc'
Plug 'moll/vim-node'

" {{{ javascript

Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'othree/es.next.syntax.vim'

" }}}

" }}}
" {{{ snippets

Plug 'honza/vim-snippets'
Plug 'jordwalke/vimjsdocsnippets'
Plug 'sirver/UltiSnips'

" }}}
" {{{ git integration

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'rhysd/committia.vim' " better git commit layout
Plug 'int3/vim-extradite' " git log

" }}}

Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'dense-analysis/ale'
Plug 'pechorin/any-jump.vim'
Plug 'jlanzarotta/bufexplorer'
Plug 'tpope/vim-repeat' " . repeat for plugins
Plug 'mhinz/vim-startify'
Plug 'liuchengxu/vim-which-key'
Plug 'vimwiki/vimwiki'
Plug 'thaerkh/vim-workspace'
Plug 'vim-scripts/ZoomWin'
Plug 'janko/vim-test'
Plug 'tpope/vim-unimpaired'
Plug 'junegunn/goyo.vim'
Plug 'markonm/traces.vim' " live search/sub preview
Plug 'schickling/vim-bufonly'
Plug 'tpope/vim-commentary' " fast commenting
Plug 'Raimondi/delimitMate' " quote/etc autocomplete
Plug 'AndrewRadev/dsf.vim' " delete surrounding function call
Plug 'Shougo/echodoc.vim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'wincent/terminus' " enhanced terminal integration
Plug 'ternjs/tern_for_vim', { 'do': 'npm i' }
Plug 'ntpeters/vim-better-whitespace'
Plug 'ryanoasis/vim-devicons'
Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] }
Plug 'ludovicchabant/vim-gutentags' " auto tag regen
Plug 'michaeljsmith/vim-indent-object' " indent-level text object
Plug 'gcmt/wildfire.vim' " select text objects
Plug 'mtth/scratch.vim'
Plug 'rhysd/clever-split.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'yuttie/comfortable-motion.vim' " smooth scrolling
Plug 'unblevable/quick-scope' " f jump highlights
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

" {{{ colorschemes

" {{{ light

Plug 'reedes/vim-colors-pencil'
Plug 'mikker/lightline-theme-pencil'
Plug 'aonemd/kuroi.vim'
Plug 'swalladge/paper.vim'
Plug 'vim-scripts/summerfruit256.vim'

" }}}
" {{{ dark

Plug 'ayu-theme/ayu-vim'
Plug 'haishanh/night-owl.vim'
Plug 'toupeira/vim-desertink'
Plug 'fcpg/vim-farout'
Plug 'fcpg/vim-fahrenheit'

" }}}
" {{{ dual/multiple

Plug 'chriskempson/base16-vim'
Plug 'sainnhe/gruvbox-material'
Plug 'sonph/onehalf', { 'rtp': 'vim/' }
Plug 'NLKNguyen/papercolor-theme'
Plug 'rakr/vim-one'

" }}}

" }}}

call plug#end()

" }}}
" {{{ function Random()

" from https://github.com/posva/Rndm
let g:rndm_m1 = 32007779 + (localtime()%100 - 50)
let g:rndm_m2 = 23717810 + (localtime()/86400)%100
let g:rndm_m3 = 52636370 + (localtime()/3600)%100

function! Random()
  let m4= g:rndm_m1 + g:rndm_m2 + g:rndm_m3
  if( g:rndm_m2 < 50000000 )
    let m4= m4 + 1357
  endif
  if( m4 >= 100000000 )
    let m4= m4 - 100000000
    if( m4 >= 100000000 )
      let m4= m4 - 100000000
    endif
  endif
  let g:rndm_m1 = g:rndm_m2
  let g:rndm_m2 = g:rndm_m3
  let g:rndm_m3 = m4
  return g:rndm_m3
endfunction

" }}}
" {{{ indent

set tabstop=2
set softtabstop=2
set expandtab
set shiftwidth=2

" }}}
" {{{ colors & colorschemes
" {{{ 256 colors

set t_Co=256

if (has("termguicolors"))
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" }}}
" {{{ COLORSCHEME ayu

" let ayucolor='light'
" let ayucolor='mirage'
let ayucolor='dark'

" }}}
" {{{ COLORSCHEME gruvbox

let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_improved_strings = 1
let g:gruvbox_improved_warnings = 1

" }}}
" {{{ COLORSCHEME gruvbox_material

let g:gruvbox_material_background = 'hard'

" }}}
" {{{ COLORSCHEME solarized

let g:solarized_contrast = 'high'

" }}}
" {{{ COLORSCHEME sierra

let g:sierra_Twilight = 1

" }}}
" {{{ colorscheme

set background=dark
syntax enable
colorscheme fahrenheit

let g:lightline = {}
let g:lightline.colorscheme = 'one'

" {{{ dark colorschemes
let g:colorset_dark = ['farout',
                     \ 'ayu',
                     \ 'gruvbox-material',
                     \ 'desertink',
                     \ 'fahrenheit'
                     \ 'night-owl',
		                 \ ]

let g:lightline_colorset_dark_mappings = {
  \   'apprentice': 'ayu',
  \   'Tomorrow-Night-Bright': 'ayu',
  \   'desertink': 'desertink',
  \   'ayu': 'ayu',
  \ }
" }}}
" {{{ light colorschemes
let g:colorset_light = ['paper',
                      \ 'PaperColor',
                      \ 'onehalflight',
                      \ 'summerfruit256',
                      \ 'one',
                      \ 'kuroi',
                      \ ]

let g:lightline_colorset_light_mappings = {
  \   'paper': 'pencil',
  \   'PaperColor': 'PaperColor_light',
  \   'kuroi': 'pencil',
  \   'gruvbox-material': 'gruvbox_material',
  \   'summerfruit256': 'pencil',
  \   'onehalflight': 'onehalflight',
  \   'one': 'one',
  \ }
" }}}

" }}}
" }}}
" {{{ basic settings

filetype plugin on
filetype indent on

set timeout           " for mappings
set timeoutlen=300    " default value
set ttimeout          " for key codes
set ttimeoutlen=10    " unnoticeable small value

set shell=/usr/bin/fish
set number
set splitbelow
set showmatch
set incsearch
set hlsearch
set colorcolumn=80
set cmdheight=2
set signcolumn=yes
set foldmethod=marker
set tags=./tags;,tags;$HOME;
set regexpengine=1
set backspace=indent,eol,start
set autoread
set noshowmode " lightline renders mode already
set showtabline=2
set shortmess-=S
set foldcolumn=2
set laststatus=2
set showcmd

augroup editing
  au!
  au InsertLeave * set nopaste
  au BufEnter * set number
  au BufLeave * set nonumber
augroup END

" hacky fix for syntax highlighting in large files
autocmd WinEnter,Filetype * syntax sync fromstart

aug i3config_ft_detection
  au!
  au BufNewFile,BufRead ~/.config/i3/config set filetype=i3config
aug end

" disable cursorline in insert mode
autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline

" autosave
autocmd InsertLeave,TextChanged * update

" }}}
" {{{ backups

set noswapfile
set nobackup
set nowritebackup

" }}}
" {{{ plugins
" {{{ PLUGIN: ale

let g:ale_enabled = 1

let g:ale_linters = { 'ruby': ['rubocop'] }
let g:ale_fixers = { 'javascript': ['standard', 'eslint'] }
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
let g:ale_set_highlights = 1
let g:ale_set_signs = 1
let g:ale_sign_highlight_linenrs = 1
let g:ale_virtualtext_cursor = 1
let g:ale_open_list = 0

" }}}
" {{{ PLUGIN: any-jump

let g:any_jump_search_prefered_engine = 'ag'
let g:any_jump_references_only_for_current_filetype = 1
let g:any_jump_disable_default_keybindings = 1

" }}}
" {{{ PLUGIN: coc

" Taken from docs
"
" Map <tab> for trigger completion, completion confirm, snippet expand and jump
" like VSCode.

inoremap <silent><expr> <TAB>
  \ pumvisible() ? coc#_select_confirm() :
  \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Taken from docs, statusline diagnostics
function! COCStatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
endfunction

" Taken from docs, trigger copletion
inoremap <silent><expr> <c-space> coc#refresh()

let g:coc_node_path = '/home/f3rno/.config/nvm/13.11.0/bin/node'
let g:coc_node_args = ['--max-old-space-size=16384']

" }}}
" {{{ PLUGIN: echodoc

let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'virtual'

" }}}
" {{{ PLUGIN: fzf

set rtp+=/usr/bin/fzf

let g:fzf_command_prefix = 'FZF'
let g:fzf_buffers_jump = 1
let g:fzf_tags_command = 'ctags -R'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

command! -bang -nargs=? -complete=dir FZFFilesWithNativePreview
    \ call fzf#vim#files(<q-args>, {
    \  'options': [
    \    '--reverse',
    \    '--info=inline',
    \    '--preview',
    \    '~/.vim/plugged/fzf.vim/bin/preview.sh {}'
    \  ]}, <bang>0)

" }}}
" {{{ PLUGIN: goyo

let g:goyo_height = '80%'
let g:goyo_width = '60%'

function! s:goyo_enter()
  set noshowmode
  set noshowcmd
  set nonumber
endfunction

function! s:goyo_leave()
  set showmode
  set showcmd
  set number
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" }}}
" {{{ PLUGIN: lightline

" colorscheme defined in colorscheme config section

function! LightlineReadonly()
  return &readonly ? '' : ''
endfunction

function! LightlineFugitive()
  if exists('*FugitiveHead')
    let branch = FugitiveHead()
    return branch !=# '' ? ''.branch : ''
  endif
  return ''
endfunction

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

let g:lightline.active = {}
let g:lightline.active.left = [
  \ [ 'mode', 'paste', 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok'],
  \ [ 'gitbranch', 'readonly', 'modified' ],
  \ [ 'filename', 'gutentagsstatus'],
  \ ]

let g:lightline.active.right = [
  \ [ 'percent', 'lineinfo' ],
  \ [ 'filetype' ],
  \ [ 'coc_status' ],
  \ ]

let g:lightline.component_function = {
  \ 'gitbranch': 'LightlineFugitive',
  \ 'readonly': 'LightlineReadonly',
  \ 'gutentagsstatus': 'gutentags#statusline',
  \ 'bufferinfo': 'lightline#buffer#bufferinfo',
  \ 'filename': 'LightlineFilename',
  \ }

let g:lightline.component_expand = {
  \ 'linter_checking': 'lightline#ale#checking',
  \ 'linter_infos': 'lightline#ale#infos',
  \ 'linter_warnings': 'lightline#ale#warnings',
  \ 'linter_errors': 'lightline#ale#errors',
  \ 'linter_ok': 'lightline#ale#ok',
  \
  \ 'buffercurrent': 'lightline#buffer#buffercurrent',
  \ 'bufferbefore': 'lightline#buffer#bufferbefore',
  \ 'bufferafter': 'lightline#buffer#bufferafter',
  \ }

let g:lightline.component_type = {
  \ 'linter_checking': 'right',
  \ 'linter_infos': 'right',
  \ 'linter_warnings': 'warning',
  \ 'linter_errors': 'error',
  \ 'linter_ok': 'right',
  \
  \ 'buffercurrent': 'tabsel',
  \ 'bufferbefore': 'raw',
  \ 'bufferafter': 'raw',
  \ }

let g:lightline.mode_map = {
  \ 'n' : 'N',
  \ 'i' : 'I',
  \ 'R' : 'R',
  \ 'v' : 'V',
  \ 'V' : 'V-L',
  \ "\<C-v>": 'V-B',
  \ 'c' : 'C',
  \ 's' : 'S',
  \ 'S' : 'S-L',
  \ "\<C-s>": 'S-B',
  \ 't': 'T',
  \ }

let g:lightline#ale#indicator_checking = "\uf110 "
let g:lightline#ale#indicator_infos = "\uf129 "
let g:lightline#ale#indicator_warnings = "\uf071 "
let g:lightline#ale#indicator_errors = "\uf05e "
let g:lightline#ale#indicator_ok = "\uf00c "

let g:lightline.tabline = {
    \ 'left': [ [ 'bufferinfo' ],
    \           [ 'separator' ],
    \           [ 'bufferbefore', 'buffercurrent', 'bufferafter' ], ],
    \ 'right': [ [ 'close' ], ],
    \ }

let g:lightline_buffer_enable_devicons = 1
let g:lightline_buffer_show_bufnr = 1

autocmd User CocStatusChange,CocDiagnosticChange,GutentagsUpdating,GutentagsUpdated call lightline#update()

" }}}
" {{{ PLUGIN: rainbow-parantheses

let g:rainbow_active = 1

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" }}}
" {{{ PLUGIN: ultisnips

let g:UltiSnipsExpandTrigger = "<c-j>"
let g:ultisnips_javascript = { 'semi': 'never' }

" }}}
" {{{ PLUGIN: vim-better-whitespace

let g:better_whitespace_enabled = 1

" }}}
" {{{ PLUGIN: vim-grepper

let g:grepper = {}
let g:grepper.tools = ['ag']
let g:grepper.highlight = 1
let g:grepper.quickfix = 1
let g:grepper.open = 1
let g:grepper.switch = 1
let g:grepper.dir = 'repo,file'
let g:grepper.ag = {
  \ 'grepprg': 'ag --ignore-dir=node_modules --ignore-dir=bower_components --ignore-dir=dist --ignore-dir=build'
  \ }

" }}}
" {{{ PLUGIN: vim-gutentags

let g:gutentags_ctags_exclude = ['coverage/*', 'node_modules/*', '*%*', 'docs/*']
let g:gutentags_enabled = 1

" }}}
" {{{ PLUGIN: vim-highlightedyank

let g:highlightedyank_highlight_duration = 300

" }}}
" {{{ PLUGIN: vim-javascript

let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1

" }}}
" {{{ PLUGIN: javascript-libraries-syntax

let g:used_javascript_libs = 'underscore,react,chai'

" }}}
" {{{ PLUGIN: vim-jsx-pretty

let g:vim_jsx_pretty_colorful_config = 1

" }}}
" {{{ PLUGIN: vim-move

let g:move_key_modifier = 'C'

" }}}
" {{{ PLUGIN: vim-perpetuloc

nnoremap <leader>[ :Lnext<cr>
nnoremap <leader>] :Lprevious<cr>

" }}}
" {{{ PLUGIN: vim-ripgrep

let g:vim_search_pulse_mode = 'cursor_line'

" }}}
" {{{ PLUGIN: vim-test

let g:test#vim#term_position = "belowright"
let g:test#strategy = 'neovim'

" function! MochaDebugTransform(cmd) abort
"   return 'env DEBUG="*" '.a:cmd
" endfunction

" let g:test#custom_transformations = {'mocha': function('MochaDebugTransform')}
" let g:test#transformation = 'mocha'

" https://github.com/janko/vim-test/issues/272#issuecomment-515749091
let g:root_markers = ['package.json', '.git/']
function! s:RunVimTest(cmd)
    for marker in g:root_markers
        let marker_file = findfile(marker, expand('%:p:h') . ';')
        if strlen(marker_file) > 0
            let g:test#project_root = fnamemodify(marker_file, ":p:h")
            break
        endif
        let marker_dir = finddir(marker, expand('%:p:h') . ';')
        if strlen(marker_dir) > 0
            let g:test#project_root = fnamemodify(marker_dir, ":p:h")
            break
        endif
    endfor

    execute a:cmd
endfunction

" }}}
" {{{ PLUGIN: vim-which-key

let g:which_key_use_floating_win = 0

nnoremap <silent> <leader> :<c-u>WhichKey ','<CR>

" }}}
" {{{ PLUGIN: vimwiki

let g:vimwiki_folding = 'expr'

" }}}
" {{{ PLUGIN: vim-workspace

let g:workspace_create_new_tabs = 0
let g:workspace_autosave_untrailspaces = 0
let g:workspace_autosave = 0

" }}}

" }}}
" {{{ color switching

function! s:SwitchToLightColors(n)
  set background=light

  if a:n >= 0 && a:n < len(g:colorset_light)
    let n = a:n
  else
    let n = Random()%len(g:colorset_light)
 endif

  exec 'colorscheme ' . g:colorset_light[n]
  echo 'set light color scheme ' . g:colorset_light[n]

  if has_key(g:lightline_colorset_light_mappings, g:colorset_light[n])
    let g:lightline.colorscheme = g:lightline_colorset_light_mappings[g:colorset_light[n]]

    call lightline#init()
    call lightline#colorscheme()
    call lightline#update()
  endif
endfunction

function! s:SwitchToDarkColors(n)
  set background=dark

  if a:n >= 0 && a:n < len(g:colorset_dark)
    let n = a:n
  else
    let n = Random()%len(g:colorset_dark)
  endif

  exec 'colorscheme ' . g:colorset_dark[n]
  echo 'set light color scheme ' . g:colorset_dark[n]

  if has_key(g:lightline_colorset_dark_mappings, g:colorset_dark[n])
    let g:lightline.colorscheme = g:lightline_colorset_dark_mappings[g:colorset_dark[n]]

    call lightline#init()
    call lightline#colorscheme()
    call lightline#update()
  endif
endfunction

" }}}
" {{{ keybindings

let mapleader = ','

" {{{ vim-which-key start

" dictionary
let g:which_key_map =  {}

" }}}

" {{{ ale

nmap <silent> <leader>aj :ALENext<cr>
nmap <silent> <leader>ak :ALEPrevious<cr>

" }}}
" {{{ any-jump

nnoremap <leader>J :AnyJump<CR>
xnoremap <leader>J :AnyJumpVisual<CR>

" }}}
" {{{ buffer control

" navigation
nnoremap <leader>n :bnext<CR>
nnoremap <leader>p :bprev<CR>
nnoremap <c-q> :bd<CR>

nmap <leader>1 <Plug>BufTabLine.Go(1)
nmap <leader>2 <Plug>BufTabLine.Go(2)
nmap <leader>3 <Plug>BufTabLine.Go(3)
nmap <leader>4 <Plug>BufTabLine.Go(4)
nmap <leader>5 <Plug>BufTabLine.Go(5)
nmap <leader>6 <Plug>BufTabLine.Go(6)
nmap <leader>7 <Plug>BufTabLine.Go(7)
nmap <leader>8 <Plug>BufTabLine.Go(8)
nmap <leader>9 <Plug>BufTabLine.Go(9)
nmap <leader>0 <Plug>BufTabLine.Go(10)

" cleanup
nnoremap <silent> <leader>bo :BufOnly<cr>

let g:which_key_map.b = { 'name': '+buffer control' }
let g:which_key_map.b.o = ['Bufonly', 'close other buffers']

" }}}
" {{{ ctrl+backspace delete word

noremap! <C-BS> <C-w>
noremap! <C-h> <C-w>

" }}}
" {{{ coc

nnoremap <silent> <leader>y  :<C-u>CocList -A --normal yank<cr>
let g:which_key_map.y = ['<C-u>CocList -A --normal yank<cr>', 'yank history']

nmap <leader>d :CocList diagnostics<cr>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <leader>j :call CocAction('diagnosticNext')<cr>
nnoremap <leader>k :call CocAction('diagnosticPrevious')<cr>

" }}}
" {{{ colorscheme switching

nnoremap <leader>Cl :call <SID>SwitchToLightColors(-1)<cr>
nnoremap <leader>C0l :call <SID>SwitchToLightColors(0)<cr>
nnoremap <leader>C1l :call <SID>SwitchToLightColors(1)<cr>
nnoremap <leader>C2l :call <SID>SwitchToLightColors(2)<cr>
nnoremap <leader>C3l :call <SID>SwitchToLightColors(3)<cr>
nnoremap <leader>C4l :call <SID>SwitchToLightColors(4)<cr>
nnoremap <leader>C5l :call <SID>SwitchToLightColors(5)<cr>
nnoremap <leader>C6l :call <SID>SwitchToLightColors(6)<cr>
nnoremap <leader>C7l :call <SID>SwitchToLightColors(7)<cr>
nnoremap <leader>C8l :call <SID>SwitchToLightColors(8)<cr>
nnoremap <leader>C9l :call <SID>SwitchToLightColors(9)<cr>

nnoremap <leader>Cd :call <SID>SwitchToDarkColors(-1)<cr>
nnoremap <leader>C0d :call <SID>SwitchToDarkColors(0)<cr>
nnoremap <leader>C1d :call <SID>SwitchToDarkColors(1)<cr>
nnoremap <leader>C2d :call <SID>SwitchToDarkColors(2)<cr>
nnoremap <leader>C3d :call <SID>SwitchToDarkColors(3)<cr>
nnoremap <leader>C4d :call <SID>SwitchToDarkColors(4)<cr>
nnoremap <leader>C5d :call <SID>SwitchToDarkColors(5)<cr>
nnoremap <leader>C6d :call <SID>SwitchToDarkColors(6)<cr>
nnoremap <leader>C7d :call <SID>SwitchToDarkColors(7)<cr>
nnoremap <leader>C8d :call <SID>SwitchToDarkColors(8)<cr>
nnoremap <leader>C9d :call <SID>SwitchToDarkColors(9)<cr>

nnoremap <leader>Cn :NextColorScheme<cr>
nnoremap <leader>Cp :PrevColorScheme<cr>
nnoremap <leader>CC :RandomColorScheme<cr>
nnoremap <leader>Cb :BlacklistAddColorScheme<cr>
nnoremap <leader>Cw :BlacklistRemColorScheme<cr>

" }}}
" {{{ defx

let g:defx_is_open = 0
let g:defx_target = ''

function! DefxDoToggle()
  let g:defx_buff_info_arr = getbufinfo('defx-0')

  if empty(g:defx_buff_info_arr)
    let g:defx_buff_windows = []
  else
    let g:defx_buff_windows = g:defx_buff_info_arr[0].windows
  endif

  if !empty(g:defx_buff_windows)
    call win_gotoid(g:defx_buff_windows[0])
  end

  if g:defx_is_open
    call defx#call_action('quit')
  else
    exec 'Defx'
  endif

  let g:defx_is_open = !g:defx_is_open
endfunction

function! DefxClose()
  let g:defx_is_open = 0
  call defx#call_action('quit')
endfunction

function! DefxOnOpenV()
  if defx#is_directory()
    call defx#call_action('open_or_close_tree')
  else
    let g:defx_target = defx#get_candidate()
    let g:defx_is_open = 0

    call defx#call_action('quit')
    exec 'e '.g:defx_target.action__path
  endif
endfunction

function! DefxOnOpenH()
  if defx#is_directory()
    call defx#call_action('open_or_close_tree')
  else
    let g:defx_target = defx#get_candidate()
    let g:defx_is_open = 0

    call defx#call_action('quit')
    exec 'sp '.g:defx_target.action__path
  endif
endfunction

function! DefxOnOpen()
  if defx#is_directory()
    call defx#call_action('open_or_close_tree')
  else
    call defx#call_action('drop')
  endif
endfunction

nnoremap <silent> <leader>e :call DefxDoToggle()<cr>

autocmd FileType defx call s:DefxRegisterKeybindings()
autocmd BufWritePost * call defx#redraw()

function! s:DefxRegisterKeybindings() abort
  nnoremap <silent><buffer> <cr> :call DefxOnOpen()<cr>
  nnoremap <silent><buffer>v :call DefxOnOpenV()<cr>
  nnoremap <silent><buffer>h :call DefxOnOpenH()<cr>
  nnoremap <silent><buffer><expr> m defx#do_action('move')
  nnoremap <silent><buffer><expr> r defx#do_action('rename')
  nnoremap <silent><buffer><expr> d defx#do_action('remove')
  nnoremap <silent><buffer><expr> D defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> F defx#do_action('new_file')
	nnoremap <silent><buffer><expr> y defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> u defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> s defx#do_action('search')
  nnoremap <silent> q :call DefxClose()<cr>
  nnoremap <silent> <esc> :call DefxClose()<cr>
endfunction

call defx#custom#option('_', {
	\ 'columns': 'indent:git:icon:icons:filename',
	\ 'winwidth': 40,
	\ 'split': 'vertical',
	\ 'direction': 'topleft',
	\ 'show_ignored_files': 0,
	\ 'root_marker': ':',
	\ 'buffer_name': 'defx',
	\ 'ignored_files':
	\     'node_modules,dist,build,package-lock.json,.git,.undodir,.github,.nyc_output,coverage,tags'
	\ })

call defx#custom#column('filename', {
      \ 'directory_icon': '▸',
      \ 'opened_icon': '▾',
      \ 'root_icon': ' ',
      \ 'min_width': '5',
      \ 'max_width': '40',
      \ 'root_marker_highlight': 'Ignore',
      \ })

" }}}
" {{{ easymotion

map in <Plug>(easymotion-next)
map iN <Plug>(easymotion-prev)

" }}}
" {{{ fast quit

nnoremap <silent> <leader>q :qa<cr>
nnoremap <silent> <leader>Q :q!<cr>

" }}}
" {{{ folds

nnoremap <expr> <leader>F &foldlevel ? 'zM' :'zR'
let g:which_key_map.F = ['&foldlevel ? "zM" : "zR"', 'toggle fold level']

nnoremap <silent> <leader><Space> @=(foldlevel('.')?'za':"\<Space>")<CR>

" }}}
" {{{ fzf

nnoremap <C-p> :FZFFilesWithNativePreview<cr>
nnoremap <leader>ZC :FZFCommands<cr>
nnoremap <leader>ZB :FZFBTags<cr>

" {{{ search open buffers
function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <Leader><Enter> :call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufopen'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2
\ })<CR>
" }}}
" {{{ search tags

function! s:tags_sink(line)
  let parts = split(a:line, '\t\zs')
  let excmd = matchstr(parts[2:], '^.*\ze;"\t')
  execute 'silent e' parts[1][:-2]
  let [magic, &magic] = [&magic, 0]
  execute excmd
  let &magic = magic
endfunction

function! s:tags()
  call fzf#run({
  \ 'source':  'cat '.join(map(tagfiles(), 'fnamemodify(v:val, ":S")')).
  \            '| grep -v -a ^!',
  \ 'options': '+m -d "\t" --with-nth 1,4.. -n 1 --tiebreak=index',
  \ 'down':    '40%',
  \ 'sink':    function('s:tags_sink')})
endfunction

command! Tags call s:tags()

" }}}

" }}}
" {{{ goto tag

nnoremap <leader>T :FZFTags<cr>
let g:which_key_map.T = ['FZFTags<cr>', 'goto tag']

" }}}
" {{{ goyo

nnoremap <silent> <leader>g :Goyo<cr>
let g:which_key_map.g = ['Goyo', 'toggle goyo']

" }}}
" {{{ grepper

nnoremap <silent> <leader>G :Grepper<cr>
nnoremap <silent> <leader>W :Grepper-cword<cr>

let g:which_key_map.G = ['Grepper', 'do grep']
let g:which_key_map.W = ['Grepper-cword', 'grep cursor word']

" }}}
" {{{ incsearch

" map /  <Plug>(incsearch-forward)
" map ?  <Plug>(incsearch-backward)
" map g/ <Plug>(incsearch-stay)
map i/ <Plug>(incsearch-easymotion-/)
map i? <Plug>(incsearch-easymotion-?)
map ig/ <Plug>(incsearch-easymotion-stay)
map z/ <Plug>(incsearch-fuzzy-/)
map z? <Plug>(incsearch-fuzzy-?)
map zg/ <Plug>(incsearch-fuzzy-stay)

" }}}
" {{{ quickhl

nmap <Space>m <Plug>(quickhl-manual-this)
xmap <Space>m <Plug>(quickhl-manual-this)
nmap <Space>M <Plug>(quickhl-manual-reset)
xmap <Space>M <Plug>(quickhl-manual-reset)

" }}}
" {{{ splits

nnoremap <up> :resize -1<cr>
nnoremap <down> :resize +1<cr>
nnoremap <left> :vert resize +1<cr>
nnoremap <right> :vert resize -1<cr>

nnoremap <leader>s :CleverSplit<cr>

" }}}
" {{{ tab zoom+nav

nnoremap <silent> <leader>zi :tab split<cr>
nnoremap <silent> <leader>zo :tab close<cr>
nnoremap <silent> <leader>N :tabnext<cr>
nnoremap <silent> <leader>P :tabprev<cr>

" }}}
" {{{ terminal splits

command! -nargs=* T split | terminal <args>
command! -nargs=* VT vsplit | terminal <args>

" }}}
" {{{ testing

nnoremap <leader>tf :call <SID>RunVimTest('TestFile')<cr>
nnoremap <leader>tn :call <SID>RunVimTest('TestNearest')<cr>
nnoremap <leader>ts :call <SID>RunVimTest('TestSuite')<cr>
nnoremap <leader>tl :call <SID>RunVimTest('TestLast')<cr>
" nnoremap <leader>tv :call <SID>RunVimTest('TestVisit')<cr>

let g:which_key_map.t = { 'name': '+testing' }
let g:which_key_map.t.f = ["<SID>RunVimTest('TestFile')<cr>", 'test file']
let g:which_key_map.t.n = ["<SID>RunVimTest('TestNearest')<cr>", 'test nearest']
let g:which_key_map.t.s = ["<SID>RunVimTest('TestSuite')<cr>", 'test suite']
let g:which_key_map.t.l = ["<SID>RunVimTest('TestLast')<cr>", 'test last']

" }}}
" {{{ vimjsdocsnippets

let g:JSDocSnippetsMapping='<leader>D'

" }}}
" {{{ vimrc

nnoremap <silent> <leader>R :source ~/.vimrc<cr>
let g:which_key_map.R = ['source ~/.vimrc', 'reload vimrc']

" }}}

" {{{ vim-which-key end

" register dictionary
call which_key#register(',', "g:which_key_map")

" }}}

" }}}
