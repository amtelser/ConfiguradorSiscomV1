#!/bin/sh

echo ""
echo "Script para instalar la instancia CMIA-SKY-SUN-OP106"
echo ""

if [ "$UID" != "0" ] ; then
    echo "Este script debe ser ejecutado por root"
    echo ""
    exit -1
fi

# Crea los directorios de la instancia
mkdir -p /siscom/instancias/CMIA-SKY-SUN-OP106/
mkdir -p /siscom/instancias/CMIA-SKY-SUN-OP106/log/
mkdir -p /siscom/instancias/CMIA-SKY-SUN-OP106/db/

# Hacer que arranca.sh sea ejecutable
chmod +x arranca.sh

# Copia los archivos de la instancia
cp configuracion.xml /siscom/instancias/CMIA-SKY-SUN-OP106/configuracion.xml
cp arranca.sh        /siscom/instancias/CMIA-SKY-SUN-OP106/arranca.sh

# Asignar el usuario al directorio de la instancia
chown -R siscom:siscom /siscom/instancias/CMIA-SKY-SUN-OP106

# Mueve el archivo de supervisord al directorio
cp cmia-sky-sun-op106.ini /etc/supervisord.d

echo "Terminamos!"
echo ""

exit 0

#EOF