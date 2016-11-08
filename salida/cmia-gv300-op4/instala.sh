#!/bin/sh

echo ""
echo "Script para instalar la instancia CMIA-GV300-OP4"
echo ""

if [ "$UID" != "0" ] ; then
    echo "Este script debe ser ejecutado por root"
    echo ""
fi

# Crea los directorios de la instancia
mkdir -p /siscom/instancias/CMIA-GV300-OP4/
mkdir -p /siscom/instancias/CMIA-GV300-OP4/log/
mkdir -p /siscom/instancias/CMIA-GV300-OP4/db/

# Hacer que arranca.sh sea ejecutable
chmod +x arranca.sh

# Copia los archivos de la instancia
cp configuracion.xml /siscom/instancias/CMIA-GV300-OP4/configuracion.xml
cp arranca.sh        /siscom/instancias/CMIA-GV300-OP4/arranca.sh

# Asignar el usuario al directorio de la instancia
chown -R siscom:siscom /siscom/instancias/CMIA-GV300-OP4

# Mueve el archivo de supervisord al directorio
cp cmia-gv300-op4.ini /etc/supervisord.d

echo "Terminamos!"
echo ""

exit 0

#EOF
