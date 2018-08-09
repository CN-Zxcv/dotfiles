"vi兼容"
set nocompatible

filetype off
if has("win32")
    set rtp+=$VIM/vim-config/vim/bundle/Vundle.vim
elseif has("unix")
    set rtp+=~/.vim/bundle/Vundle.vim
endif

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

call vundle#begin()
    "插件管理"
    Plugin 'VundleVim/Vundle.vim'
    "查看和切换缓冲区"
    Plugin 'bsdelf/bufferhint' 
    nnoremap - :call bufferhint#Popup()<CR>
    " nnoremap \ :call bufferhint#LoadPrevious()<CR>
    "文件搜索"
    Plugin 'ctrlpvim/ctrlp.vim'
    let g:ctrlp_working_path_mode = ''
    let g:ctrlp_map = ''
    "let g:ctrlp_user_command = 'ag %s --nocolor --nogroup --hidden --ignore .git --ignore out --ignore .svn --ignore .hg --ignore .DS_Store -g ""'
    nnoremap <silent> <C-P> :CtrlP <c-r>=FindProjectRoot('.ctrlp', GetCurPath())<CR><CR>
    "快速跳行"
    Plugin 'easymotion/vim-easymotion'
    map f <Plug>(easymotion-prefix)
    "对齐"
    Plugin 'junegunn/vim-easy-align'
    let g:easy_align_delimiters = {
    \ '-' : {'pattern' : '--', 'ignore_groups' : ['!Comment'], 'filter' : 'g/^.*\S\+.*--/'},
    \ }
    "搜索"
    " Plugin 'dyng/ctrlsf'
    Plugin 'rking/ag.vim'
    com -nargs=* -complete=file Agg call ag#Ag('grep<bang>', '<q-args>'.' '.FindProjectRoot('.ctrlp', GetCurPath()))
    "com -nargs=* Agg vimgrep "<args>" <c-r>=FindProjectRoot('.ctrlp'))<CR><CR>
    "目录浏览"
    Plugin 'scrooloose/nerdtree'
    map <silent> <C-N> :NERDTreeToggle <c-r>=FindProjectRoot('.ctrlp', GetCurPath())<CR><CR>
    "语法检查"
    Plugin 'vim-syntastic/syntastic'
    set statusline+=%#warningmsg#
    if exists("SyntasticStatusFlag")
        set statusline+=%{SyntasticStatusFlag()}
    endif
    set statusline+=%*
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 2
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 1
    "有配置时才启用检查"
    if FindProjectRoot(".luacheckrc", "") != "" 
        let g:syntastic_lua_checkers = ["luac", "luacheck"]
        let g:syntastic_lua_luacheck_args = "--config " . FindProjectRoot(".luacheckrc", GetCurPath()) . "/.luacheckrc"
    endif

call vundle#end()
filetype plugin indent on

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
set colorcolumn=100


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
    call AddLine(a:prefix." --.-----------------------------------------------------------------------.--")
    call AddLine(Note(a:prefix, g:false))
    call AddLine(a:prefix." --'-----------------------------------------------------------------------'--")
    call cursor(line(".") - 2, 65536)
endfunction

autocmd FileType,BufRead,BufEnter *.*,vim exec ":call Init()"
function Init()
    if &filetype == 'lua' || &filetype == 'haskell'
        iabbrev --n <C-o>:call Note("--", true)<CR>
        iabbrev --l <C-o>:call Notice("--")<CR>
    endif
endfunction
