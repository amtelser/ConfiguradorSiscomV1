<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : configuracion.xml
    Author     : RSchiavon
    Description: Definicion de la configuracion del servidor
-->

<configuracion>
    <!--
        ********************************************************************************
        Pseudo modulo del servidor
        (Notese que la clase esta vacia)
        ********************************************************************************
    -->
    <modulo>
        <nombre>Servidor</nombre>
        <descripcion>Servidor del sistema</descripcion>
        <clase></clase>
        <parametros>
            <!-- Nombre del servidor -->
            <parametro nombre="nombreServidor" valor="{{! data['nombre_instancia'] }}" />
            <!-- identificador unico del servidor.
                 Regla:
                 -  Solo letras, numeros y guines (-)
                 -  32 caracteres maximo
            -->
            <!--                                          0         1        2         3   -->
            <!--                                          12345678901234567890123456789012 -->
            <parametro nombre="identificadorUnico" valor="{{! data['id_instancia'] }}" />
            <!-- Directorio de la bitacora del servidor -->
            <parametro nombre="directorioBitacora" valor="{{! data['ROOT'] }}/instancias/{{! data['id_instancia'].upper() }}/log" />
            <!-- Nivel de bitacora (DEBUG, INFO, WARN, ERROR) -->
            <parametro nombre="nivelBitacora" valor="WARN" />
            <parametro nombre="nivelBitacoraConsola" valor="WARN" />
            <!-- Puerto ZMQ del sincronizador -->
            <parametro nombre="puertoSincronizador" valor="{{! str(int(data['puerto_base']) + 0) }}" />
            <!-- Direccion IP a la red de equipos -->
            <parametro nombre="direccionIpRedEquipos" valor="{{! data['ip_red_equipos'] }}" />
            <!-- Direccion IP a la red local -->
            <parametro nombre="direccionIpRedLocal" valor="{{! data['ip_red_admin'] }}" />
            <!-- Servidor _NO_ autonomo (mantiene una base de datos local minima) -->
            <parametro nombre="servidorAutonomo" valor="no" />
            <!-- Generar un progress bar? (si|no) -->
            <parametro nombre="progressBarActivo" valor="{{! data['progress_bar_activo'] }}" />
        </parametros>
    </modulo>

    <!--
        ********************************************************************************
        Pseudo modulo del supervisor del sistema
        (Notese que la clase esta vacia)
        ********************************************************************************
    -->
    <modulo>
        <nombre>Supervisor</nombre>
        <descripcion>Modulo supervisor del sistema</descripcion>
        <clase></clase>
        <parametros></parametros>
    </modulo>

    <!--
        ********************************************************************************
        Pseudo modulo de interfase entre el servidor el exterior
        (Notese que la clase esta vacia)
        ********************************************************************************
    -->
    <modulo>
        <nombre>InterfaseExterior</nombre>
        <descripcion>Interfase entre el servidor el exterior</descripcion>
        <clase></clase>
        <parametros>
            <parametro nombre="puertoVigilante" valor="{{! str(int(data['puerto_base']) + 1) }}" />
            <parametro nombre="puertoTxExterno" valor="{{! str(int(data['puerto_base']) + 2) }}" />
            <parametro nombre="puertoRxExterno" valor="{{! str(int(data['puerto_base']) + 3) }}" />
            <!-- tiempo en milisegundos para el muestreo del vigilante -->
            <parametro nombre="tiempoMuestreoVigilante" valor="3000" />
            <!-- longitud del buffer del vigilante -->
            <parametro nombre="longitudBufferVigilante" valor="512" />
            <!-- Puerto del publicador de diagnosticos -->
            <parametro nombre="puertoPubDiagnosticos" valor="{{! str(int(data['puerto_base']) + 10) }}" />
        </parametros>
    </modulo>

    <!--
        ********************************************************************************
        Pseudo modulo de reporte de errores por email
        (Notese que la clase esta vacia)
        ********************************************************************************
    -->
    <modulo>
        <nombre>ReporteDeErroresPorEmail</nombre>
        <descripcion>Reporte de errores por email</descripcion>
        <clase></clase>
        <parametros>
            <!-- Envio de email de errores del servidor-->
            <!-- Servidor de SMTP para enviar emails de errores -->
            <parametro nombre="servidorSmtp" valor="mail2.encontrack.com" />
%if data['tipo_equipos'] == 'SUNTECH':
            <parametro nombre="direccionElectronica" valor="suntech@encontrack.com" />
% end
%if data['tipo_equipos'] == 'QUECLINK':
            <parametro nombre="direccionElectronica" valor="queclink@encontrack.com" />
