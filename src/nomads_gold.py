#!/usr/bin/python3
#
# Regards, the Alveare Solutions #!/Society -x
#
# Nomad Gold

import yfinance
import time
import optparse
import os
import json
import crypt
import threading
import pysnooper
import random
import subprocess

from backpack.bp_log import log_init
from backpack.bp_ensurance import ensure_files_exist, ensure_directories_exist
from backpack.bp_shell import shell_cmd
from backpack.bp_checkers import check_file_exists
from backpack.bp_convertors import json2dict, dict2json, file2list
from backpack.bp_filters import filter_file_name_from_path, filter_directory_from_path
from backpack.bp_general import clear_screen, stdout_msg, write2file

NG_SCRIPT_NAME='NomadsGold'
NG_VERSION='Stonks'
NG_VERSION_NO='1.0'

# HOT PARAMETERS

NG_DEFAULT = {
    'project-path': str(),
    'system-user': 'NomadsGold',
    'system-pass': 'nomadgold',
    'system-perms': 755,
    'home-dir': '/home',
    'cron-dir': '/var/spool/cron/crontabs/NomadsGold',
    'conf-dir': 'conf',
    'bin-dir': '/usr/local/sbin',
    'conf-file': 'nomads_gold.conf.json',
    'log-dir': 'log',
    'log-file': 'nomads-gold.log',
    'wrapper-file': 'nomadsgold',
    'wpa-file': '/etc/wpa_supplicant/wpa_supplicant.conf',
    'cron-file': '/var/spool/cron/crontabs/NomadsGold/NomadsGold.cron.god_is_a_g',
    'bashrc-file': '/home/NomadsGold/.bashrc',
    'bashaliases-file': '/home/NomadsGold/.bash_aliases',
    'boot-file': '/boot/config.txt',
    'bashrc-template': '/home/NomadsGold/NomadsGold/data/.bashrc',
    'init-file': '/home/NomadsGold/NomadsGold/nomads-gold',
    'log-format': '[ %(asctime)s ] %(name)s [ %(levelname)s ] %(thread)s - '\
                  '%(filename)s - %(lineno)d: %(funcName)s - %(message)s',
    'timestamp-format': '%d/%m/%Y-%H:%M:%S',
    'debug': True,
    'silence': False,
    'wifi-essid': 'NomadsGold',
    'wifi-pass': 'nomadgold',
    'ticker-symbol': 'MSFT',
    'watch-interval': 2,
    'watch-cleanup': 1,
    'watch-flag': 0,
    'watch-anchor-file': '.ng_watch.anch',
    'period': '1w',
    'period-interval': '1d',
    'period-start': '2010-1-1',
    'period-end': '2020-1-1',
    'action-header': 'on',
    'write-flag': 0,
    'write-mode': 'a',
    'out-file': 'nomads-gold.out',
    'rate-sx-url': 'rate.sx',
    'action-target': 'stock',   # (stock | currency | crypto)
    'base-currency': 'USD',     # See all by running show-currencies and show-crypto
    'quote-currency': 'BTC', # See all by running show-currencies and show-crypto
    'crypto-topx': 10,
    'quantity': 1,
}
NG_CARGO = {
    'nomads-gold': __file__,
}
NG_ACTIONS_CSV = '' # (setup | price-history | recommendations | stock-info |
                    # price-open | price-close | price-high | price-low | volume |
                    # company-calendar | show-currencies | show-crypto |
                    # crypto-topx | currency-chart | currency-convertor)

# COLD PARAMETERS

VALID_CRYPTO_CACHE = []
VALID_CURRENCY_CACHE = []
ERROR_CODES = {
    'preconditions-not-met': 500,
    'invalid-ratesx-target': 700,
    'invalid-ticker-target': 600,
    'unknown': 999,
}
WARNING_CODES = {
    'preconditions-check-failed': 100,
    'action-not-handled-properly': 200,
    'no-watch-anchor': 201,
    'unknown': 888,
}
log = log_init(
    '/'.join([NG_DEFAULT['log-dir'], NG_DEFAULT['log-file']]),
    NG_DEFAULT['log-format'], NG_DEFAULT['timestamp-format'],
    NG_DEFAULT['debug'], log_name=NG_SCRIPT_NAME
)
ticker = yfinance.Ticker(NG_DEFAULT['ticker-symbol'])
ticker_df = None

# FETCHERS

def fetch_ratesx_targets():
    log.debug('')
    handlers = {
        'show-crypto': '{}/:coins'.format(NG_DEFAULT['rate-sx-url']),
        'show-currencies': '{}/:currencies'.format(NG_DEFAULT['rate-sx-url']),
        'currency-convertor': '{}.{}/{}{}'.format(
            NG_DEFAULT['base-currency'], NG_DEFAULT['rate-sx-url'],
            NG_DEFAULT['quantity'], NG_DEFAULT['quote-currency']
        ),
        'crypto-topx': '{}.{}/?q&n={}'.format(
            NG_DEFAULT['base-currency'], NG_DEFAULT['rate-sx-url'],
            NG_DEFAULT['crypto-topx']
        ),
        'currency-chart': '{}.{}/{}@{}?q&'.format(
            NG_DEFAULT['base-currency'], NG_DEFAULT['rate-sx-url'],
            NG_DEFAULT['quote-currency'], NG_DEFAULT['period']
        ),
        'crypto-topx-plain': '{}.{}/{}?qT&n={}'.format(
            NG_DEFAULT['base-currency'], NG_DEFAULT['rate-sx-url'],
            NG_DEFAULT['quote-currency'], NG_DEFAULT['crypto-topx']
        ),
        'currency-chart-plain': '{}.{}/{}@{}?qT&'.format(
            NG_DEFAULT['base-currency'], NG_DEFAULT['rate-sx-url'],
            NG_DEFAULT['quote-currency'], NG_DEFAULT['period']
        ),
    }
    return handlers

