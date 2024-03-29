"vi兼容"
set nocompatible

call plug#begin()
    "插件管理"
    Plug 'VundleVim/Vundle.vim'
    "查看和切换缓冲区"
    Plug 'CN-Zxcv/bufferhint' 
    "文件搜索"
    " Plug 'ctrlpvim/ctrlp.vim'
    Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
    "快速跳行"
    " Plug 'easymotion/vim-easymotion'
    "对齐"
    Plug 'junegunn/vim-easy-align'
    "搜索"
    " Plug 'dyng/ctrlsf'
    " Plug 'rking/ag.vim'
    Plug 'jremmen/vim-ripgrep'
    "目录浏览"
    Plug 'scrooloose/nerdtree'
    "语法检查"
    Plug 'vim-syntastic/syntastic'
    "注释"
    Plug 'tpope/vim-commentary'
    "AI代码补全"
    Plug 'codota/tabnine-vim'

call plug#end()

" --------------------------------------
" 插件配置

" easymotion/vim-easymotion
" map f <Plug>(easymotion-prefix)

" bsdelf/bufferhint
nnoremap - :call bufferhint#Popup()<CR>
" nnoremap \ :call bufferhint#LoadPrevious()<CR>
let g:bufferhint_SortMode = 1

" ctrlpvim/ctrlp.vim
" let g:ctrlp_working_path_mode = ''
" let g:ctrlp_map = ''
"let g:ctrlp_user_command = 'ag %s --nocolor --nogroup --hidden --ignore .git --ignore out --ignore .svn --ignore .hg --ignore .DS_Store -g ""'
" nnoremap <silent> <C-P> :CtrlP <c-r>=FindProjectRoot('.ctrlp', GetCurPath())<CR><CR>

" Yggdroot/LeaderF
let g:Lf_ShortcutF = '<C-P>'
let g:Lf_StlSeparator = { 'left': '<', 'right': '>' }

" junegunn/vim-easy-align
let g:easy_align_delimiters = {
            \ '-' : {'pattern' : '--', 
            \       'ignore_groups' : ['!Comment'], 
            \       'filter' : 'g/^.*\S\+.*--/',
            \ },
            \ '/': {
            \     'pattern': '\/\/',
            \     'ignore_groups':   ['!Comment'],
            \     'filter' : 'g/^.*\S\+.*\/\//',
            \ },
            \ }

" rking/ag.vim
" com -nargs=* -complete=file Agg call ag#Ag('grep<bang>', '<q-args>'.' '.FindProjectRoot('.ctrlp', GetCurPath()))
"com -nargs=* Agg vimgrep "<args>" <c-r>=FindProjectRoot('.ctrlp'))<CR><CR>


" jremmen/vim-ripgrep
nnoremap <S-f> :Rg <cword><cr>
" 定义的地方, function cword( |^cword =|[ :.]cword =
autocmd FileType,BufRead,BufEnter lua nnoremap <c-]> :Rg 'function.*[ :.]*<cword> *\(\\|^<cword> *=\\| <cword> *='<cr>
" 调用的地方 :cword( | .cword( | = cword(
autocmd FileType,BufRead,BufEnter lua nnoremap <c-\> :Rg '[:.]<cword>\(\\|= *<cword> *\('<cr>
" 对象new的地方 :cword.new | cword.create
autocmd FileType,BufRead,BufEnter lua nnoremap <c-t> :Rg '<cword>.create\\|<cword>.new'<cr>
" 对象定义和继承的地方 module_class.*cword
autocmd FileType,BufRead,BufEnter lua nnoremap <c-y> :Rg 'module_class.*[ (]+<cword>'<cr>

" scrooloose/nerdtree
map <silent> <C-N> :NERDTreeToggle <c-r>=FindProjectRoot('.ctrlp', GetCurPath())<CR><CR>
" 打开文件时, 按照 viminfo 保存的上次关闭时的光标位置重新设置光标
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif


" vim-syntastic/syntastic
set statusline+=%#warningmsg#
if exists("SyntasticStatusFlag")
    set statusline+=%{SyntasticStatusFlag()}