% end
            <parametro nombre="direccionElectronicaCc" valor="" />
            <parametro nombre="maxErroresPendientes" valor="20" />
            <parametro nombre="tiempoEspera" valor="60" />
        </parametros>
    </modulo>

    <!--
        ********************************************************************************
        Pseudo modulo del manejador de la base de datos
        (Notese que la clase esta vacia)
        ********************************************************************************
    -->
    <modulo>
        <nombre>ManejadorBaseDatos</nombre>
        <descripcion>Manejador de la base de datos</descripcion>
        <clase></clase>
        <parametros>
            <!--
                URL para la conexion a la base de datos (;IF_EXISTS=TRUE)
                NOTA: %s se reeplaza con el identificadorUnico (ver modulo Sevidor arriba)
            -->
            <parametro nombre="url" valor="jdbc:h2:{{! data['ROOT'] }}/instancias/{{! data['id_instancia'].upper() }}/db/%s;AUTO_SERVER=TRUE;MVCC=TRUE" />
            <!-- Numero maximo de conexiones del pool -->
            <parametro nombre="maxConexiones" valor="30" />
            <!-- Puerto recepcion INSERT, UPDATE, DELETE -->
            <parametro nombre="puertoUpdate" valor="{{! str(int(data['puerto_base']) + 4) }}" />
            <!-- Puerto recepcion SELECT, CALL -->
            <parametro nombre="puertoSelect" valor="{{! str(int(data['puerto_base']) + 5) }}" />
        </parametros>
    </modulo>

    <!--
        ****************************************
        Modulo de comunicaciones con los equipos
        ****************************************
    -->
%if data['tipo_equipos'] == 'SUNTECH':
    <modulo>
        <nombre>ComunicacionEquipos</nombre>
        <descripcion>Modulo de comunicacion con los equipos</descripcion>
        <clase>com.encontrack.sistemacomunicaciones.servidor.equipos.Suntech.ManejadorComunicacionesSuntech</clase>
        <parametros>
            <!-- puerto de recepcion de eventos y alarmas -->
            <parametro nombre="puertoRxEventosAlarmas" valor="{{! data['puerto_rx_notificaciones'] }}" />
            <!-- numero de threads para recepcion de eventos y alarmas -->
            <parametro nombre="numThreadsRxEventosAlarmas" valor="1" />
            <!-- clase del manejador de comandos -->
            <parametro nombre="puertoTxComandos" valor="{{! data['puerto_tx_comandos'] }}" />
            <!-- tiempo maximo de espera de la respuesta (en segundos) -->
            <parametro nombre="maxTiempoEspera" valor="30" />
            <!-- numero maximo de intentos -->
            <parametro nombre="maxIntentos" valor="3" />
            <!-- numero de threads para ejecutar comandos -->
            <parametro nombre="numThreadsComandos" valor="30" />
            <!-- umbral de bajo voltaje de bateria en Volts-->
            <parametro nombre="umbralBajoVoltajeBateria" valor="4.0" />
            <!-- umbral superior para detener comunicaciones.
                 Un valor de 0 (cero) elimina la detencion de comunicaciones -->
            <parametro nombre="umbralSuperiorComunicaciones" valor="200" />
            <!-- umbral inferior para detener comunicaciones -->
            <parametro nombre="umbralInferiorComunicaciones" valor="50" />
            <!-- puerto publicador de sobreflujo -->
            <parametro nombre="puertoPubSobreFlujo" valor="{{! str(int(data['puerto_base']) + 33) }}" />
        </parametros>
    </modulo>
%end
%if data['tipo_equipos'] == 'QUECLINK':
    <modulo>
        <nombre>ComunicacionEquipos</nombre>
        <descripcion>Modulo de comunicacion con los equipos</descripcion>
        <clase>com.encontrack.sistemacomunicaciones.servidor.equipos.queclink.ManejadorComunicacionesQueclink</clase>
        <parametros>
            <!-- puerto de comunicaciones con equipos -->
            <parametro nombre="puertoComunicaciones" valor="{{! data['puerto_rx_notificaciones'] }}" />
            <!-- milisegundos de espera a recibir un mensaje de los equipos -->
            <parametro nombre="mSecEsperaMensaje" valor="200" />
            <!-- numero de threads para recepcion de eventos y alarmas -->
            <parametro nombre="numThreadsRxEventosAlarmas" valor="1" />
            <!-- tiempo maximo de espera de la respuesta (en segundos) -->
            <parametro nombre="maxTiempoEspera" valor="30" />
            <!-- numero maximo de intentos -->
            <parametro nombre="maxIntentos" valor="3" />
            <!-- numero de threads para ejecutar comandos -->
            <parametro nombre="numThreadsComandos" valor="30" />
            <!-- umbral superior para detener comunicaciones -->
            <parametro nombre="umbralSuperiorComunicaciones" valor="200" />
            <!-- umbral inferior para detener comunicaciones -->
            <parametro nombre="umbralInferiorComunicaciones" valor="50" />
            <!-- puerto publicador de paquetes -->
            <parametro nombre="puertoPubPaquetes" valor="{{! str(int(data['puerto_base']) + 35) }}" />
        </parametros>
    </modulo>
