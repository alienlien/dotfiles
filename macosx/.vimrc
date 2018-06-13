let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
  echo "Installing Vundle.."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/Vundle.vim
  let iCanHazVundle=0
endif

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo

" Cloned and modified from http://cscope.sourceforge.net/cscope_maps.vim to
" make a vundle package.
Plugin 'steffanc/cscopemaps.vim'

" Ctrlp - Full path fuzzy file, buffer, mru, tag, ... finder for Vim.
" https://github.com/kien/ctrlp.vim  
Plugin 'kien/ctrlp.vim'

" Vim syntax highlighting for Google's Protocol Buffers
Plugin 'uarun/vim-protobuf'

" Go development plugin for Vim
Plugin 'fatih/vim-go'

" Use 'gd' to find where the method/variable is
" Requisite: http://github.com/rogpeppe/godef 
Plugin 'dgryski/vim-godef'
let g:godef_split=2

" Markdown Syntax
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
" Disable the folding
let g:vim_markdown_folding_disabled=1

" Vim syntax for swift
Plugin 'toyamarinyon/vim-swift'

" Python auto complete
Plugin 'davidhalter/jedi-vim'

" Python lint
Plugin 'nvie/vim-flake8'

" Latex syntax highlighting
Plugin 'lervag/vimtex'

" CSS Color Preview
Plugin 'ap/vim-css-color'

" Ag Plugin
" :Ag [options] {pattern} [{directory}]
Plugin 'rking/ag.vim'

" Javascript, JSX syntax
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'maksimr/vim-jsbeautify'

" Scala Syntax
Plugin 'derekwyatt/vim-scala'

" Json Syntax
Plugin 'elzr/vim-json'

" YAML Syntax
Plugin 'stephpy/vim-yaml'

" GraphQL Syntax
Plugin 'jparise/vim-graphql'

" Jinja2 template syntax
Plugin 'glench/vim-jinja2-syntax'

" Haskell Syntax
Plugin 'neovimhaskell/haskell-vim'

" Nerdtree for vim
Plugin 'scrooloose/nerdtree'

" Ensime vim (for scala)
" Plugin 'ensime/ensime-vim'

" Install fzf plugin for vim.
Plugin 'junegunn/fzf'

" Hocon plugin
Plugin 'geverding/vim-hocon'

" Thrift plugin
Plugin 'solarnz/thrift.vim'

" AutoComplete
Plugin 'shougo/neocomplete.vim'
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" For Scala
" Ignore the file generated for search.
set wildignore+=*/target/*

" Airline
Plugin 'vim-airline/vim-airline'

" Git wrapper for airline
" Plugin 'tpope/vim-fugitive'

" Add auto-formatter
" Plugin 'Chiel92/vim-autoformat'

" Search with Ag Plugin Directly.
" visual: gag to search the selected text
" normal: gagiw to search the word
"         gagi' to search the words inside single quotes.
" Plugin 'chun-yang/vim-action-ag'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
syntax on

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" 編輯喜好設定          

" syntax on        " 語法上色顯示
" set nocompatible " VIM 不使用和 VI 相容的模式
" set ai           " 自動縮排

set shiftwidth=4 " 設定縮排寬度 = 4
set tabstop=4    " tab 的字元數
set softtabstop=4
set expandtab    " 用 space 代替 tab

set ruler        " 顯示右下角設定值
set backspace=2  " 在 insert 也可用 backspace
set ic           " 設定搜尋忽略大小寫
set ru           " 第幾行第幾個字
set hlsearch     " 設定高亮度顯示搜尋結果
set incsearch    " 在關鍵字還沒完全輸入完畢前就顯示結果
set smartindent  " 設定 smartindent
set confirm      " 操作過程有衝突時，以明確的文字來詢問
set history=100  " 保留 100 個使用過的指令
set cursorline   " 顯示目前的游標位置
set t_Co=256     " 顯示為 256 色
set background=dark

set laststatus=2
set statusline=%4*%<\%m%<[%f\%r%h%w]\ [%{&ff},%{&fileencoding},%Y]%=\[Position=%l,%v,%p%%]
set omnifunc=syntaxcomplete#Complete

set tags=tags;/

colorscheme wombat256

augroup filetypedetect
  au BufNewFile,BufRead *.pig set filetype=pig syntax=pig
augroup END

" autocmd FileType go compiler go
autocmd Filetype go set makeprg=go\ build

set rtp+=/Users/Alien_Lien/workspace/local/go/misc/vim
set rtp+=/Users/Alien_Lien/workspace/project/csi/src/github.com/golang/lint/misc/vim

" let g:go_fmt_command = "goimports"
" autocmd BufWritePre *.go :Fmt

" Set Leader as ','
let mapleader=","   "Leader is ,"

" Open ag.vim
nnoremap <leader>a :Ag

" Add keyboard shortcuts
map <A-Left> gT
map <A-Right> gt

" Add ctags for python packages.
map <F11> :!ctags -R -f ./tags /usr/local/lib/python2.7/site-packages<CR>

"--------------------
" Function: Open tag under cursor in new tab
" Source:   http://stackoverflow.com/questions/563616/vimctags-tips-and-tricks
"--------------------
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

" Add the keyword : for lua + ctags
augroup filetype_lua
    autocmd!
    autocmd FileType lua setlocal iskeyword+=:
augroup END

" Auto lint when saving python files. 
autocmd BufWritePost *.py call Flake8()

let g:jedi#use_tabs_not_buffers = 1

" Enable JSX check for .js files.
let g:jsx_ext_required = 0

" Auto fix javascript when saving .js files
" autocmd BufWritePost *.js call JsBeautify()

" Auto remove trailing spaces
autocmd FileType python autocmd BufWritePre <buffer> :%s/\s\+$//e

" Map a shortcut to open NERDTree?
map <C-n> :NERDTreeToggle<CR>


" Ensime for scala
" Ref: http://ensime.org/editors/vim/install/
" autocmd BufWritePost *.scala silent :EnTypeCheck
" nnoremap <localleader>t :EnType<CR>
