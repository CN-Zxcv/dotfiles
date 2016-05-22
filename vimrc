"vi兼容"
set nocompatible

filetype off
if has("win32")
    set rtp+=$VIM/vim-config/vim/bundle/Vundle.vim
elseif has("unix")
    set rtp+=./vim/bundle/Vundle.vim
endif

call vundle#begin()
    "插件管理"
    Plugin 'VundleVim/Vundle.vim'
    "查看和切换缓冲区"
    Plugin 'bsdelf/bufferhint' 
    nnoremap - :call bufferhint#Popup()<CR>
    " nnoremap \ :call bufferhint#LoadPrevious()<CR>
    "文件搜索"
    Plugin 'ctrlpvim/ctrlp.vim'
    "快速跳行"
    Plugin 'easymotion/vim-easymotion'
    map f <Plug>(easymotion-prefix)
    "对齐"
    Plugin 'junegunn/vim-easy-align'
call vundle#end()
filetype plugin indent on

" vnoremap <silent> ge "gy:vimgrep /<C-R>g/ % \|copen<cr>
" nnoremap ge :vimgrep // % \|copen<left><left><left><left><left><left><left><left><left><left>
" cnoremap grep vimgrep // % \|cw<left>

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
