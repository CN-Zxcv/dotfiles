script_dir=$(realpath $(dirname $0))

source $script_dir/../../scripts/util.sh

# 安装 nvim
if [ ! -d /opt/nvim-linux-x86_64 ]; then
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
    sudo rm -rf /opt/nvim-linux-x86_64
    sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
fi

# 链接 nvim 目录
mkdir -p ~/.config
ln -s $(realpath $script_dir/../../config/nvim) ~/.config/nvim

echoNotice $Color_Cyan "installing nvim complete"