endif
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_cpp_check_header = 1
let g:syntastic_c_check_header = 1
let g:syntastic_cpp_config_file = '.syntastic'
let g:syntastic_c_config_file = '.syntastic'

"有配置时才启用检查"
" if FindProjectRoot(".luacheckrc", "") != "" 
"     let g:syntastic_lua_checkers = ["luac", "luacheck"]
"     let g:syntastic_lua_luacheck_args = "--config " . FindProjectRoot(".luacheckrc", GetCurPath()) . "/.luacheckrc"
" endif

" tpope/vim-commentary
vmap <C-_> <Plug>Commentary
""autocmd FileType lua setlocal commentstring="-- %s"
autocmd FileType c setlocal commentstring=//\ %s
autocmd FileType cpp setlocal commentstring=//\ %s

" ---------------------
" vim 设置

if has("win32")
    "windows gvim 兼容设置"
    source $VIMRUNTIME/vimrc_example.vim
    "windows快捷键"
    behave mswin
    "环境编码"
    set enc=utf-8
    "提示信息编码"
    language message zh_CN.utf-8
    "自动识别编码"
    set fencs=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
    "gui字体"
    set guifont=Courier_New:h11
    "gui快捷图标栏"
    set guioptions-=T
    "gui菜单栏"
    set go=
endif

"行号"
set nu
"搜索忽略大小写"
set ignorecase
"配色"
colorscheme desert
"高亮当前行"
set cursorline
hi Cursorline cterm=NONE ctermfg=NONE ctermbg=0
"tab转换为4空格"
set softtabstop=4
set tabstop=4
set shiftwidth=4
"输入tab时执行空格转换"
set expandtab
"自动缩进"
set ai
"切换模式自动保存"
au InsertLeave ** write
"外部更改自动重读文件"
set autoread
"自动切换目录到当前文件所在目录"
set autochdir
set tags=tags;
"禁止备份文件"
set nobackup
"设置切换tab快捷键"
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
"第N列高亮"
set colorcolumn=80,100
" let &colorcolumn='80,'.join(range(120,300), ',')
highlight ColorColumn ctermbg=235 guibg=#2c2d27

" -------------------------------
" 自定义函数

fu! FindProjectRoot(lookfor, default)
    let pathmaker = '%:p'
    while (len(expand(pathmaker)) > len(expand(pathmaker.":h")))
        let pathmaker = pathmaker.':h'
        if len(split(globpath(expand(pathmaker), a:lookfor), "\n")) >= 1
            return expand(pathmaker)
        endif
    endw
    return a:default
endf

fu! GetCurPath()
    return expand("%:p:h")
endf

"
let Author="Hx"
let true=1
let false=0
function AddLine(content)
    call cursor(line("."), 0)
    call append(line(".") - 1, a:content)
    call cursor(line("."), 65536)
endfunction

function AddWords(content)
    call setline(line("."), getline(".").a:content)
    call cursor(line("."), 65536)
endfunction

function Note(prefix, prt)
    let b:str = strftime(a:prefix." ".g:Author."@%Y-%m-%d:")
    if a:prt 
        call AddWords(b:str)
    else
        return b:str
    endif
endfunction

function Notice(prefix)
    call AddLine(a:prefix." {----------------------------------------------------------------")
    call AddLine(Note(a:prefix, g:false))
    call AddLine(a:prefix." }----------------------------------------------------------------")
    call cursor(line(".") - 2, 65536)
endfunction

autocmd FileType,BufRead,BufEnter *.*,vim exec ":call Init()"
function Init()
    if &filetype == 'lua' || &filetype == 'haskell'
        iabbrev --n <C-o>:call Note("--", true)<CR>
        iabbrev --l <C-o>:call Notice("--")<CR>
    elseif &filetype == 'c' || &filetype == 'cpp' || &filetype == 'proto'
        iabbrev //n <C-o>:call Note("//", true)<CR>
        iabbrev //l <C-o>:call Notice("//")<CR>
    elseif &filetype == 'python'
        set list
        iabbrev #n <C-o>:call Note("#", true)<CR>
        iabbrev #l <C-o>:call Notice("#")<CR>
    endif
endfunction
