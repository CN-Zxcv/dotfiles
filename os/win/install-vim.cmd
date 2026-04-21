" curl.cmd

if not exist "..\_vimrc.bak" MOVE "..\_vimrc" "..\_vimrc.bak"

mklink /D "../_vimrc" "vimrc"

git submodule init
git submodule update
::vim +PluginInstall
