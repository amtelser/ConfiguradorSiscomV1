REM Arranca la instancia del servidor de comunicaciones
title CMIA-GV300-OP2

:lazo
    c:
    cd c:\siscom\master-20160909\
    java -Djava.library.path=/usr/local/lib ^
         -Xrunjdwp:transport=dt_socket,server=y,address=8902,suspend=n ^
         -XX:+UseConcMarkSweepGC -XX:+UseParNewGC ^
         -XX:+HeapDumpOnOutOfMemoryError ^
         -Xms192m -Xmx192m ^
         -XX:PermSize=128M ^
         -XX:ReservedCodeCacheSize=256m ^
         -XX:MaxGCPauseMillis=500 ^
         -XX:-UseBiasedLocking ^
         -XX:+UseStringCache ^
         -jar ServidorComunicaciones.jar c:/siscom/instancias/CMIA-GV300-OP2/configuracion.xml
    goto lazo

REM ================================
REM Generar bitacora de GC:
REM         -XX:+PrintGCDetails -XX:+PrintGCDateStamps ^
REM         -Xloggc:CMIA-GV300-OP2-GC.log ^
REM Generar info del profiler
REM         -Xrunhprof:heap=sites,file=CMIA-GV300-OP2.hprof.txt ^
