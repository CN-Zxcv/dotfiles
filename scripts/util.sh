#/bin/sh

Color_Default="\e[0m"
Color_Red="\e[31m"
Color_Green="\e[32m"
Color_Brown="\e[33m"
Color_Blue="\e[34m"
Color_Purple="\e[35m"
Color_Cyan="\e[36m"
Color_LightGray="\e[37m"

echoColor() {
    local color=$1
    local msg=$2
    echo -e "$color$msg$Color_Default"
}

echoNotice() {
    echoColor $1 "==== $2 ===="
}

hasError() {
    test $? != 0
}


AppInstalled() {
    test -n "command -v $1"
}

AppUpdate() {
    local name=$1
    if [ -n "command -v apt-get" ]; then
        sudo apt update
    elif [ -n "command -v yum" ]; then
        sudo yum update
    elif [ -n "command -v dnf"]; then
        sudo dnf update
    else
        echoColor $Color_Red "no package manager"
        exit 1;
    fi
}

AppInstall() {
    local name=$1
    if [ -n "command -v apt-get" ]; then
        sudo apt install -y $name
    elif [ -n "command -v yum" ]; then
        sudo yum install -y $name
    elif [ -n "command -v dnf" ]; then
        sudo dnf install -y $name
    else
        echoColor $Color_Red "no no package manager"
        exit 1;
    fi
}
