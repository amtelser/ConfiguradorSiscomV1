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
        contenido = bottle.template('configuracion_xml', data=self.data)
        with open('{0}/configuracion.xml'.format(self.testDirectory), 'w') as f:
            f.write(contenido)
        return

    def setUp(self):
        canales = ['TEST-ST340-TC-10', 'TEST-ST340-MS-10']
        l_canales = "','".join(canales)
        l_canales = "'{0}'".format(l_canales)
        self.data = {}
        self.data['ROOT'] = 'c:/siscom'                     # No incluir el '/' del final
        self.data['puerto_debug'] = '8800'
        self.data['id_instancia'] = 'TEST-Qro-Sky-Sun-OP101'
        self.data['nombre_instancia'] = 'TEST-Qro-Sky-Sun-OP101'
        self.data['puerto_base'] = '56000'
        self.data['ip_red_equipos'] = '10.190.0.10'
        self.data['ip_red_admin'] = '10.190.0.10'
        self.data['puerto_rx_notificaciones'] = '5140'
        self.data['puerto_tx_comandos'] = '9141'
        self.data['tabla_bitacora'] = 'RXSUNTEC'
        self.data['tipo_equipos'] = 'SUNTECH'
        self.data['canales'] = l_canales
        self.data['puerto_nagios'] = '8080'
        self.data['periodo_salidasgsm'] = '10'
        self.testDirectory = './tests'


if __name__ == '__main__':
    main()

#EOF