def fetch_stock_action_handlers():
    log.debug('')
    handlers = {
        'setup': action_setup,
        'price-history': action_display_price_history,
        'recommendations': action_display_analysts_recommendations,
        'stock-info': action_display_company_info,
        'price-open': action_display_stock_price_open,
        'price-close': action_display_stock_price_close,
        'price-high': action_display_stock_price_highs,
        'price-low': action_display_stock_price_lows,
        'volume': action_display_stock_volume,
        'company-calendar': action_display_company_calendar,
    }
    return handlers

def fetch_currency_action_handlers():
    log.debug('')
    handlers = {
        'show-currencies': action_show_currencies,
        'currency-chart': action_display_currency_chart,
        'currency-convertor': action_currency_convertor,
    }
    return handlers

def fetch_crypto_action_handlers():
    log.debug('')
    handlers = {
        'show-crypto': action_show_crypto,
        'crypto-topx': action_display_crypto_topx,
    }
    return handlers

#@pysnooper.snoop()
def fetch_ticker_history_pandas_data_frame(ticker_obj=ticker):
    global ticker_df
    log.debug('')
    if not ticker_obj:
        return False
    # TODO - Implement singleton - Stop re-creating the pandas data frame with each call
#   if ticker_df == None:
    ticker_df = ticker_obj.history(
        period=NG_DEFAULT['period'],
        start=NG_DEFAULT['period-start'],
        end=NG_DEFAULT['period-end']
    )
    return ticker_df

def fetch_ticker_target_headers():
    log.debug('')
    headers = {
        'info': 'Stock Info -',
        'history': 'Stock History -',
        'recommendations': 'Stock Recommendations from analysts -',
        'calendar': 'Company Calendar -',
        'highs': 'Stock Price Higs during period -',
        'lows': 'Stock Price Lows during period -',
        'open': 'Stock Opening Price during period -',
        'close': 'Stock Closing Price during period -',
        'volume': 'Stock Trading Volume during period -',
    }
    return headers

def fetch_ticker_target_handlers(ticker_obj):
    log.debug('')
    ticker_history = fetch_ticker_history_pandas_data_frame(ticker_obj)
    handlers = {
        'info': dict2json(ticker_obj.info),
        'history': ticker_history,
        'recommendations': ticker_obj.recommendations,
        'calendar': ticker_obj.calendar,
        'highs': ticker_history.High,
        'lows': ticker_history.Low,
        'open': ticker_history.Open,
        'close': ticker_history.Close,
        'volume': ticker_history.Volume,
    }
    return handlers

# CHECKERS

#@pysnooper.snoop()
def check_config_file():
    log.debug('')
    conf_file_path = NG_DEFAULT['conf-dir'] + "/" + NG_DEFAULT['conf-file']
    ensure_directories_exist(NG_DEFAULT['conf-dir'])
    cmd_out, cmd_err, exit_code = shell_cmd('touch ' + conf_file_path)
    return False if exit_code != 0 else True

#@pysnooper.snoop()
def check_log_file():
    log.debug('')
    log_file_path = NG_DEFAULT['log-dir'] + "/" + NG_DEFAULT['log-file']
    ensure_directories_exist(NG_DEFAULT['log-dir'])
    cmd_out, cmd_err, exit_code = shell_cmd('touch ' + log_file_path)
    return False if exit_code != 0 else True

def check_superuser():
    log.debug('')
    return False if os.geteuid() != 0 else True

#@pysnooper.snoop()
def check_action_privileges():
    log.debug('')
    for action in NG_ACTIONS_CSV.split(','):
        if action.strip('\n') in ['setup'] and not check_superuser():
            return False
    return True

def check_preconditions():
    log.debug('')
    checkers = {
        'preconditions-privileges': check_action_privileges(),
        'preconditions-conf': check_config_file(),
        'preconditions-log': check_log_file(),
    }
    if False in checkers.values():
        return display_warning('preconditions-check-failed')
    return 0

# FORMATTERS

def format_usage_string():
    usage = '''
    -h | --help                    Display this message.

    -S | --setup                   Setup current machine and create dedicated
       |                           user for NomadGold. Argument same as
       |                           (--action setup).

    -s | --silence                 No STDOUT messages.

    -w | --watch                   Execute given actions in an endless loop.

    -W | --write                   Write results to out file.

    -o | --out-file FILE-PATH      Implies (--write). File to write output to,

    -i | --watch-interval SECONDS  Implies (--watch). Number of seconds between
       |                           executions.

    -a | --action ACTIONS-CSV      Action to execute - Valid values include one
       |                           or more of the following labels given as a CSV
       |                           string: (setup | price-history | recommendations |
       |                           stock-info | price-open | price-close |
       |                           price-high | price-low | volume | company-calendar |
       |                           currency-convertor | currency-compare)

    -t | --ticker-symbol SYMBOL    Stock ticker symbol to perform action on.

    -p | --period PERIOD           Periods can be 1d, 5d, 1mo, 3mo, 6mo, 1y, 2y,
       |                           5y, 10y, ytd, max.

    -b | --period-start DATE       Date format YYYY/MM/DD.

    -e | --period-end DATE         Date format YYYY/MM/DD.

    -l | --log-file FILE-PATH      Log file path... where it writes log messages to.

    -c | --config-file FILE-PATH   Config file path... where it reads configurations
       |                           from.

    -I | --period-interval PERIOD  Interval for breaking down stock period reports.
       |                           Intervals can be 1m, 2m, 5m, 15m, 30m, 60m, 90m,
       |                           1h, 1d, 5d, 1wk, 1mo, 3mo.

    -T | --action-target TARGET    Financial instrument type for specified action.
       |                           Can be (stock | currency | crypto). Default stock.

    -B | --base-currency COIN      Base currency to be used in crypto and currency
       |                           exchanges and graphs.

    -E | --quote-currency COIN     Exchange currency to be used in crypto and
       |                           currency exchanges and graphs.

    -X | --crypto-topx NUMBER     Number of records to display when view-ing
       |                          top crypto coin stats.

    '''
    return usage

