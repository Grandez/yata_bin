#!/bin/bash

#####################################################################
# DEBE EJECUTARSE COMO root
#
# Script de instalacion de los entornos de desarrollo
# Basicamente via Snap
#
# Date:    02/2026
# Author:  Grandez <jggrandez@gmail.com>
# Version: 1.0.0
#
# History
#  02/2026 - 1.0.0 - Creacion
#
#####################################################################

source $PRJ/bin/common.sh  # Existe

msg "Instalando IDEs"
which eclipse > /dev/null
if [ $? -ne 0 ] ; then
   prg 1 Instalando Eclipse via Snap
   snap install --classic eclipse >> $FLOG 2>> $FERR
fi

which code > /dev/null
if [ $? -ne 0 ] ; then
   prg 1 Instalando VS Code via Snap
   snap install --classic code >> $FLOG 2>> $FERR
fi

which intellij-idea > /dev/null
if [ $? -ne 0 ] ; then
   prg 1 Instalando Intellij Community via Snap
   snap install --classic intellij-idea >> $FLOG 2>> $FERR
fi

which rstudio > /dev/null
if [ $? -ne 0 ] ; then
   prg 1 Instalando RStudio
   CWD=`pwd`
   cd /tmp

   wget https://download1.rstudio.org/electron/jammy/amd64/rstudio-2026.01.0-392-amd64.deb
   apt-get -y install ./rstudio-2026.01.0-392-amd64.deb >> $FLOG 2>> $FERR
   rm rstudio-2026.01.0-392-amd64.deb
   cd $CWD
fi
