#!/bin/sh

echo ""
echo "Script para instalar la instancia CQRO-GL50-TEST"
echo ""

if [ "$UID" != "0" ] ; then
    echo "Este script debe ser ejecutado por root"
    echo ""
    exit -1
fi

# Crea los directorios de la instancia
mkdir -p /siscom/instancias/CQRO-GL50-TEST/
mkdir -p /siscom/instancias/CQRO-GL50-TEST/log/
mkdir -p /siscom/instancias/CQRO-GL50-TEST/db/

# Hacer que arranca.sh sea ejecutable
chmod +x arranca.sh

# Copia los archivos de la instancia
cp configuracion.xml /siscom/instancias/CQRO-GL50-TEST/configuracion.xml
cp arranca.sh        /siscom/instancias/CQRO-GL50-TEST/arranca.sh

# Asignar el usuario al directorio de la instancia
chown -R siscom:siscom /siscom/instancias/CQRO-GL50-TEST

# Mueve el archivo de supervisord al directorio
cp cqro-gl50-test.ini /etc/supervisord.d

echo "Terminamos!"
echo ""

exit 0

#EOF