def format_header_string():
    header = '''
    ___________________________________________________________________________

      *                          *  Nomad's Gold  *                          *
    _____________________________________________________v1.0Stonks____________
                    Regards, the Alveare Solutions #!/Society -x
    '''
    return header

# GENERAL

#@pysnooper.snoop()
def load_config_file():
    log.debug('')
    global NG_DEFAULT
    global NG_SCRIPT_NAME
    global NG_VERSION
    global NG_VERSION_NO
    stdout_msg('[ INFO ]: Loading config file...')
    conf_file_path = NG_DEFAULT['conf-dir'] + '/' + NG_DEFAULT['conf-file']
    if not os.path.isfile(conf_file_path):
        stdout_msg('[ NOK ]: File not found! ({})'.format(conf_file_path))
        return False
    with open(conf_file_path, 'r', encoding='utf-8', errors='ignore') as conf_file:
        try:
            content = json.load(conf_file)
            NG_DEFAULT.update(content['NG_DEFAULT'])
            NG_CARGO.update(content['NG_CARGO'])
            NG_SCRIPT_NAME = content['NG_SCRIPT_NAME']
            NG_VERSION = content['NG_VERSION']
            NG_VERSION_NO = content['NG_VERSION_NO']
        except Exception as e:
            log.error(e)
            stdout_msg(
                '[ NOK ]: Could not load config file! ({})'.format(conf_file_path)
            )
            return False
    stdout_msg(
        '[ OK ]: Settings loaded from config file! ({})'.format(conf_file_path)
    )
    return True

#@pysnooper.snoop()
def export_project():
    log.debug('')
    stdout_msg('[ INFO ]: Exporting project...')
    project_dir = os.path.dirname(os.path.dirname(os.path.realpath(__file__)))
    new_dir = NG_DEFAULT['home-dir'] + '/' + NG_DEFAULT['system-user']
    if project_dir == new_dir:
        stdout_msg(
            '[ WARNING ]: Source and target directories are identical! Aborting.'
        )
        return False
    cmd_out, cmd_err, exit_code = shell_cmd(
        'cp -r ' + project_dir + ' ' + new_dir + ' &> /dev/null'
    )
    if exit_code != 0:
        stdout_msg(
            '[ NOK ]: Could not move directory ({}) to ({}).'\
            .format(project_dir, new_dir)
        )
    else:
        stdout_msg('[ OK ]: Project export complete!')
    return False if exit_code != 0 else True

# ACTIONS

#@pysnooper.snoop()
def action_display_ratesx_data(targets=[], ticker_obj=ticker, **kwargs):
    '''
    [ INPUT  ]: **kwargs - instruction on how to display the data
    [ RETURN ]: Numerical exit code.
    '''
    log.debug('')
    failures = 0
    prefix_header_tag = '[ ' + str(NG_DEFAULT['base-currency']) + '/' \
        + str(NG_DEFAULT['quote-currency'])
    url_targets = fetch_ratesx_targets()
    for target in targets:
        if target not in url_targets.keys():
            failures += 1
            display_error('invalid-ratesx-target')
            continue
        output_builder = str()
        prefix_header_tag = prefix_header_tag + ' @' + str(NG_DEFAULT['period']) + ' ]: '\
            if target != 'currency-convertor' else prefix_header_tag + ' ]: '
        if kwargs.get('action-header') and kwargs['action-header'] == 'on':
            header_builder = prefix_header_tag + target + '\n'
            stdout_msg(header_builder)
            if NG_DEFAULT['write-flag']:
                write2file(
                    header_builder, file_path=NG_DEFAULT['out-file'],
                    mode=NG_DEFAULT['write-mode']
                )
        if target == 'currency-convertor':
            os.system('echo -n \'{} \'; curl {} 2>/dev/null; echo'.format(
                '\n[ ' + NG_DEFAULT['quote-currency'] + ' ]:', url_targets[target]
            ))
        else:
            os.system('curl {} 2>/dev/null; echo'.format(url_targets[target]))
        if NG_DEFAULT['write-flag']:
            if target in ('currency-chart', 'crypto-topx'):
                target = target + '-plain'
            if target == 'currency-convertor':
                command = 'echo -n \'{} \'; curl \'{}\' 2>/dev/null >> {}'.format(
                    '[ ' + NG_DEFAULT['quote-currency'] + ' ]:',
                    url_targets[target], NG_DEFAULT['out-file']
                )
            else:
                command = 'curl \'{}\' 2>/dev/null >> {}'.format(
                    url_targets[target], NG_DEFAULT['out-file']
                )
            cmd_out, cmd_err, cmd_exit = shell_cmd(command)
        time.sleep(NG_DEFAULT['watch-interval'])
    return failures

#@pysnooper.snoop()
def action_display_ticker_data(targets=[], ticker_obj=ticker, **kwargs):
    '''
    [ INPUT  ]: **kwargs - instruction on how to display the data
    [ RETURN ]: Numerical exit code.
    '''
    log.debug('')
    prefix_header_tag, failures = '[ ' + str(NG_DEFAULT['ticker-symbol']) + ' ]: ', 0
    headers = fetch_ticker_target_headers()
    handlers = fetch_ticker_target_handlers(ticker_obj)
    for target in targets:
        if target not in handlers.keys():
            failures += 1
            display_error('invalid-ticker-target')
            continue
        if kwargs.get('action-header') and kwargs['action-header'] == 'on':
            header_builder = prefix_header_tag + headers[target] + '\n'
            stdout_msg(header_builder)
            if NG_DEFAULT['write-flag']:
                write2file(
                    header_builder, file_path=NG_DEFAULT['out-file'],
                    mode=NG_DEFAULT['write-mode']
                )
        output_builder = str(handlers[target]) + '\n'
        stdout_msg(output_builder)
        if NG_DEFAULT['write-flag']:
            write2file(
                output_builder, file_path=NG_DEFAULT['out-file'],
                mode=NG_DEFAULT['write-mode']
            )
    return failures

def action_currency_convertor(*args, **kwargs):
    log.debug('')
    return action_display_ratesx_data(
        targets=['currency-convertor'], *args, **kwargs
    )

