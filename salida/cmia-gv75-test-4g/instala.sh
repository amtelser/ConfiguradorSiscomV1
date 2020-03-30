#!/bin/sh

echo ""
echo "Script para instalar la instancia CMIA-GV75-TEST-4G"
echo ""

if [ "$UID" != "0" ] ; then
    echo "Este script debe ser ejecutado por root"
    echo ""
    exit -1
fi

# Crea los directorios de la instancia
mkdir -p /siscom/instancias/CMIA-GV75-TEST-4G/
mkdir -p /siscom/instancias/CMIA-GV75-TEST-4G/log/
mkdir -p /siscom/instancias/CMIA-GV75-TEST-4G/db/

# Hacer que arranca.sh sea ejecutable
chmod +x arranca.sh

# Copia los archivos de la instancia
cp configuracion.xml /siscom/instancias/CMIA-GV75-TEST-4G/configuracion.xml
cp arranca.sh        /siscom/instancias/CMIA-GV75-TEST-4G/arranca.sh

# Asignar el usuario al directorio de la instancia
chown -R siscom:siscom /siscom/instancias/CMIA-GV75-TEST-4G

# Mueve el archivo de supervisord al directorio
cp cmia-gv75-test-4g.ini /etc/supervisord.d

echo "Terminamos!"
echo ""

exit 0

#EOF
