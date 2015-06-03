# Base de datos en JSON

maquinas = [
    {'id': 1,
     'plataforma': '',
     'root': '',
     'nombre': '',
     'direccion_ip_admin': '',
     'direccion_ip_equipos': '',
     'puertos_base': [
        '56000', '56001', '56002', '56003', '56004',
        '56005', '56006', '56007', '56008', '56009'
     ],
     'puertos_debug': [
        '8800', '8801', '8802', '8803', '8804',
        '8805', '8806', '8807', '8808', '8809'
     ],
     'puertos_nagios': [
        '8080', '8081', '8082', '8083', '8084',
        '8085', '8086', '8087', '8088', '8089'
     ]
     }
]

instancias = [
    {'id': '',
     'id_maquina': '',
     'id_instancia': 'OP99-PRUEBAS',
     'nombre_instancia': 'Instancia de pruebas',
     'puerto_rx_notificaciones': '5000',
     'puerto_tx_comandos': '9000',
     'tabla_bitacora': 'RXSUNTEC',
     'tipo_equipos': 'SUNTECH',
     'canales': ['CANAL-1', 'CANAL-2', 'CANAL-3', 'CANAL-4'],
     'periodo_salidasgsm': '10'
    }
]