def action_show_crypto(*args, **kwargs):
    log.debug('')
    return action_display_ratesx_data(
        targets=['show-crypto'], *args, **kwargs
    )

def action_display_crypto_topx(*args, **kwargs):
    log.debug('')
    return action_display_ratesx_data(
        targets=['crypto-topx'], *args, **kwargs
    )

def action_show_currencies(*args, **kwargs):
    log.debug('')
    return action_display_ratesx_data(
        targets=['show-currencies'], *args, **kwargs
    )

def action_display_currency_chart(*args, **kwargs):
    log.debug('')
    return action_display_ratesx_data(
        targets=['currency-chart'], *args, **kwargs
    )

def action_setup(*args, **kwargs):
    log.debug('')
    setup_procedure = {
        'create-user': create_system_user(),
        'export': export_project(),
        'setup-user': setup_system_user(),
    }
    failure_count = len([item for item in setup_procedure.values() if not item])
    if not failure_count:
        stdout_msg('[ OK ]: Setup complete! Reboot required.')
    else:
        stdout_msg('[ NOK ]: Well... no, this did not go well.')
    return failure_count

def action_display_price_history(*args, **kwargs):
    log.debug('')
    return action_display_ticker_data(
        targets=['history'], ticker_obj=ticker,
        header=NG_DEFAULT['action-header'], **kwargs
    )

def action_display_analysts_recommendations(*args, **kwargs):
    log.debug('')
    return action_display_ticker_data(
        targets=['recommendations'], ticker_obj=ticker,
        header=NG_DEFAULT['action-header'], **kwargs
    )

#@pysnooper.snoop()
def action_display_company_info(*args, **kwargs):
    log.debug('')
    return action_display_ticker_data(
        targets=['info'], ticker_obj=ticker,
        header=NG_DEFAULT['action-header'], **kwargs
    )

def action_display_stock_price_open(*args, **kwargs):
    log.debug('')
    return action_display_ticker_data(
        targets=['open'], ticker_obj=ticker,
        header=NG_DEFAULT['action-header'], **kwargs
    )

def action_display_stock_price_close(*args, **kwargs):
    log.debug('')
    return action_display_ticker_data(
        targets=['close'], ticker_obj=ticker,
        header=NG_DEFAULT['action-header'], **kwargs
    )

def action_display_stock_price_highs(*args, **kwargs):
    log.debug('')
    return action_display_ticker_data(
        targets=['highs'], ticker_obj=ticker,
        header=NG_DEFAULT['action-header'], **kwargs
    )

def action_display_stock_price_lows(*args, **kwargs):
    log.debug('')
    return action_display_ticker_data(
        targets=['lows'], ticker_obj=ticker,
        header=NG_DEFAULT['action-header'], **kwargs
    )

def action_display_stock_volume(*args, **kwargs):
    log.debug('')
    return action_display_ticker_data(
        targets=['volume'], ticker_obj=ticker,
        header=NG_DEFAULT['action-header'], **kwargs
    )

def action_display_company_calendar(*args, **kwargs):
    log.debug('')
    return action_display_ticker_data(
        targets=['calendar'], ticker_obj=ticker,
        header=NG_DEFAULT['action-header'], **kwargs
    )

# HANDLERS

def handle_action_exec(actions=[], handlers={}, *args, **kwargs):
    log.debug('')
    failure_count = 0
    if not actions:
        stdout_msg('[ WARNING ]: No action specified! You may need some --help ;)')
        return 1
    for action_label in actions:
        stdout_msg('[ INFO ]: Processing action... ({})'.format(action_label))
        if action_label not in handlers.keys():
            stdout_msg(
                '[ NOK ]: Invalid action label specified! ({})'.format(action_label)
            )
            failure_count += 1
            continue
        handle = handlers[action_label](*args, **kwargs)
        if isinstance(handle, int) and handle != 0:
            stdout_msg(
                '[ NOK ]: Action ({}) failures detected! ({})'\
                .format(action_label, handle)
            )
            failure_count += 1
            continue
        stdout_msg(
            "[ OK ]: Action executed successfully! ({})".format(action_label)
        )
    return True if failure_count == 0 else failure_count

#@pysnooper.snoop()
def handle_actions(actions=[], *args, **kwargs):
    '''
    [ INPUT  ]: *args    - set of action labels
                **kwargs - instruction on how to process the action
    [ RETURN ]: Numerical exit code.
    '''
    log.debug('')
    action_type, handlers = NG_DEFAULT['action-target'], {
        'stock': fetch_stock_action_handlers,
        'currency': fetch_currency_action_handlers,
        'crypto': fetch_crypto_action_handlers,
    }
    if NG_DEFAULT['action-target'] not in handlers.keys():
        stdout_msg(
            '[ WARNING ]: Invalid action type detected! ({}) Defaulting to (stock).'
        )
        action_type = 'stock'
    handler_dict = handlers[action_type]()
    if not NG_DEFAULT['watch-flag']:
        return handle_action_exec(
            actions=actions, handlers=handler_dict, *args, **kwargs
        )
    if not create_watch_anchor_file():
        return display_warning('no-watch-anchor')
    while True:
        anchor_check = check_file_exists(NG_DEFAULT['watch-anchor-file'])
        if not anchor_check:
            break
        if NG_DEFAULT['watch-cleanup']:
            clear_screen()
        exit_code = handle_action_exec(
            actions=actions, handlers=handler_dict, *args, **kwargs
        )
        time.sleep(NG_DEFAULT['watch-interval'])
    return exit_code

# DISPLAY

def display_error(error='unknown'):
    log.debug('')
    _err_msg = {
        'preconditions-not-met': 'Preconditions not met! Check your args and '
            'permissions.',
        'invalid-ratesx-target': 'Invalid rate.sx URL target!',
        'unknown': 'Issues detected but could not identify the source!',
    }
    msg_builder = '{} - Exit ({})'.format(
        _err_msg.get(error, 'unknown'), ERROR_CODES.get(error, 999)
    )
    log.error(msg_builder)
    stdout_msg('[ ERROR ]: {}'.format(msg_builder))
    return ERROR_CODES.get(error, 999)

