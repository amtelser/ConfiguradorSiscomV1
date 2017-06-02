#!/bin/sh

echo ""
echo "Script para instalar la instancia SUNTECH-PRUEBAS-561"
echo ""

if [ "$UID" != "0" ] ; then
    echo "Este script debe ser ejecutado por root"
    echo ""
    exit -1
fi

# Crea los directorios de la instancia
mkdir -p /siscom/instancias/SUNTECH-PRUEBAS-561/
mkdir -p /siscom/instancias/SUNTECH-PRUEBAS-561/log/
mkdir -p /siscom/instancias/SUNTECH-PRUEBAS-561/db/

# Hacer que arranca.sh sea ejecutable
chmod +x arranca.sh

# Copia los archivos de la instancia
cp configuracion.xml /siscom/instancias/SUNTECH-PRUEBAS-561/configuracion.xml
cp arranca.sh        /siscom/instancias/SUNTECH-PRUEBAS-561/arranca.sh

# Asignar el usuario al directorio de la instancia
chown -R siscom:siscom /siscom/instancias/SUNTECH-PRUEBAS-561

# Mueve el archivo de supervisord al directorio
cp suntech-pruebas-561.ini /etc/supervisord.d

echo "Terminamos!"
echo ""

exit 0

#EOF
