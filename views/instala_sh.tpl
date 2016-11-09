#!/bin/sh

echo ""
echo "Script para instalar la instancia {{! data['id_instancia'] }}"
echo ""

if [ "$UID" != "0" ] ; then
    echo "Este script debe ser ejecutado por root"
    echo ""
    exit -1
fi

# Crea los directorios de la instancia
mkdir -p {{ data['ROOT'] }}/instancias/{{ data['id_instancia'] }}/
mkdir -p {{ data['ROOT'] }}/instancias/{{ data['id_instancia'] }}/log/
mkdir -p {{ data['ROOT'] }}/instancias/{{ data['id_instancia'] }}/db/

# Hacer que arranca.sh sea ejecutable
chmod +x arranca.sh

# Copia los archivos de la instancia
cp configuracion.xml {{ data['ROOT'] }}/instancias/{{ data['id_instancia'] }}/configuracion.xml
cp arranca.sh        {{ data['ROOT'] }}/instancias/{{ data['id_instancia'] }}/arranca.sh

# Asignar el usuario al directorio de la instancia
chown -R siscom:siscom {{ data['ROOT'] }}/instancias/{{ data['id_instancia'] }}

# Mueve el archivo de supervisord al directorio
cp {{ data['id_instancia_lower'] }}.ini /etc/supervisord.d

echo "Terminamos!"
echo ""

exit 0

#EOF
