#!/bin/sh

echo ""
echo "Script para instalar la instancia TICKET-210-GL50"
echo ""

if [ "$UID" != "0" ] ; then
    echo "Este script debe ser ejecutado por root"
    echo ""
    exit -1
fi

# Crea los directorios de la instancia
mkdir -p /siscom/instancias/TICKET-210-GL50/
mkdir -p /siscom/instancias/TICKET-210-GL50/log/
mkdir -p /siscom/instancias/TICKET-210-GL50/db/

# Hacer que arranca.sh sea ejecutable
chmod +x arranca.sh

# Copia los archivos de la instancia
cp configuracion.xml /siscom/instancias/TICKET-210-GL50/configuracion.xml
cp arranca.sh        /siscom/instancias/TICKET-210-GL50/arranca.sh

# Asignar el usuario al directorio de la instancia
chown -R siscom:siscom /siscom/instancias/TICKET-210-GL50

# Mueve el archivo de supervisord al directorio
cp ticket-210-gl50.ini /etc/supervisord.d

echo "Terminamos!"
echo ""

exit 0

#EOF
