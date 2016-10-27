#!/bin/sh

# Script para instalar la instancia CMIA-SKY-SUN-OP2

# Crea los directorios de la instancia
mkdir -p /siscom/instancias/CMIA-SKY-SUN-OP2/
mkdir -p /siscom/instancias/CMIA-SKY-SUN-OP2/log/
mkdir -p /siscom/instancias/CMIA-SKY-SUN-OP2/db/

# Hacer que arranca.sh sea ejecutable
chmod +x arranca.sh

# Copia los archivos de la instancia
cp configuracion.xml /siscom/instancias/CMIA-SKY-SUN-OP2/configuracion.xml
cp arranca.sh        /siscom/instancias/CMIA-SKY-SUN-OP2/arranca.sh

# Asignar el usuario al directorio de la instancia
chown -R siscom:siscom /siscom/instancias/CMIA-SKY-SUN-OP2

# Mueve el archivo de supervisord al directorio
cp *.ini /etc/supervisord.d

exit 0

#EOF