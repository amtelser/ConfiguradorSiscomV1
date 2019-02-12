#!/bin/sh
# Arranca la instancia del servidor de comunicaciones
echo "Arrancando instancia CQRO-GL50-TEST"

cd /siscom/bin/

java -Djava.library.path=/usr/local/lib \
     -Xrunjdwp:transport=dt_socket,server=y,address=8703,suspend=n \
     -XX:+UseConcMarkSweepGC -XX:+UseParNewGC \
     -XX:+HeapDumpOnOutOfMemoryError \
     -Xms192m -Xmx192m \
     -XX:ReservedCodeCacheSize=256m \
     -XX:MaxGCPauseMillis=500 \
     -XX:-UseBiasedLocking \
     -jar ServidorComunicaciones.jar /siscom/instancias/CQRO-GL50-TEST/configuracion.xml

# ================================
# Generar bitacora de GC:
#         -XX:+PrintGCDetails -XX:+PrintGCDateStamps \
#         -Xloggc:CQRO-GL50-TEST-GC.log \
# Generar info del profiler
#         -Xrunhprof:heap=sites,file=CQRO-GL50-TEST.hprof.txt \

