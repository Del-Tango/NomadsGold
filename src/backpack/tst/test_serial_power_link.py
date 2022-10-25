#!/usr/bin/python3
#
# Regards, the Alveare Solutions #!/Society -x
#
# TEST Serial Power Link


#   class SPL(object):
#       port_cnx = None
#       pin_state = {True: GPIO.HIGH, False: GPIO.LOW}
#       def __init__(self, *args, **kwargs):
#           self.serial_ports = kwargs.get('serial_ports', args) or ('/dev/serial0')
#           for serial_port in args:
#               if not serial_port:
#                   continue
#               try:
#                   self.port_cnx = serial.Serial(
#                       serial_port,
#                       baudrate=kwargs.get('baudrate', 115200),
#                       bytesize=kwargs.get('bytesize', 8),
#                       parity=kwargs.get('parity', 'N'),
#                       stopbits=kwargs.get('stopbits',1),
#                       timeout=kwargs.get('timeout', 3.0),
#                   )
#                   break
#               except Exception as e:
#                   log.error(e)
#                   continue
#           self.reader = kwargs.get(
#               'reader', SPLReader(*self.serial_ports, port_cnx=self.port_cnx)
#           )
#           self.writer = kwargs.get(
#               'writer', SPLWriter(*self.serial_ports, port_cnx=self.port_cnx)
#           )
#           self.spl_interpreter = SPLInterpreter(
#               spl_reader=self.reader, spl_writer=self.writer, **kwargs
#           )
#           self.gate_count = kwargs.get('gate_count', 4)
#           self.spl_gate_pins = kwargs.get('spl_gate_pins', {
#               1: 19, 2: 16, 3: 26, 4: 20,
#           })
#           self.spl_gates_active = kwargs.get('spl_gates_activedq', list())
#           self.message_archive = {
#               item: {'message': str(), 'timestamp': None, 'direction': str()}
#               for item in self.spl_gate_pins.keys()
#           }
#           self.pi_warnings = kwargs.get('pi_warnings', False)
#           self.gpio_mode = kwargs.get('gpio_mode', GPIO.BCM)
#           log.debug('SPL object initialized!')

#   # FETCHERS
#   fetch_active_gate_ids(self):
#   # UPDATERS
#   update_message_archive(self, gate_id, **metadata):
#   # ACTIONS
#   spl_monitor(self, sys_path, **kwargs):
#   interpret(self, spl_csv_msg, **kwargs):
#   read2disk(self, sys_path, target='file', **kwargs):
#   read2pipe(self, fifo_path, **kwargs):
#   read2file(self, file_path, **kwargs):
#   write(self, *args, **kwargs):
#   read(self, **kwargs):
#   # SETUP
#   setup_gpio_pins(self):
#   # CLEANUP
#   cleanup_spl_active_gate_locks_cache(self):
#   cleanup(self):
#   # MAGIK
#   __str__(self):
#       return '{} {} {}'.format(self.serial_ports, self.reader, self.writer)

#   spl = SPL('/dev/serial0')
#   spl.write('first line\n', 'second line\n')
#   spl.read2pipe('/tmp/spl-test1')
#   spl.interpret('SPLT:Serial,Power,Link,Transmission;')


