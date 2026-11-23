
dnf install -y git

git config --global diff.tool nvimdiff
git config --global difftool.prompt false
git config --global difftool.nvimdiff.cmd 'nvim -d "$LOCAL" "$REMOTE"'
