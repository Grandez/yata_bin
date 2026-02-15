#!/bin/bash

#####################################################################
# DEBE EJECUTARSE COMO root
#
# Script maestro de instalacion de software y configuracion
# para crear una plataforma de desarrollo para un (multi)proyecto
# "from scratch"
#
# Asume que se han hecho algunas tareas previas segun documentacion
#
# Date:    02/2026
# Author:  Grandez <jggrandez@gmail.com>
# Version: 2.0.0
#
# History
#  02/2026 - 1.0.0 - Macro Script
#  02/2026 - 2.0.0 - Se dividen los procesos en scripts separados
#
#####################################################################

MASTER=X
SCRIPTS=( setup_system setup_docker setup_pacman )
# Mensaje de error
msgerr () {
   echo -e "\e[1;31m"`date +%T` - ERROR: $*"\e[0m" >&2
}

#####################################################################
# Verifica que estan todos los scripts
#####################################################################
check_scripts() {
     local DNE="No existe el script"
     [[ ! -x $PRJ/bin/common.sh ]] && msgerr $DNE $i.sh && return 0
     for i in "${SCRIPTS[@]}" ; do [[ ! -x $PRJ/bin/$i.sh ]] && msgerr $DNE $i.sh && return 0 ; done
     return 1
}

#####################################################################
# 1. Chequea que el sistema esta bien configurado
# 2. Establece las variables generales
# 3. Tiene que estar como funcion en el master
#####################################################################
check_env() {
   SCR_DIR=`dirname $0`
   SCR_NAME=`basename $0`
   SCR_BASE=${SCR_NAME%.*}
   local ID=`id -u`

   [[   -z $PRJ      ]] && msgerr Falta la variable de entorno global PRJ && return 0
   [[ ! -d $PRJ/bin  ]] && msgerr No existe el directorio bin             && return 0
   [[ ! -d $PRJ/logs ]] && msgerr No existe el directorio logs            && return 0
   [[      $ID -gt 0 ]] && msgerr Este script debe ejecutase como root    && return 0

   check_scripts
   return $?
}

echo -e "\e[1;97m"`date +%T` - Chequeando entorno "\e[0m"
check_env

source $PRJ/bin/common.sh  # Existe

for i in "${SCRIPTS[@]}" ; do . $PRJ/bin/$i.sh ; done

echo salgo
exit 1


apt-get update     >> $FLOG
apt-get upgrade -y >> $FLOG
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

msg "=== Instalando Visual Studio Code ==="
snap install --classic code

cd $CWD


