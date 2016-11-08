#
# Generador de configuraciones

from __future__ import print_function
import csv
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
        data['id_instancia_lower'] = id_instancia
        data['tag_en_git'] = tag_en_git
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
            f_out.write(configuracion)

        f_arranca_lin = '{0}arranca.sh'.format(dir_instancia)
        with open(f_arranca_lin, 'wb') as f_out:
            f_out.write(arranca_lin)

        f_supervisor_ini = '{0}{1}.ini'.format(dir_instancia, id_instancia)
        with open(f_supervisor_ini, 'wb') as f_out:
            f_out.write(supervisor_ini)

        f_instala_lin = '{0}instala.sh'.format(dir_instancia)
        with open(f_instala_lin, 'wb') as f_out:
            f_out.write(instala_lin)
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

print('Terminamos')
#EOF
