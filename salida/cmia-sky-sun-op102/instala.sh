#!/bin/sh

echo ""
echo "Script para instalar la instancia CMIA-SKY-SUN-OP102"
echo ""

if [ "$UID" != "0" ] ; then
    echo "Este script debe ser ejecutado por root"
    echo ""
    exit -1
fi

# Crea los directorios de la instancia
mkdir -p /siscom/instancias/CMIA-SKY-SUN-OP102/
mkdir -p /siscom/instancias/CMIA-SKY-SUN-OP102/log/
mkdir -p /siscom/instancias/CMIA-SKY-SUN-OP102/db/

# Hacer que arranca.sh sea ejecutable
chmod +x arranca.sh

# Copia los archivos de la instancia
cp configuracion.xml /siscom/instancias/CMIA-SKY-SUN-OP102/configuracion.xml
cp arranca.sh        /siscom/instancias/CMIA-SKY-SUN-OP102/arranca.sh

# Asignar el usuario al directorio de la instancia
chown -R siscom:siscom /siscom/instancias/CMIA-SKY-SUN-OP102

# Mueve el archivo de supervisord al directorio
cp cmia-sky-sun-op102.ini /etc/supervisord.d

echo "Terminamos!"
echo ""

exit 0

#EOF
