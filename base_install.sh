#!/bin/bash

# 检测系统类型
detect_os() {
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        OS=$NAME
    else
        OS=$(lsb_release -si)
    fi
}

# 安装Docker
install_docker() {
    if [[ "$OS" == *"Ubuntu"* ]]; then
        sudo apt-get update
        for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
        sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
        sudo install -m 0755 -d /etc/apt/keyrings
        sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
        sudo chmod a+r /etc/apt/keyrings/docker.asc
        echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
        $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
        sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        sudo apt-get update
        sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
        sudo systemctl start docker
        sudo systemctl enable docker
        sudo docker run hello-world
    elif [[ "$OS" == *"CentOS Linux"* ]]; then
        sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine
        sudo yum install -y yum-utils device-mapper-persistent-data lvm2
        sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
        sudo sudo yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
        sudo systemctl start docker
        sudo systemctl enable docker
        sudo docker run hello-world
    else
        echo "Unsupported OS: $OS"
        exit 1
    fi
}

# 卸载Docker
uninstall_docker() {
    if [[ "$OS" == *"Ubuntu"* ]]; then
        sudo apt-get purge docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
        sudo rm -rf /var/lib/docker
        sudo rm -rf /etc/docker
        sudo rm -rf /var/lib/containerd
    elif [[ "$OS" == *"CentOS Linux"* ]]; then
        sudo yum remove docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
        sudo rm -rf /var/lib/docker
        sudo rm -rf /etc/docker
        sudo rm -rf /var/lib/containerd
        sudo systemctl disable docker
    else
        echo "Unsupported OS: $OS"
        exit 1
    fi
}

# 安装docker-compose
install_compose() {
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
}

# 卸载docker-compose
uninstall_compose() {
    sudo rm -f /usr/local/bin/docker-compose
}

# 主逻辑
case "$1" in
    install)
        detect_os
        install_docker
        install_compose
        echo "Docker and docker-compose have been installed."
        ;;
    uninstall)
        detect_os
        uninstall_docker
        uninstall_compose
        echo "Docker and docker-compose have been uninstalled."
        ;;
    *)
        echo "Usage: $0 {install|uninstall}"
        exit 1
esac