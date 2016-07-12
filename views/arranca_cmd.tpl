REM Arranca la instancia del servidor de comunicaciones
title {{ data['id_instancia'] }}

:lazo
    c:
    cd c:\siscom\{{ data['tag_en_git'] }}\
    java -Djava.library.path=/usr/local/lib ^
         -Xrunjdwp:transport=dt_socket,server=y,address={{ data['puerto_debug'] }},suspend=n ^
         -XX:+UseConcMarkSweepGC -XX:+UseParNewGC ^
         -XX:+HeapDumpOnOutOfMemoryError ^
         -Xms192m -Xmx192m ^
         -XX:PermSize=128M ^
         -XX:ReservedCodeCacheSize=256m ^
         -XX:MaxGCPauseMillis=500 ^
         -XX:-UseBiasedLocking ^
         -XX:+UseStringCache ^
         -jar ServidorComunicaciones.jar c:/siscom/instancias/{{ data['id_instancia'] }}/configuracion.xml
    goto lazo

REM ================================
REM Generar bitacora de GC:
REM         -XX:+PrintGCDetails -XX:+PrintGCDateStamps ^
REM         -Xloggc:{{ data['id_instancia'] }}-GC.log ^
REM Generar info del profiler
REM         -Xrunhprof:heap=sites,file={{ data['id_instancia'] }}.hprof.txt ^
