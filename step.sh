#!/bin/bash

# ==============================================
# Kubuntu LTS Dev Setup (R, Python, C/C++, Java)
# Sin Snap, limpio y minimalista
# ==============================================

BASE=base.sh
source $PRJ/bin/$BASE 2> /dev/null

[[ $? -gt 0 ]] && echo -e "\e[1;31m"Parece que falta la variable de entorno PRJ o el script $BASE"\e[0m" && exit 1
ID=`id -u`
[[ $ID -gt 0 ]] && echo -e "\e[1;31m"Este script debe ejecutase como root"\e[0m" && exit 1
echo seguimos

set -e

msg "======================="
msg "=== Instalando IDEs ==="
msg "======================="
echo
msg "=== Instalando Eclipse via snap ==="
snap install --classic eclipse
