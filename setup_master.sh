#!/bin/bash

#####################################################################
# DEBE EJECUTARSE COMO root
#
# Script maestro de instalacion de software y configuracion
# para crear una plataforma de desarrollo para un (multi)proyecto
# "from scratch"
#
# Asume que se han hecho algunas tareas previas segun documentacion
# Como montaje de discos, definicion del variable PRJ, directorios,...
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
SCRIPTS=( setup_system setup_languages setup_docker setup_pacman setup_ide )
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
check_env && exit 1

source $PRJ/bin/common.sh  # Existe

for i in "${SCRIPTS[@]}" ; do . $PRJ/bin/$i.sh ; done

elapsed
