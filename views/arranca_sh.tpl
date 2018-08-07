#!/bin/sh
# Arranca la instancia del servidor de comunicaciones
echo "Arrancando instancia {{ data['id_instancia'] }}"

cd {{ data['ROOT'] }}/bin/

java -Djava.library.path=/usr/local/lib \
     -Xrunjdwp:transport=dt_socket,server=y,address={{ data['puerto_debug'] }},suspend=n \
     -XX:+UseConcMarkSweepGC -XX:+UseParNewGC \
     -XX:+HeapDumpOnOutOfMemoryError \
     -Xms192m -Xmx192m \
     -XX:ReservedCodeCacheSize=256m \
     -XX:MaxGCPauseMillis=500 \
     -XX:-UseBiasedLocking \
     -jar ServidorComunicaciones.jar {{ data['ROOT'] }}/instancias/{{ data['id_instancia'] }}/configuracion.xml

# ================================
# Generar bitacora de GC:
#         -XX:+PrintGCDetails -XX:+PrintGCDateStamps \
#         -Xloggc:{{ data['id_instancia'] }}-GC.log \
# Generar info del profiler
#         -Xrunhprof:heap=sites,file={{ data['id_instancia'] }}.hprof.txt \

