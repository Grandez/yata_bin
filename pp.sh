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
echo "Rscript -e \'install.packages(c($res), dependencies=TRUE)\'"
  cmd="Rscript -e 'install.packages(c($res), dependencies=TRUE)'"
  # >> $FLOG 2>> $FERR
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
   msg 1 Instalando R
   r_packages
