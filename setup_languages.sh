#!/bin/bash

#####################################################################
# DEBE EJECUTARSE COMO root
#
# Script de instalacion de los lenguajes de trabajo necesarios
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

# Instalar los paquetes pasados por parametro
r_install() {
  local res=""
  local primero=1

  shift
  for arg in "$@"; do
    if [[ $primero -eq 1 ]]; then
      res="\"$arg\""
      primero=0
    else
      res+=", \"$arg\""
    fi
  done

  cmd="Rscript -e 'install.packages(c($res), dependencies=TRUE)' >> $FLOG 2>> $FERR"
  eval $cmd
}

# Paquetes a instalar
# El primer campo es el tipo del grupo de paquete
r_packages() {
  PKGS=( "Basico   tidyverse stringr devtools roxygen"  \
         "Graficos ggplot2 ggExtra plotly"              \
         "Edicion  knitr quarto"                        \
         "Web      shiny shinyjs bslib DT htmlwidgets"  \
         "Data     forecast zoo TTR"
  )

  for idx in ${!PKGS[@]}; do
    PKG=${PKGS[$idx]}
    prg 1 Instalando paquetes de tipo  `echo $PKG | cut -f1 -d' '`
    r_install $PKG
  done
}

msg "Instalando lenguajes de programacion"
java -version 2> /dev/null
if [ $? -ne 0 ] ; then
   prg 1 Instalando Java
   apt-get install -y openjdk-21-jdk >> $FLOG 2>> $FERR
fi

python3 --version > /dev/null
if [ $? -ne 0 ] ; then
   msg 1 Instalando Python
   apt-get -y install python3 python3-pip >> $FLOG 2>> $FERR
   apt-get -y install python3-pycurl      >> $FLOG 2>> $FERR
fi

R --version > /dev/null
if [ $? -ne 0 ] ; then
   msg 1 Instalando R
   apt-get -y install r-base >> $FLOG 2>> $FERR
   Rscript $PRJ/bin/setup_r  >> $FLOG 2>> $FERR
fi
