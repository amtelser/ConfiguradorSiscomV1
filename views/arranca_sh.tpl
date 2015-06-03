#!/bin/sh
# Arranca el servidor de comunicaciones con debug
echo "Arrancando instancia {{ data['id_instancia'] }}"

cd {{ data['ROOT'] }}/bin/
java -Djava.library.path=/usr/local/lib ^
     -Xrunjdwp:transport=dt_socket,server=y,address={{ data['puerto_debug'] }},suspend=n ^
     -XX:+UseConcMarkSweepGC ^
     -XX:+PrintGCDetails -XX:+PrintGCDateStamps ^
     -XX:+HeapDumpOnOutOfMemoryError ^
     -Xms250m -Xmx250m ^
     -Xloggc:{{ data['id_instancia'] }}-GC.log ^
     -jar ServidorComunicaciones.jar {{ data['ROOT'] }}/{{ data['id_instancia'] }}/configuracion.xml

