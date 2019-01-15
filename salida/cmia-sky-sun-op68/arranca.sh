#!/bin/sh
# Arranca la instancia del servidor de comunicaciones
echo "Arrancando instancia CMIA-SKY-SUN-OP68"

cd /siscom/bin/

java -Djava.library.path=/usr/local/lib \
     -Xrunjdwp:transport=dt_socket,server=y,address=8868,suspend=n \
     -XX:+UseConcMarkSweepGC -XX:+UseParNewGC \
     -XX:+HeapDumpOnOutOfMemoryError \
     -Xms192m -Xmx192m \
     -XX:ReservedCodeCacheSize=256m \
     -XX:MaxGCPauseMillis=500 \
     -XX:-UseBiasedLocking \
     -jar ServidorComunicaciones.jar /siscom/instancias/CMIA-SKY-SUN-OP68/configuracion.xml

# ================================
# Generar bitacora de GC:
#         -XX:+PrintGCDetails -XX:+PrintGCDateStamps \
#         -Xloggc:CMIA-SKY-SUN-OP68-GC.log \
# Generar info del profiler
#         -Xrunhprof:heap=sites,file=CMIA-SKY-SUN-OP68.hprof.txt \

