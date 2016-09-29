#!/bin/sh

# Script para instalar la instancia {{! data['id_instancia'] }}

# Crea el directorio de la instancia
mkdir -p {{ data['ROOT'] }}/instancias/{{ data['id_instancia'] }}/

# Hacer que arranca.sh sea ejecutable
chmod +x arranca.sh

# Copia los archivos de la instancia
cp configuracion.xml {{ data['ROOT'] }}/instancias/{{ data['id_instancia'] }}/configuracion.xml
cp arranca.sh        {{ data['ROOT'] }}/instancias/{{ data['id_instancia'] }}/arranca.sh

# Asignar el usuario al directorio de la instancia
chown -R siscom:siscom {{ data['ROOT'] }}/instancias/{{ data['id_instancia'] }}

# Mueve el archivo de supervisord al directorio
cp *.ini /etc/supervisord.d

exit 0

#EOF
