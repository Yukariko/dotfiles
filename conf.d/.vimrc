set nocompatible | filetype indent plugin on | syn on
"if empty($STY) && get(g:, 'colors_name', 'default') !=# 'default'
  " See https://gist.github.com/XVilka/8346728.
  if $COLORTERM =~# 'truecolor' || $COLORTERM =~# '24bit'
    if has('termguicolors')
      " :help xterm-true-color
      "if $TERM =~# '^screen'
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
      "endif
      set termguicolors
    endif
  endif
"endif
" Install vim-plug if it isn't installed and call plug#begin() out of box
function! s:download_vim_plug()
  if !empty(&rtp)
    let vimfiles = split(&rtp, ',')[0]
  else
    echohl ErrorMsg
    echomsg 'Unable to determine runtime path for Vim.'
    echohl NONE
  endif
  if empty(glob(vimfiles . '/autoload/plug.vim'))
    let plug_url =
          \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    if executable('curl')
      let downloader = '!curl -fLo '
    elseif executable('wget')
      let downloader = '!wget -O '
    else
      echohl ErrorMsg
      echomsg 'Missing curl or wget executable'
      echohl NONE
    endif
    if !isdirectory(vimfiles . '/autoload')
      call mkdir(vimfiles . '/autoload', 'p')
    endif
    if has('win32')
      silent execute downloader . vimfiles . '\\autoload\\plug.vim ' . plug_url
    else
      silent execute downloader . vimfiles . '/autoload/plug.vim ' . plug_url
    endif
    " Install plugins at first
    autocmd VimEnter * PlugInstall | quit
  endif
  call plug#begin(vimfiles . '/plugged')
endfunction

call s:download_vim_plug()
" kangmin
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'vim-jp/vim-cpp'
Plug 'vim-airline/vim-airline'
Plug 'bfrg/vim-cpp-modern'
Plug 'tpope/vim-obsession' " obsession.vim: continuously updated session files
Plug 'dense-analysis/ale' " clang-tidy
" Theme
Plug 'dracula/vim'
Plug 'Yukariko/my_colorscheme'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

nnoremap ; :

set cinoptions+=:0

highlight link cErrinBracket NONE
set autoindent
set tabstop=4
set softtabstop=-1 " insert 모드에서 탭 누를때 들어가는 간격
set shiftwidth=4 " tab 관련 설정
set expandtab
set number " show line number
set nobackup "do not make backup files
set title " windows title을 현재 편집중인 파일이름으로 한다.
set incsearch "incremental search
set hlsearch "search를 할때 highlight를 해준다.
set ignorecase "smartcase랑 같이
set smartcase "소문자로 검색시 대소문자 무시, 대문자로 검색시 대문자만 검색
set fencs=ucs-bom,utf-8,cp949 "try this encodings when open files
set showmatch "match brakets
set autowrite "auto save when :make or :next
set foldmethod=syntax " syntax에 따라 folding을 한다.
set foldlevel=9999999 "open all fold
set keymodel-=stopsel " ctrl+f & ctrl+b don't stop visual mode
set showcmd
set backspace=2
set display+=uhex "show unprintable characters as a hex number
set clipboard=unnamed "share clipboard with register
"set statusline=%F%m%r%h%w\ \:\ %{&ff},%Y\ %=[\%03.3b,0x\%02.2B]\ \ \ %l,%c%V\ (%p%%)
set laststatus=2
set scrolloff=3  " 커서의 위아래로 항상 세줄의 여유가 있게끔.
set completeopt=menu,menuone,longest " do not show preview window on omnicompletion
set wildignore=.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*.pyc
set shell=/bin/bash     " use bash for shell commands
set autowriteall        " Automatically save before commands like :next and :make
set hidden              " enable multiple modified buffers
set history=1000
set autoread            " automatically read file that has been changed on disk and doesn't have changes in vim
set exrc
set updatetime=100

colorscheme vim-monokai-tasty
"set bg=dark " background를 dark로 설정한다

hi Normal guibg=NONE ctermbg=NONE
command! W w " :W로 저장

" man page settings
autocmd FileType c,cpp set keywordprg=man
"vertical split & show git diff when git commit
autocmd FileType gitcommit DiffGitCached | wincmd L | wincmd p

" Highlight trailing whitespace
function! s:MatchExtraWhitespace(enabled)
  if a:enabled && index(['GV', 'vim-plug'], &filetype) < 0
    match ExtraWhitespace /\s\+$/
  else
    match ExtraWhitespace //
  endif
