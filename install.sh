mv ~/.vimrc ~/.vimrc.bak
ln -s $(pwd)/vimrc ~/.vimrc
ln -s $(pwd)/vim/bundle ~/.vim/
git submodule init
git submodule update
vim +PluginInstall
