# 启用 EPEL
dnf install -y epel-release

# 基础工具
dnf install -y htop wget ripgrep nvim tmux python rsync subversion

# 修改配置的工具
dnf install -y crudini

script_dir=$(realpath $(dirname $0))
config_dir=$(realpath $script_dir/../../config)

# 链接 tmux 配置
ln -s $config_dir/tmux.conf ~/.tmux.conf

# 链接 subversion 配置
rm /usr/local/bin/svn
chmod +x $config_dir/usr-bin/svn
ln -s $config_dir/usr-bin/svn /usr/local/bin/svn

rm /usr/local/bin/svn-diff.sh
chmod +x $config_dir/usr-bin/svn-diff.sh
ln -s $config_dir/usr-bin/svn-diff.sh /usr/local/bin/svn-diff.sh

crudini --set ~/.subversion/config helpers diff-cmd "/usr/local/bin/svn-diff.sh"
