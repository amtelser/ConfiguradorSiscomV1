#
# Generador de configuraciones

from __future__ import print_function
import csv
import bottle
import os

INFO_INSTANCIAS = 'configuraciones.csv'
TEMPLATE_CONFIG = 'configuracion_xml'
TEMPLATE_STUP_LIN = 'arranca_sh'
TEMPLATE_STUP_WIN = 'arranca_cmd'
TEMPLATE_SUPERVISOR = 'supervisor_ini'
DIR_SALIDA = 'salida'

f = open(INFO_INSTANCIAS)
try:
    f_csv = csv.reader(f)
    campos = next(f_csv)
    for info in f_csv:
        datos = zip(campos, info)
        data = {}
        id_instancia = ''
        for i, tup in enumerate(datos):
            if tup[0] == 'id_instancia':
                id_instancia = tup[1].lower()
            data[tup[0]] = tup[1]
        configuracion = bottle.template(TEMPLATE_CONFIG, data=data)
        arranca_win = bottle.template(TEMPLATE_STUP_WIN, data=data)
        arranca_lin = bottle.template(TEMPLATE_STUP_LIN, data=data)
        supervisor_ini = bottle.template(TEMPLATE_SUPERVISOR, data=data)

        dir_instancia = '{1}{0}{2}{0}'.format(os.sep, DIR_SALIDA, id_instancia)
        # crear el directorio de la instancia en caso de que no exista
        if not os.path.exists(os.path.dirname(dir_instancia)):
            try:
                os.makedirs(os.path.dirname(dir_instancia))
            except OSError as exc: # Guard against race condition
                if exc.errno != errno.EEXIST:
                    raise
        # Crea los archivos...
        with open('{0}configuracion.xml'.format(dir_instancia), 'w') as f_out:
            f_out.write(configuracion)
        with open('{0}arranca.cmd'.format(dir_instancia), 'w') as f_out:
            f_out.write(arranca_win)
        with open('{0}arranca.sh'.format(dir_instancia), 'w') as f_out:
            f_out.write(arranca_lin)
        with open('{0}{1}.ini'.format(dir_instancia, id_instancia), 'w') as f_out:
            f_out.write(supervisor_ini)
finally:
    f.close()

print('Terminamos')
#EOF
