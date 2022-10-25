#!/usr/bin/python3
#
# Regards, the Alveare Solutions #!/Society -x
#
# TEST Serial Power Link Interpreter

#   class SPLInterpreter(object):
#       message_types = ['ID', 'ACK', 'INT']
#       gpio_state = {
#           True: GPIO.HIGH,
#           False: GPIO.LOW,
#       }

#       def __init__(self, *args, **kwargs):
#           self.last_csv = kwargs.get('last_csv', str())
#           self.timestamp = datetime.datetime.now()
#           self.spl_index = kwargs.get('spl_index', '.fg_head.spl.index')
#           self.machine_id = kwargs.get('machine_id', 'FG.HEAD.01')
#           self.machine_ipv4 = kwargs.get('machine_ipv4', '192.168.100.1')
#           self.spl_reader = kwargs.get('spl_reader', serial.Serial(
#               kwargs.get('serial_port', '/dev/serial0'),
#               baudrate=kwargs.get('baudrate', 115200),
#               bytesize=kwargs.get('bytesize', 8),
#               parity=kwargs.get('parity', 'N'),
#               stopbits=kwargs.get('stopbits',1),
#               timeout=kwargs.get('timeout', 3.0),
#           ))
#           self.spl_writer = kwargs.get('spl_writer', serial.Serial(
#               kwargs.get('serial_port', '/dev/serial0'),
#               baudrate=kwargs.get('baudrate', 115200),
#               bytesize=kwargs.get('bytesize', 8),
#               parity=kwargs.get('parity', 'N'),
#               stopbits=kwargs.get('stopbits',1),
#               timeout=kwargs.get('timeout', 3.0),
#           ))
#           self.spl_actions = kwargs.get(
#               'spl_actions', {
#                   'IN': {}, 'OUT': {}, 'AIR': {}, '1': {}, '2': {}, '3': {}, '4': {}
#               }
#           )
#           self.spl_report_pipe = kwargs.get(
#               'report_pipe', ensure_fifo_exists('/tmp/.fg-spl-report.fifo')
#           )
#           self.spl_gate_pins = kwargs.get('spl_gate_pins', {
#               'IN': 19, 'OUT': 16, 'AIR': 26, '1': 19, '2': 16, '3': 26, '4': 20,
#           })
#           log.debug('SPL Interpreter object initialized!')

#   # SETTERS
#   def set_gate_pin_lock_state(self, gate_id, state):
#   # CHECKERS
#   def check_msg_ack_reply_expected(self, message):
#   def check_spl_bus_busy(self):
#   def check_spl_gate_busy(self, gate_id):
#   def check_msg_ack_expected(self, msg_dict):
#   def check_machine_already_identified(self, msg_dict):
#   # VALIDATORS
#   def validate_spl_csv(self, spl_csv_msg):
#   # CONVERTERS
#   def spl_msg_str_2_list(self, spl_csv_msg):
#   def spl_msg_list_2_dict(self, msg_list):
#   # FORMATTERS
#   def format_spl_interogation_request_msg(self, **kwargs):
#   def format_spl_csv_msg(self, action, **kwargs):
#   def format_spl_msg_action_record(self, message, **kwargs):
#   def format_ack_response(self, msg_dict):
#   def format_spl_index_content(self):
#   # GENERAL
#   def wait_for_spl_bus(self, timeout=100):
#   def flood_gate_spl_lock(self, gate_id, state):
#   def report_to_head(self):
#   # UPDATERS
#   def update_spl_actions_cache(self, gate_id, msg_id, message, **kwargs):
#   def update_spl_index(self, msg_dict):
#   # ACTIONS
#   def issue_spl_csv_msg(self, gate_id, message, **kwargs):
#   def issue_spl_id_csv_msg(self, gate_id, **kwargs):
#   def issue_spl_int_csv_msg(self, gate_id, **kwargs):
#   def issue_spl_ack_csv_msg(self, gate_id, **kwargs):
#   def forward_discovery(self, init_msg_dct, **kwargs):
#   # HANDLERS
#   def handle_int_msg(self, message, **kwargs):
#   def handle_id_msg(self, message, **kwargs):
#   def handle_ack_msg(self, message, **kwargs):
#   # CLEANUP
#   def cleanup_action_record(self, msg_dict):
#   def cleanup_action_cache(self):
#   # INTERPRETERS
#   def interpret(self, spl_csv_msg, **kwargs):

