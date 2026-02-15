if(!require('insight', quietly=T)) {
  install.packages('insight')
}
library('insight', quietly=T)

OLDWD=getwd()
NEWWD=paste(Sys.getenv("PRJ"), "logs",sep="/") 
setwd(NEWWD)

print_color("Instalando paquetes de R\n", "bright_blue")
print_color("Instalando paquetes basicos\n", "bright_white")
install.packages(c("tidyverse", "stringr", "ggplot2", "ggExtra"),
                 keep.outputs=NEWWD, dependencies=TRUE)


print_color("Instalando paquetes de edicion\n", "bright_white")
install.packages(c("knitr", "quarto"),
                 keep.outputs=NEWWD, dependencies=TRUE)

print_color("Instalando paquetes Web\n", "bright_white")
install.packages(c("shiny", "shinyjs", "bslib"),
                 keep.outputs=NEWWD, dependencies=TRUE)

setwd(OLDWD)
