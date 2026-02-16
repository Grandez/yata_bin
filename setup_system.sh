#!/bin/bash

#####################################################################
# DEBE EJECUTARSE COMO root
#
# Script de instalacion de paquetes y librerias del sistema
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

msg "Actualizando sistema"
apt-get update     >> $FLOG
apt-get upgrade -y >> $FLOG
prg 1 Instalando paquetes
apt-get -y install software-properties-common curl wget git build-essential >> $FLOG 2>> $FERR
apt-get -y install dirmngr gnupg apt-transport-https ca-certificates        >> $FLOG 2>> $FERR
apt-get -y install unzip zip dos2unix cpu-checker snapd                     >> $FLOG 2>> $FERR

prg 1 Instalando librerias
apt-get -y install libcurl4-openssl-dev libfontconfig1-dev libfreetype6-dev >> $FLOG 2>> $FERR
apt-get -y install libmagick++-dev libfreetype6-dev cargo                   >> $FLOG 2>> $FERR
prg 1 Instalando compiladores y herramientas
apt-get install -y gcc g++ clang cmake gdb valgrind pkg-config >> $FLOG 2>> $FERR

java -version 2> /dev/null
if [ $? -ne 0 ] ; then
   prg 2 Instalando Java
   apt-get install -y openjdk-21-jdk >> $FLOG 2>> $FERR
fi

R --version > /dev/null
if [ $? -ne 0 ] ; then
   msg 2 Instalando R
   apt-get -y install r-base >> $FLOG 2>> $FERR
fi

python3 --version > /dev/null
if [ $? -ne 0 ] ; then
   msg 2 Instalando Python
   apt-get -y install python3 python3-pip >> $FLOG 2>> $FERR
   apt-get -y install python3-pycurl      >> $FLOG 2>> $FERR
fi

