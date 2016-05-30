"vi兼容"
set nocompatible

filetype off
if has("win32")
    set rtp+=$VIM/vim-config/vim/bundle/Vundle.vim
elseif has("unix")
    set rtp+=~/.vim/bundle/Vundle.vim
endif

fu! FindProjectRoot(lookfor)
    let pathmaker = '%:p'
    while (len(expand(pathmaker)) > len(expand(pathmaker.":h")))
        let pathmaker = pathmaker.':h'
        if len(split(globpath(expand(pathmaker), a:lookfor), "\n")) >= 1
            return expand(pathmaker)
        endif
    endw
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
    nnoremap <silent> <C-P> :CtrlP <c-r>=FindProjectRoot('.ctrlp')<CR><CR>
    "快速跳行"
    Plugin 'easymotion/vim-easymotion'
    map f <Plug>(easymotion-prefix)
    "对齐"
    Plugin 'junegunn/vim-easy-align'
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
"set autoread
"自动切换目录到当前文件所在目录"
set autochdir
set tags=tags;

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
    if &filetype == 'lua'
        iabbrev --n <C-o>:call Note("--", true)<CR>
        iabbrev --l <C-o>:call Notice("--")<CR>
    endif
endfunction
