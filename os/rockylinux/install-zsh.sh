
# 安装oh-my-zsh
source ../../scripts/util.sh

dnf install -y wget
dnf install -y zsh

if [ ! -d ~/.oh-my-zsh ]; then
    echoNotice $Color_Cyan "installing oh-my-zsh ..."
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
    if hasError; then
        echoNotice $Color_Red "error installing oh-my-zsh"
        exit 1
    fi
    echoNotice $Color_Cyan "installing oh-my-zsh complete"
fi