def display_warning(warning='unknown'):
    log.debug('')
    _warn_msg = {
        'preconditions-check-failed': 'Preconditions check failed! Invalid args '
            'maybe?',
        'action-not-handled-properly': 'Issues detected when executing action! '
            'Process did not behave as expected.',
        'no-watch-anchor': 'Could not create watch anchor file! This processed '
            'cannot be stopped without a termination signal.',
        'unknown': 'Issues detected but could not identify the source!',
    }
    msg_builder = '{} - Exit ({})'.format(
        _warn_msg.get(warning, 'unknown'), WARNING_CODES.get(warning, 888)
    )
    log.warning(msg_builder)
    stdout_msg('[ WARNING ]: {}'.format(msg_builder))
    return WARNING_CODES.get(warning, 888)

def display_header():
    if NG_DEFAULT['silence']:
        return False
    print(format_header_string())
    return True

def display_usage():
    if NG_DEFAULT['silence']:
        return False
    display_header()
    print(format_usage_string())
    return True

# SETUP

def setup_system_user_groups():
    log.debug('')
    stdout_msg('[ INFO ]: Adding system user to sudoers...')
    group_out, group_err, group_exit = shell_cmd(
        'adduser ' + NG_DEFAULT['system-user'] + ' sudo &> /dev/null'
    )
    if group_exit != 0:
        stdout_msg(
            '[ NOK ]: Could not add ({}) to (sudoers) group!'\
            .format(NG_DEFAULT['system-user'])
        )
    else:
        stdout_msg(
            '[ OK ]: System user added to sudoers group! ({})'\
            .format(NG_DEFAULT['system-user'])
        )
    return False if group_exit != 0 else True

#@pysnooper.snoop()
def setup_system_user_permissions():
    log.debug('')
    stdout_msg('[ INFO ]: Setting up user HOME permissions...')
    home_dir = NG_DEFAULT['home-dir'] + '/' + NG_DEFAULT['system-user']
    owner_out, owner_err, owner_exit = shell_cmd(
        'chown ' + NG_DEFAULT['system-user'] + ' ' + home_dir + ' &> /dev/null'
    )
    if owner_exit != 0:
        stdout_msg(
            '[ NOK ]: Could not set ({}) as owner of directory ({})!'\
            .format(NG_DEFAULT['system-user'], home_dir)
        )
    else:
        stdout_msg(
            '[ OK ]: System user HOME directory owner set! ({})'\
            .format(NG_DEFAULT['system-user'])
        )
    perms_out, perms_err, perms_exit = shell_cmd(
        'chmod -R ' + str(NG_DEFAULT['system-perms']) + ' ' + home_dir
        + ' &> /dev/null'
    )
    if perms_exit != 0:
        stdout_msg(
            '[ NOK ]: Could not set ({}) permissions to directory ({})!'\
            .format(NG_DEFAULT['system-perms'], home_dir)
        )
    else:
        stdout_msg(
            '[ OK ]: System user HOME directory permissions set! ({})'\
            .format(NG_DEFAULT['system-perms'])
        )
    return False if owner_exit != 0 or perms_exit != 0 else True

def setup_system_user_bash_aliases():
    log.debug('')
    stdout_msg('[ INFO ]: Setting up ({})...'.format(NG_DEFAULT['bashaliases-file']))
    stdout_msg('[ INFO ]: Formatting file content...')
    content = format_bash_aliases_content()
    if not content:
        stdout_msg(
            '[ NOK ]: Could not format ({}) file content!'\
            .format(NG_DEFAULT['bashaliases-file'])
        )
        return False
    stdout_msg('[ OK ]: File content!')
    with open(NG_DEFAULT['bashaliases-file'], 'w', encoding='utf-8',
              errors='ignore') as aliases:
        stdout_msg(
            '[ INFO ]: Updating file... ({})'\
            .format(NG_DEFAULT['bashaliases-file'])
        )
        write = aliases.write(content)
        if not write:
            stdout_msg('[ NOK ]: Could not update file!')
            return False
        else:
            stdout_msg('[ OK ]: File updated successfuly!')
    return True

def setup_system_user_bashrc():
    log.debug('')
    stdout_msg('[ INFO ]: Setting up ({})...'.format(NG_DEFAULT['bashrc-file']))
    stdout_msg('[ INFO ]: Formatting file content...')
    template, content = str(), format_bashrc_content()
    if not content:
        stdout_msg('[ NOK ]: Could not format file content!')
    else:
        stdout_msg('[ OK ]: File content!')
    with open(NG_DEFAULT['bashrc-template'], 'r', encoding='utf-8',
              errors='ignore') as bashrc:
        stdout_msg('[ INFO ]: Reading template file...')
        template = ''.join(bashrc.readlines())
        if not template:
            stdout_msg(
                '[ NOK ]: Could not read template file ({})!'\
                .format(NG_DEFAULT['bashrc-template'])
            )
        else:
            stdout_msg(
                '[ OK ]: Read template file ({})!'\
                .format(NG_DEFAULT['bashrc-template'])
            )
    content = template + '\n' + content
    with open(NG_DEFAULT['bashrc-file'], 'w', encoding='utf-8',
              errors='ignore') as bashrc:
        stdout_msg(
            '[ INFO ]: Updating file... ({})'.format(NG_DEFAULT['bashrc-file'])
        )
        write = bashrc.write(content)
        if not write:
            stdout_msg('[ NOK ]: Could not update file!')
        else:
            stdout_msg('[ OK ]: File updated successfuly!')
    return True

def setup_system_user():
    log.debug('')
    user_setup = {
        'bashrc': setup_system_user_bashrc(),
        'aliases': setup_system_user_bash_aliases(),
        'permissions': setup_system_user_permissions(),
        'groups': setup_system_user_groups(),
    }
    return False if False in user_setup.values() else True

# PROCESSORS

