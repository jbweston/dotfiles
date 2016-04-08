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
Plugin 'git://github.com/altercation/vim-colors-solarized.git'
Bundle 'lepture/vim-jinja'
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
au BufNewFile,BufRead *.html,*.htm,*.shtml,*.stm set ft=jinja 
au BufRead,BufNewFile *.svg        set filetype=xml

" --Remapping keys--
" remap <esc> key with `jk` combination
ino jk <esc>
cno jk <c-c>
" remap colon with semicolon
no ; :

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

" highlight the match in red...
highlight WhiteOnRed  ctermbg=magenta
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