endfunction
highlight link ExtraWhitespace Error
augroup ExtraWhitespace
  autocmd!
  autocmd BufWinEnter * call s:MatchExtraWhitespace(1)
  autocmd FileType * call s:MatchExtraWhitespace(1)
  autocmd InsertEnter * call s:MatchExtraWhitespace(0)
  autocmd InsertLeave * call s:MatchExtraWhitespace(1)
  if v:version >= 702
    autocmd BufWinLeave * call clearmatches()
  endif
augroup END


"Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv
" I can type :help on my own, thanks.
noremap <F1> <Esc>
"Disable paste mode when leaving Insert Mode
au InsertLeave * set nopaste

" Use CTRL-N to clear the highlighting
nnoremap <silent> <C-N> :<C-U>nohlsearch<C-R>=&diff ? '<Bar>diffupdate' : ''<CR><CR>

" Delete without copying
vnoremap <BS> "_d

" Close braces
function! s:CloseBrace()
  let line_num = line('.')
  let next_line = getline(line_num + 1)
  if !empty(next_line) &&
        \ indent(line_num + 1) == indent(line_num) &&
        \ next_line =~# '^\s*}'
    return "{\<CR>"
  elseif (&filetype ==# 'c' || &filetype ==# 'cpp') &&
        \ getline(line_num) =~# '\%(' .
        \   '^\s*\%(typedef\s*\)\?\%(class\|enum\|struct\)\s\+' . '\|' .
        \   '\<\h\w*\s*=\s*$' . '\)'
    return "{\<CR>};\<C-C>O"
  else
    return "{\<CR>}\<C-C>O"
  endif
endfunction
inoremap <expr> {<CR> <SID>CloseBrace()

let g:syntastic_cpp_compiler_options = ' -std=c++17'
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l
nmap <C-?> <esc>:Rg <C-R>=expand("<cword>")<CR><CR>

if executable('rg')
function! s:GetVisualSelection()
  let [line_start, column_start] = getpos("'<")[1:2]
  let [line_end, column_end] = getpos("'>")[1:2]
  let lines = getline(line_start, line_end)
  if len(lines) == 0
    return ''
  endif
  let offset = &selection ==# 'exclusive' ? 2 : 1
  let lines[-1] = lines[-1][:column_end - offset]
  let lines[0] = lines[0][column_start - 1:]
  return join(lines, "\n")
endfunction
let s:rg_common = 'rg --column --line-number --no-heading --color=always ' .
      \ '--smart-case '
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   s:rg_common . '--fixed-strings -- ' . shellescape(<q-args>),
      \   1,
      \   fzf#vim#with_preview(
      \     { 'options': '--delimiter : --nth 4..' }, 'right', 'ctrl-/'),
      \   <bang>0)
endif

" :Syn
" https://vim.fandom.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
command! Syn :echo 'hi<' . synIDattr(synID(line('.'), col('.'), 1), 'name') .
      \ '> trans<' . synIDattr(synID(line('.'), col('.'), 0), 'name') .
      \ '> lo<' . synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name') .
      \ '>'

" ale-cpp-clangcheck
" ale-c-clangformat, ale-cpp-clangformat
" ale-c-clangtidy, ale-cpp-clangtidy
for [s:prog, s:slug, s:langs] in [
    \ ['clang-check', 'clangcheck', ['cpp']],
    \ ['clang-format', 'clangformat', ['c']],
    \ ['clang-tidy', 'clangtidy', ['c', 'cpp']]]
  let s:llvm_prog = '/usr/local/opt/llvm/bin/' . s:prog
  if !executable(s:prog) && executable(s:llvm_prog)
    for s:lang in s:langs
      let g:[printf('ale_%s_%s_executable', s:lang, s:slug)] = s:llvm_prog
    endfor
  endif
endfor

" See http://clang.llvm.org/extra/clang-tidy/.
let g:ale_c_clangtidy_checks = [
    \ '*',
    \]
let g:ale_cpp_clangtidy_checks = g:ale_c_clangtidy_checks
let g:ale_linters = {
    \ 'cpp' : ['clangtidy']
\}
let g:ale_linters_explicit = 1
let s:vimfiles = split(&rtp, ',')[0]
"Chayoung You, 2 months ago: • vimrc: use single directory for storing swap …
if !isdirectory(s:vimfiles . '/swap')
  call mkdir(s:vimfiles . '/swap', 'p')
endif
" List of directory names for the swap file, separated with commas
execute 'set directory^=' . s:vimfiles . '/swap//'