%end

    <!--
        ****************************************
        Modulo de interfase entre el manejador de
        comunicaciones y el manejador de informacion
        ****************************************
    -->
    <modulo>
        <nombre>InterfaseComunicacionesInformacion</nombre>
        <descripcion>Modulo de comunicacion con los equipos</descripcion>
        <clase>com.encontrack.sistemacomunicaciones.servidor.comunicaciones.InterfaseComunicacionesInformacion</clase>
        <parametros>
            <!-- direccion de ip del servidor con el manejador de informacion -->
            <parametro nombre="direccionIpManejadorInformacion" valor="127.0.0.1" />
            <!-- puerto de envio de eventos y alarmas -->
            <parametro nombre="puertoTxEventosAlarmas" valor="{{! str(int(data['puerto_base']) + 6) }}" />
            <!-- puerto de recepcion de comandos -->
            <parametro nombre="puertoRxComandos" valor="{{! str(int(data['puerto_base']) + 7) }}" />
            <!-- puerto de envio de resultados de comandos -->
            <parametro nombre="puertoTxResultadosCmds" valor="{{! str(int(data['puerto_base']) + 8) }}" />
            <!-- puerto publicador de paquetes -->
            <parametro nombre="puertoPubPaquetes" valor="{{! str(int(data['puerto_base']) + 35) }}" />
            <!-- puerto publicador de comunicaciones recibidas de equipos -->
            <parametro nombre="puertoPubComunicaciones" valor="{{! str(int(data['puerto_base']) + 26) }}" />
        </parametros>
    </modulo>

    <!--
        **********************************************************
        Modulo de interfase con la base de datos Cache
        **********************************************************
    -->
    <modulo>
        <nombre>SoporteCache</nombre>
        <descripcion>Modulo de interfase con la base de datos Cache</descripcion>
        <clase>com.encontrack.sistemacomunicaciones.interfasecache.SoporteCache</clase>
        <parametros>
            <parametro nombre="direccionIpCache" valor="cache.encontrack.com" />
            <parametro nombre="puertoCache" valor="1972" />
            <parametro nombre="nombreBaseDeDatos" valor="FERGUISAPROD" />
            <parametro nombre="usuarioBd" valor="rafael" />
            <parametro nombre="pwdBd" valor="rafaS1110"/>
            <parametro nombre="tablaBitacoraComs" valor="{{! data['tabla_bitacora'] }}" />
            <!--
                Canales de comunicacion
                =======================
                Este parametro indica los canales de comunicacion manejador por
                esta interfase.
                Cada canal esta entre comillas sencillas y los canales se
                separan por comas.

                Por ejemplo:
                    'CANAL-01','CANAL-02','CANAL-03'
            -->
            <parametro nombre="canales" valor="{{! data['canales'] }}" />
            <!-- Servicio de geo-referenciador -->
            <parametro nombre="servidorGeodecodificador" valor="10.190.6.60" />
            <parametro nombre="puertoGeodecodificador" valor="64080" />
            <!-- Numero de conexiones a la base de datos Cache -->
            <parametro nombre="numConexionesCache" valor="{{! data['num_conexiones_cache'] }}" />
            <!-- Usar metodos de procesados (default: no) -->
            <parametro nombre="usarMetodosP" valor="{{! data['usar_metodos_p'] }}" />
        </parametros>
    </modulo>

    <!--
        **********************************************************
        Modulo manejador de equipos
        **********************************************************
    -->
    <modulo>
        <nombre>ManejadorEquiposCache</nombre>
        <descripcion>Modulo manejador de equipos</descripcion>
        <clase>com.encontrack.sistemacomunicaciones.interfasecache.ManejadorEquiposCache</clase>
        <parametros>
            <!-- Periodo de actualizacion de la lista de equipos manejados en segundos -->
            <parametro nombre="periodoActualizacionListaEquipos" valor="600" />
            <!-- Direccion IP del MMI para actualizar equipos -->
            <parametro nombre="direccionIpManejadorInformacion" valor="127.0.0.1" />
            <!-- Puerto de comunicacion para actualizar la lista de equipos -->
            <parametro nombre="puertoActualizacionEquipos" valor="{{! str(int(data['puerto_base']) + 30) }}" />
            <!--
                Tipo de equipo que se maneja. Valores validos son:
                SUNTECH
                QUECLINK
                SKYPATROL
                CELLOCATOR
            <parametro nombre="tipoDeEquipo" valor="QUECLINK" />
            -->
