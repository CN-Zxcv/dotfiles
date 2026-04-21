mv ~/.vimrc ~/.vimrc.bak
ln -s $(pwd)/vimrc ~/.vimrc
ln -s $(pwd)/vim ~/.vim
git submodule init
git submodule update
vim +PluginInstall

#/bin/bash

source ./scripts/util.sh

# 安装oh-my-zsh
install_zsh () {
    if [ ! "AppStore_Installed zsh" ]; then
        echoNotice $Color_Cyan "installing zsh ..."
        AppStore_Install zsh
        echoNotice $Color_Green "installing zsh complete"
    fi
    if [ ! -d ~/.oh-my-zsh ]; then
        echoNotice $Color_Cyan "installing oh-my-zsh ..."
        wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
        if hasError; then
            echoNotice $Color_Red "error installing oh-my-zsh"
            exit 1
        fi
        echoNotice $Color_Cyan "installing oh-my-zsh complete"
    fi
}

# installVim() {
# mv ~/.vimrc ~/.vimrc.bak
# ln -s $(pwd)/vimrc ~/.vimrc
# ln -s $(pwd)/vim ~/.vim
# git submodule init
# git submodule update
# vim +PluginInstall
# }

main() {

    echoNotice $Color_Green "update package manager"
    install_zsh
    echoNotice $Color_Cyan "succ"
}
main $*
