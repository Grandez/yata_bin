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

set -e

msg "=== Actualizando sistema ==="
apt update     >> $FLOG
apt upgrade -y >> $FLOG
apt-get -y install software-properties-common curl wget git build-essential >> $FLOG
apt-get -y install dirmngr gnupg apt-transport-https ca-certificates        >> $FLOG
apt-get -y install unzip zip dos2unix cpu-checker                           >> $FLOG

msg "=== Instalando compiladores y herramientas C/C++ ==="
apt-get install -y gcc g++ clang cmake gdb valgrind pkg-config >> $FLOG

msg "=== Instalando Java (OpenJDK 21) ==="
apt-get install -y openjdk-21-jdk >> $FLOG

msg "=== Instalando R ==="
apt-get -y install r-base >> $FLOG

msg "=== Instalando Docker ==="
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc


tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

apt-get update >> $FLOG
apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin >> $FLOG
systemctl status docker | grep -q running
if [ $? -eq 0 ] ; then
   info Docker arrancado correctamente
else
   err  Docker no se ha arrancado correctamente
fi

msg "======================="
msg "=== Instalando IDEs ==="
msg "======================="
echo
msg "=== Instalando Eclipse via snap ==="
snap install --classic eclipse


msg "=== Instalando RStudio ==="
CWD=`pwd`
cd $PRJ/tmp
wget https://download1.rstudio.org/electron/jammy/amd64/rstudio-2026.01.0-392-amd64.deb
apt-get -y install ./rstudio-2026.01.0-392-amd64.deb >> $FLOG
cd $CWD


