#!/bin/sh
# Arranca la instancia del servidor de comunicaciones
echo "Arrancando instancia CMIA-GV75-OP6"

cd /siscom/bin/

java -Djava.library.path=/usr/local/lib \
     -Xrunjdwp:transport=dt_socket,server=y,address=8910,suspend=n \
     -XX:+UseConcMarkSweepGC -XX:+UseParNewGC \
     -XX:+HeapDumpOnOutOfMemoryError \
     -Xms192m -Xmx192m \
     -XX:ReservedCodeCacheSize=256m \
     -XX:MaxGCPauseMillis=500 \
     -XX:-UseBiasedLocking \
     -jar ServidorComunicaciones.jar /siscom/instancias/CMIA-GV75-OP6/configuracion.xml

# ================================
# Generar bitacora de GC:
#         -XX:+PrintGCDetails -XX:+PrintGCDateStamps \
#         -Xloggc:CMIA-GV75-OP6-GC.log \
# Generar info del profiler
#         -Xrunhprof:heap=sites,file=CMIA-GV75-OP6.hprof.txt \

