#!/bin/sh

echo ""
echo "Script para instalar la instancia QUECLINK-PRUEBAS-550"
echo ""

if [ "$UID" != "0" ] ; then
    echo "Este script debe ser ejecutado por root"
    echo ""
    exit -1
fi

# Crea los directorios de la instancia
mkdir -p /siscom/instancias/QUECLINK-PRUEBAS-550/
mkdir -p /siscom/instancias/QUECLINK-PRUEBAS-550/log/
mkdir -p /siscom/instancias/QUECLINK-PRUEBAS-550/db/

# Hacer que arranca.sh sea ejecutable
chmod +x arranca.sh

# Copia los archivos de la instancia
cp configuracion.xml /siscom/instancias/QUECLINK-PRUEBAS-550/configuracion.xml
cp arranca.sh        /siscom/instancias/QUECLINK-PRUEBAS-550/arranca.sh

# Asignar el usuario al directorio de la instancia
chown -R siscom:siscom /siscom/instancias/QUECLINK-PRUEBAS-550

# Mueve el archivo de supervisord al directorio
cp queclink-pruebas-550.ini /etc/supervisord.d

echo "Terminamos!"
echo ""

exit 0

#EOF
