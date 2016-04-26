#! /usr/bin/env python
# -*- python -*-
# -*- utf-8 -*-

from __future__ import print_function
from unittest import TestCase, main

import bottle


class TestTemplates(TestCase):

    def test_arranca_cmd(self):
        contenido = bottle.template('arranca_cmd', data=self.data)
        with open('{0}/arranca.cmd'.format(self.testDirectory), 'w') as f:
            f.write(contenido)
        return

    def test_arranca_sh(self):
        contenido = bottle.template('arranca_sh', data=self.data)
        with open('{0}/arranca.sh'.format(self.testDirectory), 'w') as f:
            f.write(contenido)
        return

    def test_configuracion(self):
        contenido = bottle.template('configuracion_xml', data=self.data, noescape=True)
        with open('{0}/configuracion.xml'.format(self.testDirectory), 'w') as f:
            f.write(contenido)
        return

    def setUp(self):
        canales = ['ST215-TC-09', 'ST215-MS-01', 'ST240-TC-04', 'ST240-MS-04', 'ST340-TC-02', 'ST340-MS-02']
        l_canales = "','".join(canales)
        l_canales = "'{0}'".format(l_canales)
        self.data = {}
        self.data['ROOT'] = 'c:/siscom'                     # No incluir el '/' del final
        self.data['progress_bar_activo'] = 'si'
        self.data['puerto_debug'] = '8816'
        self.data['id_instancia'] = 'CMIA-SKY-SUN-OP16'
        self.data['nombre_instancia'] = 'Op:16 MAQ:2A BD:MIA SUNTECH; CANALES: ST215-TC-09 / ST215-MS-01 / ST240-TC-04 / ST240-MS-04 / ST340-TC-02 / ST340-MS-02'
        self.data['puerto_base'] = '56500'
        self.data['ip_red_equipos'] = '192.168.2.60'
        self.data['ip_red_admin'] = '10.190.0.11'
        self.data['puerto_rx_notificaciones'] = '5129'
        self.data['puerto_tx_comandos'] = '9014'
        self.data['tabla_bitacora'] = 'RXSUNTEC'
        self.data['geo_referenciar'] = 'no'
        self.data['tipo_equipos'] = 'SUNTECH'
        self.data['num_conexiones_cache'] = '3'
        self.data['canales'] = l_canales
        self.data['filtrar_mobil_eye'] = 'no'
        self.data['puerto_nagios'] = '8096'
        self.data['usar_metodos_p'] = 'no'
        self.data['periodo_salidasgsm'] = '10'
        
        self.testDirectory = './tests'


if __name__ == '__main__':
    main()

#EOF
