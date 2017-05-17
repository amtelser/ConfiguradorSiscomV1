#!/bin/sh

# Script para arreglar los permisos de los archivos

# 1. convertir a terminadores Unix los archivos
echo "1"
#find . -type f -exec echo "1:{}" "2:{}" \;
find . -type f -exec sh -c '[ "0$(file {} | grep -v CRLF)" = "0" ] && dos2unix {}' \;

# 2. cambia permisos de los archivos
echo "2"
find . -type f -exec chmod 644 {} \;

# 3. Hacer que los scripts sean ejecutables
echo "3"
find . -type f -name \*.sh -exec chmod 755 {} \;

# 4, cambiar los permisos de los directorios
echo "4"
find . -type d -exec chmod 755 {} \;

#EOF

