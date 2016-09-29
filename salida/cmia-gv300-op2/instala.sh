#!/bin/sh

# Script para instalar la instancia CMIA-GV300-OP2

# Crea el directorio de la instancia
mkdir -p /siscom/instancias/CMIA-GV300-OP2/

# Hacer que arranca.sh sea ejecutable
chmod +x arranca.sh

# Copia los archivos de la instancia
cp configuracion.xml /siscom/instancias/CMIA-GV300-OP2/configuracion.xml
cp arranca.sh        /siscom/instancias/CMIA-GV300-OP2/arranca.sh

# Asignar el usuario al directorio de la instancia
chown -R siscom:siscom /siscom/instancias/CMIA-GV300-OP2

# Mueve el archivo de supervisord al directorio
cp *.ini /etc/supervisor.d

exit 0

#EOF
