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

hasPkg() {
    test -n "command -v $1"
}

hasError() {
    test $? != 0
}

function updatePkgMgr() {
    local name=$1
    if [ -n "command -v apt-get" ]; then
        sudo apt update
    elif [ -n "command -v yum" ]; then
        sudo yum update
    else
        echoColor $Color_Red "no package manager"
        exit 1;
    fi
}

function installPkg() {
    local name=$1
    if [ -n "command -v apt-get" ]; then
        sudo apt install -y $name
    elif [ -n "command -v yum" ]; then
        sudo yum install -y $name
    else
        echoColor $Color_Red "no no package manager"
        exit 1;
    fi
}