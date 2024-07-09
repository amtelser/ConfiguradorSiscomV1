#
# Generador de configuraciones

from __future__ import print_function
import csv
import importlib as imp
import bottle
import os
import stat
import sys
import tarfile

if len(sys.argv) > 1:
    tag_en_git = sys.argv[1]
else:
    tag_en_git = 'bin'

INFO_INSTANCIAS = 'configuraciones.csv'
TEMPLATE_CONFIG = 'configuracion_xml'
TEMPLATE_STUP_LIN = 'arranca_sh'
#-DEPRECADO-#TEMPLATE_STUP_WIN = 'arranca_cmd'
TEMPLATE_SUPERVISOR = 'supervisor_ini'
TEMPLATE_INSTALA = 'instala_sh'
DIR_SALIDA = 'salida'

reglas = [
    {'nombre': 'id_instancia', 'campos': ['id_instancia']},
    {'nombre': 'nombre_corto', 'campos': ['nombre_corto']},
    {'nombre': 'puerto_base_drp', 'campos': ['puerto_base_drp']},
    {'nombre': 'puerto_base', 'campos': ['ip_red_admin', 'puerto_base']},
    {'nombre': 'puerto_rx_notificaciones', 'campos': ['ip_red_equipos', 'puerto_rx_notificaciones']},
    {'nombre': 'puerto_tx_comandos', 'campos': ['ip_red_equipos', 'puerto_tx_comandos']},
    {'nombre': 'puerto_nagios', 'campos': ['ip_red_admin', 'puerto_nagios']},
    {'nombre': 'puerto_ejercitador', 'campos': ['puerto_ejercitador']},
    {'nombre': 'puerto_nagios', 'campos': ['puerto_nagios']},
    # Casos especiales
    {'nombre': 'canales', 'campo': 'canales', 'separador': ','},
]

def valida_campos(campos):
    '''Valida los campos en el archivo contra las reglas'''
    for regla in reglas:
        regla['lista'] = []
        regla['valida'] = True
        if 'separador' in regla:
            if not regla['campo'] in campos:
                print('La regla [{0}] contiene el campo invalido [{1}]'.format(regla['nombre'], campo))
                regla['valida'] = False
        else:
            for campo in regla['campos']:
                if not campo in campos:
                    print('La regla [{0}] contiene el campo invalido [{1}]'.format(regla['nombre'], campo))
                    regla['valida'] = False
    return

def valida_instancia(instancia):
    '''Valida la informacion de una instancia'''
    for regla in reglas:
        if not regla['valida']:
            continue
        # solo reglas validas
        if 'separador' in regla:
            campos = instancia[regla['campo']].split(regla['separador'])
            for campo in campos:
                if campo in regla['lista']:
                    print('Campo dupicado [{0}] en regla [{1}] @ [{2}]'.
                          format(campo, regla['nombre'], instancia['id_instancia']))
                regla['lista'].append(campo)
        else:
            campos = []
            for campo in regla['campos']:
                campos.append(instancia[campo])
            campo = ':'.join(campos)
            if campo in regla['lista']:
                print('Campo dupicado [{0}] en regla [{1}] @ [{2}]'.
                      format(campo, regla['nombre'], instancia['id_instancia']))
            regla['lista'].append(campo)
    return

f = open(INFO_INSTANCIAS)
try:
    f_csv = csv.reader(f)
    campos = next(f_csv)
    valida_campos(campos)
    for info in f_csv:
        datos = zip(campos, info)
        data = {}
        id_instancia = ''
        for i, tup in enumerate(datos):
            if tup[0] == 'id_instancia':
                id_instancia = tup[1].lower()
            data[tup[0]] = tup[1]
        data['id_instancia_lower'] = id_instancia
        data['tag_en_git'] = tag_en_git
        valida_instancia(data)

        configuracion = bottle.template(TEMPLATE_CONFIG, data=data)
#-DEPRECADO-#        arranca_win = bottle.template(TEMPLATE_STUP_WIN, data=data)
        arranca_lin = bottle.template(TEMPLATE_STUP_LIN, data=data)
        supervisor_ini = bottle.template(TEMPLATE_SUPERVISOR, data=data)
        instala_lin = bottle.template(TEMPLATE_INSTALA, data=data)

        dir_instancia = '{1}{0}{2}{0}'.format(os.sep, DIR_SALIDA, id_instancia)
        # crear el directorio de la instancia en caso de que no exista
        if not os.path.exists(os.path.dirname(dir_instancia)):
            try:
                os.makedirs(os.path.dirname(dir_instancia))
            except OSError as exc: # Guard against race condition
                if exc.errno != errno.EEXIST:
                    raise

        # Crea los archivos...
        #   'wb' indica escribir el archivo con EOL de Unix (Solo funciona con Python 2.x)
        f_configuracion = '{0}configuracion.xml'.format(dir_instancia)
        with open(f_configuracion, 'wb') as f_out:
            f_out.write(configuracion.encode())

        f_arranca_lin = '{0}arranca.sh'.format(dir_instancia)
        with open(f_arranca_lin, 'wb') as f_out:
            f_out.write(arranca_lin.encode())

        f_supervisor_ini = '{0}{1}.ini'.format(dir_instancia, id_instancia)
        with open(f_supervisor_ini, 'wb') as f_out:
            f_out.write(supervisor_ini.encode())

        f_instala_lin = '{0}instala.sh'.format(dir_instancia)
        with open(f_instala_lin, 'wb') as f_out:
            f_out.write(instala_lin.encode())
        st = os.stat(f_instala_lin)
        os.chmod(f_instala_lin, st.st_mode | stat.S_IEXEC)

#        # crea el tar
#        tar = tarfile.open("{0}{1}{2}.tgz".format(DIR_SALIDA, os.sep, id_instancia), "w:gz")
#        for name in [f_configuracion, f_arranca_lin, f_supervisor_ini, f_instala_lin]:
#            tar.add(name)
#        tar.close()

#-DEPRECADO-#        # El arranque en  Windows se escribe en forma normal
#-DEPRECADO-#        with open('{0}arranca.cmd'.format(dir_instancia), 'w') as f_out:
#-DEPRECADO-#            f_out.write(arranca_win)
finally:
    f.close()

print('\nTerminamos')
#EOF
