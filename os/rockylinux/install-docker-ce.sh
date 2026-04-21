# 安装必要的工具包
dnf install -y dnf-utils

# 添加 Docker 官方仓库（使用 CentOS 源，兼容 Rocky Linux 10）
dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
dnf config-manager --add-repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

# 安装 Docker 
sudo dnf install -y docker-ce


# 启动 Docker
systemctl start docker
# 设置开机自动启动
systemctl enable docker

# 修改 Docker 源
cat > "etc/docker/daemon.json" << 'EOF'
{
    "log-driver": "json-file",
    "log-opts": {
        "max-size": "256m",
        "max-file": "3"
    },
    "registry-mirrors": [
        "https://docker.m.daocloud.io",
        "https://docker.1ms.run",
        "https://huecker.io/",
        "https://dockerhub.timeweb.cloud",
        "https://noohub.ru/"
    ],
    "insecure-registries": [
        "http://docker.cdl2.org"
    ]
}
EOF

# 重载配置
systemctl daemon-reload
# 重启 Docker
systemctl restart docker
