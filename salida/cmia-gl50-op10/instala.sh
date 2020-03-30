#!/bin/sh

echo ""
echo "Script para instalar la instancia CMIA-GL50-OP10"
echo ""

if [ "$UID" != "0" ] ; then
    echo "Este script debe ser ejecutado por root"
    echo ""
    exit -1
fi

# Crea los directorios de la instancia
mkdir -p /siscom/instancias/CMIA-GL50-OP10/
mkdir -p /siscom/instancias/CMIA-GL50-OP10/log/
mkdir -p /siscom/instancias/CMIA-GL50-OP10/db/

# Hacer que arranca.sh sea ejecutable
chmod +x arranca.sh

# Copia los archivos de la instancia
cp configuracion.xml /siscom/instancias/CMIA-GL50-OP10/configuracion.xml
cp arranca.sh        /siscom/instancias/CMIA-GL50-OP10/arranca.sh

# Asignar el usuario al directorio de la instancia
chown -R siscom:siscom /siscom/instancias/CMIA-GL50-OP10

# Mueve el archivo de supervisord al directorio
cp cmia-gl50-op10.ini /etc/supervisord.d

echo "Terminamos!"
echo ""

exit 0

#EOF
