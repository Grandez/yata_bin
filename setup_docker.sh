#!/bin/bash

#####################################################################
# DEBE EJECUTARSE COMO root
#
# Script de instalacion de Docker
#
# Date:    02/2026
# Author:  Grandez <jggrandez@gmail.com>
# Version: 1.0.0
#
# History
#  02/2026 - 1.0.0 - Macro Script
#
#####################################################################

source $PRJ/bin/common.sh  # Existe

systemctl status docker | grep -q running
[[ $? -eq 0 ]] && return 0

msg Instalando Docker
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
