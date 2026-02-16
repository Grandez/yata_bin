# YATA Program
## Scripts and tools

Previsto para mantenerlas herramientas de automataizacion del programa

### setup_master

Una vez decidida la platarforma inicial de desarrollo:
- Maquina virtual
- Lenguajes
- IDE's
- etc.

**setup_master** y el conjunto de scripts setup_xxx inicializan
la plataforma de desarrollo con las herramientas y lenguajes requeridos,
creando un entorno común y homogeneo para todos los integrantes del equipo

#### Uso

En el caso de crear la plataforma de desarrollo "_from scratch_", una vez creada,
y realizada las configuraciones iniciales:

- usuarios y grupos
- discos

1. Clonar el repositorio: git clone https://github.com/Grandez/yata_bin.git en `/yata/bin`
2. Ejecutar en ese directorio `./setup_master.sh`
3. Reiniciar la máquina virtual

