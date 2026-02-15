###########################################################
# Codigo base para el resto de scripts
# Se asume que existe la variable de entorno PROJECT
# Se incluye con source ${PROJECT}/bin/base.sh
###########################################################

###########################################################
# Colors
# Background = color + 10
# Bold       = 1
# Faint      = 2
# Italic     = 3
# Underline  = 4
###########################################################

COMMON=

RESET=0
BLACK=30
RED=31
GREEN=32
YELLOW=33
BLUE=34
MAGENTA=35
CIAN=36
GRAY=37

WHITE=97

NC='\e[0m'

# Obtener la fecha de inicio y losficheros de logging
BEGIN=`date +%s`
SCRIPT=${0##*/}
SCRIPT=${SCRIPT%.*}
FLOG=${PRJ}/logs/${SCRIPT}.log
FERR=${PRJ}/logs/${SCRIPT}.err

# Funciones
msg () {
    echo -e "\e[1;${WHITE}m"`date +%T` - $*${NC}
}
err () {
    echo -e "\e[1;${RED}m"`date +%T` - $*${NC}
}
info () {
    echo -e "\e[1;${BLUE}m"`date +%T` - $*${NC}
}
prg() {
   LEVEL=$1
   shift
   echo -en "\e[0;${WHITE}m"`date +%T` -
   for i in {0..1} ; do echo -n "  " ; done
   echo -e $*${NC}
}

