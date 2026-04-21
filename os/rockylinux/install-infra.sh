# 启用 EPEL
dnf install -y epel-release

dnf install -y htop wget ripgrep nvim tmux

script_dir=$(realpath $(dirname $0))

# 链接 tmux 配置
ln -s $(realpath $script_dir/../../config/tmux.conf) ~/.tmux.conf
