"vi兼容"
set nocompatible

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
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

"行号"
set nu!
"搜索忽略大小写"
set ignorecase
"配色"
colorscheme desert
"高亮当前行"
set cursorline
hi Cursorline cterm=NONE ctermfg=NONE ctermbg=0