def process_quantity_argument(parser, options):
    global NG_DEFAULT
    log.debug('')
    quantity = options.quantity
    if quantity == None:
        return False
    NG_DEFAULT['quantity'] = quantity
    stdout_msg(
        '[ + ]: Quanity ({})'.format(quantity)
    )
    return True

def process_write_flag_argument(parser, options):
    global NG_DEFAULT
    log.debug('')
    write_flag = options.write_flag
    if write_flag == None:
        return False
    NG_DEFAULT['write-flag'] = True if write_flag else False
    stdout_msg(
        '[ + ]: Write Flag ({})'.format(write_flag)
    )
    return True

def process_out_file_argument(parser, options):
    global NG_DEFAULT
    log.debug('')
    out_file = options.out_file_path
    if out_file == None:
        return False
    NG_DEFAULT['out-file'] = out_file
    stdout_msg(
        '[ + ]: Out file ({})'.format(out_file)
    )
    return True

def process_watch_argument(parser, options):
    global NG_DEFAULT
    log.debug('')
    watch = options.watch_flag
    if watch == None:
        return False
    NG_DEFAULT['watch-flag'] = True if watch else False
    stdout_msg(
        '[ + ]: Watch Flag ({})'.format(watch)
    )
    return True

def process_watch_interval_argument(parser, options):
    global NG_DEFAULT
    log.debug('')
    interval = options.watch_interval
    if interval == None:
        return False
    NG_DEFAULT['watch-interval'] = interval
    stdout_msg(
        '[ + ]: Watch Interval ({})'.format(interval)
    )
    return True

def process_ticker_symbol_argument(parser, options):
    global NG_DEFAULT
    global ticker
    log.debug('')
    symbol = options.ticker_symbol
    if symbol == None:
        return False
    NG_DEFAULT['ticker-symbol'] = symbol
    ticker = yfinance.Ticker(NG_DEFAULT['ticker-symbol'])
    stdout_msg(
        '[ + ]: Ticker Symbol ({})'.format(symbol)
    )
    return True

def process_period_argument(parser, options):
    global NG_DEFAULT
    log.debug('')
    period = options.period
    if period == None:
        return False
    NG_DEFAULT['period'] = period
    stdout_msg(
        '[ + ]: Period ({})'.format(period)
    )
    return True

def process_period_start_argument(parser, options):
    global NG_DEFAULT
    log.debug('')
    period_start = options.period_start
    if period_start == None:
        return False
    NG_DEFAULT['period-start'] = period_start
    stdout_msg(
        '[ + ]: Period START ({})'.format(period_start)
    )
    return True

def process_period_end_argument(parser, options):
    global NG_DEFAULT
    log.debug('')
    period_end = options.period_end
    if period_end == None:
        return False
    NG_DEFAULT['period-end'] = period_end
    stdout_msg(
        '[ + ]: Period END ({})'.format(period_end)
    )
    return True

def process_silence_argument(parser, options):
    global NG_DEFAULT
    log.debug('')
    silence_flag = options.silence
    if silence_flag == None:
        return False
    NG_DEFAULT['silence'] = silence_flag
    stdout_msg(
        '[ + ]: Silence ({})'.format(silence_flag)
    )
    return True

def process_setup_argument(parser, options):
    global NG_ACTIONS_CSV
    log.debug('')
    setup_flag = options.setup
    if setup_flag == None:
        return False
    NG_ACTIONS_CSV = 'setup' if not NG_ACTIONS_CSV \
            else 'setup,{}'.format(NG_ACTIONS_CSV)
    stdout_msg(
        '[ + ]: Setup mode ({})'.format(setup_flag)
    )
    return True

def process_action_csv_argument(parser, options):
    global NG_ACTIONS_CSV
    log.debug('')
    action_csv = options.action_csv
    if action_csv == None:
        log.warning(
            'No actions provided. Defaulting to ({}).'\
            .format(NG_ACTIONS_CSV)
        )
        return False
    NG_ACTIONS_CSV = action_csv
    stdout_msg(
        '[ + ]: Actions setup ({})'.format(NG_ACTIONS_CSV)
    )
    return True

def process_config_file_argument(parser, options):
    global NG_DEFAULT
    log.debug('')
    file_path = options.config_file_path
    if file_path == None:
        log.warning(
            'No config file provided. Defaulting to ({}/{}).'\
            .format(NG_DEFAULT['conf-dir'], NG_DEFAULT['conf-file'])
        )
        return False
    NG_DEFAULT['conf-dir'] = filter_directory_from_path(file_path)
    NG_DEFAULT['conf-file'] = filter_file_name_from_path(file_path)
    load_config_file()
    stdout_msg(
        '[ + ]: Config file setup ({})'.format(NG_DEFAULT['conf-file'])
    )
    return True

def process_log_file_argument(parser, options):
    global NG_DEFAULT
    log.debug('')
    file_path = options.log_file_path
    if file_path == None:
        log.warning(
            'No log file provided. Defaulting to ({}/{}).'\
            .format(NG_DEFAULT['log-dir'], NG_DEFAULT['log-file'])
        )
        return False
    NG_DEFAULT['log-dir'] = filter_directory_from_path(file_path)
    NG_DEFAULT['log-file'] = filter_file_name_from_path(file_path)
    stdout_msg(
        '[ + ]: Log file setup ({})'.format(NG_DEFAULT['log-file'])
    )
    return True

def process_period_interval_argument(parser, options):
    global NG_DEFAULT
    log.debug('')
    interval = options.period_interval
    if interval == None:
        return False
    NG_DEFAULT['period-interval'] = interval
    stdout_msg(
        '[ + ]: Period Interval ({})'.format(interval)
    )
    return True

def process_action_target_argument(parser, options):
    global NG_DEFAULT
    log.debug('')
    target = options.action_target
    if target == None:
        return False
    NG_DEFAULT['action-target'] = target
    stdout_msg(
        '[ + ]: Action Target ({})'.format(target)
    )
    return True

