set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'L9'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-speeddating'
Plugin 'jceb/vim-orgmode'
Bundle 'lepture/vim-jinja'
Plugin 'ledger/vim-ledger'
Plugin 'othree/html5.vim'
Plugin 'digitaltoad/vim-pug'
Plugin 'vim-scripts/vim-stylus'
""" snipmate plugins
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
""" pyflakes
Plugin 'alfredodeza/khuno.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" === Config ===

" the only sane tab config
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

" use X clipboard
set clipboard=unnamedplus

" hack to get no bell
set t_vb=
set visualbell

" --Syntax--
syntax enable
" most of the time we are editing HTML k
au BufNewFile,BufRead *.html,*.htm,*.shtml,*.stm set filetype=jinja
au BufRead,BufNewFile *.svg set filetype=xml
au BufNewFile,BufRead *.ldg,*.ledger setf ledger | comp ledger

" --Remapping keys--
" remap <esc> key with `jk` combination
ino jk <esc>
cno jk <c-c>
" remap colon with semicolon
no ; :

" make j and k behave sanely on wrapped lines
nmap j gj
nmap k gk

" make 80th column stand out
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" solarized theme
let g:solarized_termcolors=16
set t_Co=16
set background=dark
colorscheme solarized


" highlight matches and blink when jumping between matches
" This rewires n and N to do the highlighing...
nnoremap <silent> n   n:call HLNext(0.4)<cr>
nnoremap <silent> N   N:call HLNext(0.4)<cr>

" toggle highlighting all matches
nnoremap <silent> <Space> :set hlsearch! hlsearch?<cr>
highlight Search ctermfg=magenta

" highlight the match in red...
highlight WhiteOnRed  ctermfg=yellow
function! HLNext (blinktime)
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#\%('.@/.'\)'
    let ring = matchadd('WhiteOnRed', target_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    call matchdelete(ring)
    redraw
endfunction

" make trailing whitespace visible but not too obtrusive
exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
exec "set listchars=trail:\uB7,nbsp:~"
set list

" swap v and Ctrl-V; Block mode is more useful than Visual mode
nnoremap    v   <C-V>
nnoremap <C-V>     v

vnoremap    v   <C-V>
vnoremap <C-V>     v

let @r = '^cwyolo'
" execute macro over visual range
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction


" syntax highlighting for diffs
"
" EITHER select by the file-suffix directly...
augroup PatchDiffHighlight
    autocmd!
    autocmd BufEnter  *.patch,*.rej,*.diff   syntax enable
augroup END

" OR ELSE use the filetype mechanism to select automatically...
filetype on
augroup PatchDiffHighlight
    autocmd!
    autocmd FileType  diff   syntax enable
augroup END


" open file with .swp already existing as readonly
augroup NoSimultaneousEdits
    autocmd!
    autocmd SwapExists * let v:swapchoice = 'o'
    autocmd SwapExists * echo 'Duplicate edit session (readonly)'
    autocmd SwapExists * echohl None
    autocmd SwapExists * sleep 2
augroup END