% if data['tipo_equipos'] == 'SUNTECH':
            <parametro nombre="tipoDeEquipo" valor="SUNTECH" />
% end
% if data['tipo_equipos'] == 'QUECLINK':
            <parametro nombre="tipoDeEquipo" valor="QUECLINK" />
% end
            <!-- puerto publicador de contadores de paquetes -->
            <parametro nombre="puertoPubContadorPaquetes" valor="{{! str(int(data['puerto_base']) + 34) }}" />
        </parametros>
    </modulo>

    <!--
        **********************************************************
        Modulo procesador de notificaciones de equipos
        **********************************************************
    -->
    <modulo>
        <nombre>ProcesadorNotificacionesCache</nombre>
        <descripcion>Modulo procesador de eventos y alarmas de equipos</descripcion>
        <clase>com.encontrack.sistemacomunicaciones.interfasecache.ProcesadorNotificacionesCache</clase>
        <parametros>
            <!-- direccion de ip del servidor MMI -->
            <parametro nombre="direccionIpMMI" valor="127.0.0.1" />
            <!-- puerto publicador de notificaciones del MMI -->
            <parametro nombre="puertoNotificaciones" valor="{{! str(int(data['puerto_base']) + 26) }}" />
            <!-- Numero de threads para procesar notificaciones (default=10) -->
            <parametro nombre="numThreadsNotificaciones" valor="25" />
            <!-- Habilitar (si, default)/Deshabilitar (no) insertar trayectos en TRAYECTOSUNTECH -->
            <parametro nombre="habilitarTrayectoSuntech" valor="no" />
            <!-- Filtrar notificaciones MobilEye con ceros (si/no (default)) -->
            <parametro nombre="filtrarMobilEye" valor="{{! data['filtrar_mobil_eye'] }}" />
            <!-- Geo-referenciar notificaciones -->
            <parametro nombre="geoReferenciar" valor="{{! data['geo_referenciar'] }}" />
        </parametros>
    </modulo>

    <!--
        **********************************************************
        Modulo procesador de comandos a equipos
        **********************************************************
    -->
    <modulo>
        <nombre>ProcesadorComandosCache</nombre>
        <descripcion>Modulo procesador de comandos</descripcion>
        <clase>com.encontrack.sistemacomunicaciones.interfasecache.ProcesadorComandosCache</clase>
        <parametros>
            <!-- Periodo de muestreo de la tabla SALIDAGSM en segundos -->
            <parametro nombre="periodoMuestreoSalidaGsm" valor="10" />
            <!-- Numero de threads para la ejecucion de salidas gsm -->
            <parametro nombre="numThreadsEjecucionSalidasGsm" valor="30" />
            <!-- direccion de ip del servidor MMI -->
            <parametro nombre="direccionIpMMI" valor="127.0.0.1" />
            <!-- puerto publicador de notificaciones del MMI -->
            <parametro nombre="puertoVentanilla" valor="{{! str(int(data['puerto_base']) + 29) }}" />
            <!-- Tiempo maximo de espera de la ejecucion de comandos en segundos -->
            <!-- 360 segundos = 6 minutos para compensar hasta 5 comunicaciones -->
            <parametro nombre="tiempoMaxEjecucionComandos" valor="360" />
            <!-- Puerto para recibir solicitudes de comandos a Cache -->
            <parametro nombre="puertoSolicitudComandos" valor="{{! str(int(data['puerto_base']) + 31) }}" />
            <!-- Puerto para publicar cambios de estado de comandos de Cache -->
            <parametro nombre="puertoPubEstadosComandos" valor="{{! str(int(data['puerto_base']) + 32) }}" />
        </parametros>
    </modulo>

    <!--
        **********************************************************
        Modulo procesador de trayectos
        **********************************************************
    -->
    <modulo>
        <nombre>ProcesadorTrayectosCache</nombre>
        <descripcion>Modulo procesador de trayectos</descripcion>
        <clase>com.encontrack.sistemacomunicaciones.interfasecache.ProcesadorTrayectosCache</clase>
        <parametros>
            <!-- Tiempo maximo de espera de una notificacion RET antes de sintetizar -->
            <parametro nombre="maxTiempoEsperaRet" valor="10" />
            <!-- Numero de trayectos en cierre activos -->
            <parametro nombre="int numTrayectosCierreActivos" valor="50" />
        </parametros>
    </modulo>

    <!--
        **********************************************************
        Modulo procesador de comandos provenientes de sistemas OTA
        **********************************************************
    -->
    <modulo>
        <nombre>ProcesadorComandosOTA</nombre>
        <descripcion>Modulo de comandos de sistemas OTA</descripcion>
        <clase>com.encontrack.sistemacomunicaciones.interfasecache.ProcesadorComandosOTA</clase>
        <parametros>
            <!-- Puerto de recepcion de solicitudes de comandos -->
            <parametro nombre="puertoSolicitudes" valor="{{! str(int(data['puerto_base']) + 37) }}" />
            <!-- Puerto de publicacion de resultados de comandos -->
            <parametro nombre="puertoPubResultados" valor="{{! str(int(data['puerto_base']) + 38) }}" />
            <!-- Numero de threads a usar para ejecutar comandos -->
            <parametro nombre="numThreadsEjecucionComandos" valor="8" />
        </parametros>
    </modulo>

    <!--
        ********************************
        Modulo procesador de seguimiento
        ********************************
    -->
    <modulo>
        <nombre>ProcesadorSeguimiento</nombre>
        <descripcion>Modulo procesador de comandos de seguimiento</descripcion>
        <clase>com.encontrack.sistemacomunicaciones.interfasecache.ProcesadorSeguimiento</clase>
        <parametros>
            <!-- Duracion del seguimiento en segundos (10 minutos por default) -->
            <parametro nombre="duracionSeguimiento" valor="600" />
            <!-- Periodo de solicitudes de posicion en segundos (1 por minuto) -->
            <parametro nombre="periodoEntreSolicitudesPosicion" valor="60" />
        </parametros>
    </modulo>

    <!--
        ********************************************************************************
        Modulo para la detccion de robos
        ********************************************************************************
    -->
    <modulo>
        <nombre>DetectorRobos</nombre>
        <descripcion>Modulo para la deteccion de robos</descripcion>
        <clase>com.encontrack.sistemacomunicaciones.interfasecache.DetectorRobos</clase>
        <parametros>
            <!-- Servidor de SMTP para enviar emails  -->
            <parametro nombre="servidorSmtp" valor="mail2.encontrack.com" />
            <!-- Quien recibe los emails de robos -->
            <parametro nombre="direccionEmailReporteRobos" valor="alarmas.robos@encontrack.com" />
            <!-- Quien recibe los emails de falsos contactos -->
            <parametro nombre="direccionEmailReporteFalsosContactos" valor="rafael.schiavon@encontrack.com" />
            <!-- Esperamos un maximo de 2 horas (60 Sec/Min * 60 Min/Hr * 2) -->
            <parametro nombre="tiempoMaxEsperaNotifRobo" valor="7200" />
            <!-- Numero maximo de falsos contactos antes de enviar el email -->
            <parametro nombre="numMaxFalsosContactos" valor="100" />
            <!-- Tiempo de congelamiento al detectar un robo en segundos (30 minutos) -->
            <parametro nombre="tiempoCongelamientoRobo" valor="1800" />
            <!-- Tiempo de congelamiento al detectar un falso contacto en segundos (24 horas) -->
            <parametro nombre="tiempoCongelamientoFalso" valor="86400" />
            <!-- Habilitar el inicio de seguimiento al detectar un robo -->
            <parametro nombre="iniciarSeguimientoRobo" valor="no" />
        </parametros>
    </modulo>

    <!--
        **********************************************************
        Modulo procesador de reservaciones
        **********************************************************
    -->
    <modulo>
        <nombre>ProcesadorReservaciones</nombre>
        <descripcion>Modulo procesador de reservaciones</descripcion>
        <clase>com.encontrack.sistemacomunicaciones.manejadorinformacion.ProcesadorReservaciones</clase>
        <parametros>
            <parametro nombre="puertoUdpEscucha" valor="{{! str(int(data['puerto_base']) + 40) }}" />
        </parametros>
    </modulo>

    <!--
        **********************************************************
        Modulo de interfase con Nagios
        **********************************************************
    -->
    <modulo>
        <nombre>InterfaseNagios</nombre>
        <descripcion>Modulo de interfase con Nagios</descripcion>
        <clase>com.encontrack.sistemacomunicaciones.servidor.interfasenagios.InterfaseNagios</clase>
        <parametros>
            <!-- Puerto HTTP -->
            <parametro nombre="puertoHttp" valor="{{! data['puerto_nagios'] }}" />
        </parametros>
    </modulo>

</configuracion>