def process_base_currency_argument(parser, options):
    global NG_DEFAULT
    log.debug('')
    currency = options.base_currency
    if currency == None:
        return False
    NG_DEFAULT['base-currency'] = currency
    stdout_msg(
        '[ + ]: Base Currency ({})'.format(currency)
    )
    return True

def process_quote_currency_argument(parser, options):
    global NG_DEFAULT
    log.debug('')
    currency = options.quote_currency
    if currency == None:
        return False
    NG_DEFAULT['quote-currency'] = currency
    stdout_msg(
        '[ + ]: Quote Currency ({})'.format(currency)
    )
    return True

def process_crypto_topx_argument(parser, options):
    global NG_DEFAULT
    log.debug('')
    topx = options.crypto_topx
    if topx == None:
        return False
    NG_DEFAULT['crypto-topx'] = topx
    stdout_msg(
        '[ + ]: Crypto TopX ({})'.format(topx)
    )
    return True

def process_command_line_options(parser):
    '''
    [ NOTE ]: In order to avoid a bad time in STDOUT land, please process the
              silence flag before all others.
    '''
    log.debug('')
    (options, args) = parser.parse_args()
    processed = {
        'silence_flag': process_silence_argument(parser, options),
        'config_file': process_config_file_argument(parser, options),
        'log_file': process_log_file_argument(parser, options),
        'setup_flag': process_setup_argument(parser, options),
        'action_csv': process_action_csv_argument(parser, options),
        'watch_flag': process_watch_argument(parser, options),
        'watch_interval': process_watch_interval_argument(parser, options),
        'ticker_symbol': process_ticker_symbol_argument(parser, options),
        'period': process_period_argument(parser, options),
        'period_start': process_period_start_argument(parser, options),
        'period_end': process_period_end_argument(parser, options),
        'write_flag': process_write_flag_argument(parser, options),
        'out-file': process_out_file_argument(parser, options),
        'period_interval': process_period_interval_argument(parser, options),
        'action_target': process_action_target_argument(parser, options),
        'base_currency': process_base_currency_argument(parser, options),
        'quote_currency': process_quote_currency_argument(parser, options),
        'crypto_topx': process_crypto_topx_argument(parser, options),
        'quantity': process_quantity_argument(parser, options),
    }
    return processed

# CREATORS

def create_command_line_parser():
    log.debug('')
    help_msg = format_header_string() + '''
    [ EXAMPLE ]: Setup Nomad(G) trading machine -
        ~$ %prog \\
            -S  | --setup \\
            -c  | --config-file /etc/conf/nomad-gold.conf.json \\
            -l  | --log-file /etc/log/nomad-gold.log

    [ EXAMPLE ]: Get Microsoft stock price history
        ~$ %prog \\
            -a  | --action price-history\\
            -p  | --period 1d\\
            -b  | --period-start 2010-1-1\\
            -e  | --period-end 2022-1-1\\
            -t  | --ticker-symbol MSFT

    [ EXAMPLE ]: Get Tesla stock info
        ~$ %prog \\
            -a  | --action stock-info\\
            -t  | --ticker-symbol TSLA

    [ EXAMPLE ]: See Microsoft company calendar
        ~$ %prog \\
            -a  | --action company-calendar\\
            -t  | --ticker-symbol MSFT

    [ EXAMPLE ]: Check Microsoft stock price higs, lows and volume - write
                 output to file
        ~$ %prog \\
            -a  | --action price-high,price-low,volume\\
            -t  | --ticker-symbol MSFT\\
            -W  | --write\\
            -o  | --out-file nomads-gold.out\\
                |
            -p  | --period 1m\\
            -I  | --period-interval 1d
        OR      |
            -b  | --period-start 2010-1-1\\
            -e  | --period-end 2022-1-1


    [ EXAMPLE ]: Check top 10 crypto coin stats continuously at 5min interval
                 with BTC as the base currency
        ~$ %prog \\
            -a  | --action crypto-topx\\
            -T  | --action-target crypto\\
            -X  | --crypto-topx 10\\
            -B  | --base-currency BTC\\
            -w  | --watch\\
            -i  | --watch-interval 5m

    [ EXAMPLE ]: View ETH currency line chart with USD as base currency for the
                 past 5 days and save output to file
        ~$ %prog \\
            -a  | --action currency-chart\\
            -T  | --action-target currency\\
            -B  | --base-currency USD\\
            -E  | --quote-currency ETH\\
            -p  | --period 6d\\
            -W  | --write\\
            -o  | --out-file nomads-gold.out

    [ EXAMPLE ]: Convert 100 bitcoin to euro
        ~$ %prog \\
            -a  | --action currency-convertor\\
            -T  | --action-target currency\\
            -B  | --base-currency EUR\\
            -E  | --quote-currency BTC\\
            -q  | --quantity 100
    '''
    parser = optparse.OptionParser(help_msg)
    return parser

def create_system_user():
    log.debug('')
    stdout_msg(
        '[ INFO ]: Ensuring system user exists... ({})'
        .format(NG_DEFAULT['system-user'])
    )
    encoded_pass = crypt.crypt(NG_DEFAULT['system-pass'], "22")
    cmd_out, cmd_err, exit_code = shell_cmd(
        'useradd -p ' + encoded_pass + ' ' + NG_DEFAULT['system-user']
        + ' &> /dev/null'
    )
    if exit_code != 0:
        stdout_msg('[ NOK ]: Could not create new system user!')
    else:
        stdout_msg('[ OK ]: System user!')
    return False if exit_code != 0 else True

def create_watch_anchor_file():
    log.debug('')
    if check_file_exists(NG_DEFAULT['watch-anchor-file']):
        stdout_msg('[ INFO ]: Watch anchor file found from a previous session.')
        return True
    return ensure_files_exist(NG_DEFAULT['watch-anchor-file'])

# PARSERS

