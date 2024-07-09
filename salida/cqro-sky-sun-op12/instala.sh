#!/bin/sh

echo ""
echo "Script para instalar la instancia CQRO-SKY-SUN-OP12"
echo ""

if [ "$UID" != "0" ] ; then
    echo "Este script debe ser ejecutado por root"
    echo ""
    exit -1
fi

# Crea los directorios de la instancia
mkdir -p /siscom/instancias/CQRO-SKY-SUN-OP12/
mkdir -p /siscom/instancias/CQRO-SKY-SUN-OP12/log/
mkdir -p /siscom/instancias/CQRO-SKY-SUN-OP12/db/

# Hacer que arranca.sh sea ejecutable
chmod +x arranca.sh

# Copia los archivos de la instancia
cp configuracion.xml /siscom/instancias/CQRO-SKY-SUN-OP12/configuracion.xml
cp arranca.sh        /siscom/instancias/CQRO-SKY-SUN-OP12/arranca.sh

# Asignar el usuario al directorio de la instancia
chown -R siscom:siscom /siscom/instancias/CQRO-SKY-SUN-OP12

# Mueve el archivo de supervisord al directorio
cp cqro-sky-sun-op12.ini /etc/supervisord.d

echo "Terminamos!"
echo ""

exit 0

#EOF