def add_command_line_parser_options(parser):
    log.debug('')
    parser.add_option(
        '-S', '--setup', dest='setup', action='store_true',
        help='Setup current machine and create dedicated user for NomadGold. '
             'Argument same as (--action setup).'
    )
    parser.add_option(
        '-s', '--silence', dest='silence', action='store_true',
        help='Eliminates all STDOUT messages.'
    )
    parser.add_option(
        '-a', '--action', dest='action_csv', type='string', metavar='ACTION-CSV',
        help='Action to execute - Valid values include one or more of the following '
             'labels given as a CSV string: (setup | price-history | recommendations |'
             'stock-info | price-open | price-close | price-high | price-low | '
             'volume | company-calendar | show-currencies | show-crypto | '
             'crypto-topx | currency-chart)'
    )
    parser.add_option(
        '-w', '--watch', dest='watch_flag', action='store_true',
        help='Execute specified actions in an endless loop at a given interval.',
    )
    parser.add_option(
        '-i', '--watch-interval', dest='watch_interval', type='int',
        help='Implies (--watch). Number of seconds between executions. Default ({}).'
        .format(NG_DEFAULT['watch-interval']), metavar='SECONDS'
    )
    parser.add_option(
        '-t', '--ticker-symbol', dest='ticker_symbol', type='string',
        help='Stock ticker symbol to perform action on.',
        metavar='SYMBOL'
    )
    parser.add_option(
        '-p', '--period', dest='period', type='string',
        help='Periods can be 1d, 5d, 1mo, 3mo, 6mo, 1y, 2y, 5y, 10y, ytd, max.',
        metavar='N<d/m/y>'
    )
    parser.add_option(
        '-b', '--period-start', dest='period_start', type='string',
        help='Start Date for stock data interogation - format YYYY/MM/DD.',
        metavar='DATE'
    )
    parser.add_option(
        '-e', '--period-end', dest='period_end', type='string',
        help='End Date for stock data interogation - format YYYY/MM/DD.',
        metavar='DATE'
    )
    parser.add_option(
        '-c', '--config-file', dest='config_file_path', type='string',
        help='Configuration file to load default values from.', metavar='FILE_PATH'
    )
    parser.add_option(
        '-l', '--log-file', dest='log_file_path', type='string',
        help='Path to the log file.', metavar='FILE_PATH'
    )
    parser.add_option(
        '-W', '--write', dest='write_flag',  action='store_true',
        help='Write output to file.',
    )
    parser.add_option(
        '-o', '--out-file', dest='out_file_path', type='string',
        help='Implies (--write). Where to write output to.', metavar='FILE_PATH'
    )
    parser.add_option(
        '-I', '--period-interval', dest='period_interval', type='string',
        help='Interval for breaking down stock period reports. Intervals can be '
             '1m, 2m, 5m, 15m, 30m, 60m, 90m, 1h, 1d, 5d, 1wk, 1mo, 3mo.',
        metavar='INTERVAL'
    )
    parser.add_option(
        '-T', '--action-target', dest='action_target', type='string',
        help='Financial instrument type for specified actions. Values can be '
             '(stock | crypto | currency). Default (stock)', metavar='TARGET'
    )
    parser.add_option(
        '-B', '--base-currency', dest='base_currency', type='string',
        help='Base currency to use in line charts and exchanges.',
        metavar='CURRENCY'
    )
    parser.add_option(
        '-E', '--quote-currency', dest='quote_currency', type='string',
        help='Quote currency to use in line charts and exchanges.',
        metavar='CURRENCY'
    )
    parser.add_option(
        '-X', '--crypto-topx', dest='crypto_topx', type='int',
        help='Implies (--action-type crypto --action crypto-topx). Top crypto '
             'coins to display stats for.', metavar='NUMBER'
    )
    parser.add_option(
        '-q', '--quantity', dest='quantity', type='int',
        help='Implies (--action currency-convertor). Quantity to convert.',
        metavar='NUMBER'
    )
    return True

def parse_command_line_arguments():
    log.debug('')
    parser = create_command_line_parser()
    add_command_line_parser_options(parser)
    return process_command_line_options(parser)

# INIT

#@pysnooper.snoop()
def init_nomad_gold():
    log.debug('')
    display_header()
    stdout_msg('[ INFO ]: Verifying action preconditions...')
    check = check_preconditions()
    if not isinstance(check, int) or check != 0:
        return display_error('preconditions-not-met')
    handle = handle_actions(
        None if not NG_ACTIONS_CSV else NG_ACTIONS_CSV.split(','), **NG_DEFAULT
    )
    if not handle:
        display_warning('action-not-handled-properly')
    return 0 if handle is True else handle

# CLEANERS

def cleanup_anchor_files():
    log.debug('')
    cmd_out, cmd_err, exit_code = shell_cmd('rm ' + NG_DEFAULT['watch-anchor-file'])
    return False if exit_code != 0 else True


def cleanup_out_files():
    log.debug('')
    cmd_out, cmd_err, exit_code = shell_cmd('rm ' + NG_DEFAULT['out-file'])
    return False if exit_code != 0 else True

def cleanup(targets=['all']):
    log.debug('')
    failures = 0
    cleaners = {
        'anchor-files': cleanup_anchor_files,
        'out-files': cleanup_out_files,
    }
    action_set = list(cleaners.keys()) if 'all' in targets else targets
    for target in action_set:
        cleanup = cleaners[target]()
        if cleanup:
            continue
        failures += 1
    return failures

# MISCELLANEOUS

if __name__ == '__main__':
    parse_command_line_arguments()
    clear_screen()
    try:
        EXIT_CODE = init_nomad_gold()
    finally:
        cleanup(targets=['anchor-files'])
    stdout_msg('[ DONE ]: Terminating! ({})'.format(EXIT_CODE))
    if isinstance(EXIT_CODE, int):
        exit(EXIT_CODE)
    exit(0)

# CODE DUMP

# EXAMPLE -
# <base-currency>.rate.sx/?q&n=<crypto-topx>
# <base-currency>.rate.sx/<exchange-currency>?q&n=<crypto-topx>
# rate.sx/:coins
# rate.sx/:currencies
# rate.sx/:help
# rate.sx/1BTC-10ETH
# rub.rate.sx/100ETH
# eur.rate.sx/1BTC+1BCH+1BTG
