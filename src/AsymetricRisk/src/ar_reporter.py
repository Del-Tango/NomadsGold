#!/usr/bin/python3
#
# Excellent Regards, the Alveare Solutions #!/Society -x
#
# ASYMETRIC RISK TRADING REPORTER

import time
import string
import logging
import datetime
import pysnooper

from src.backpack.bp_general import write2file, pretty_dict_print, stdout_msg
from src.backpack.bp_convertors import dict2json, json2dict
from src.backpack.bp_generators import generate_msg_id
from src.backpack.bp_ensurance import ensure_directories_exist
from src.backpack.bp_checkers import check_file_exists
from src.backpack.bp_shell import shell_cmd

log = logging.getLogger('AsymetricRisk')


#@pysnooper.snoop()
class TradingReporter():

#   @pysnooper.snoop()
    def __init__(self, *args, **kwargs):
        log.debug('')
        self.prefix = kwargs.get('report-prefix', 'ar-')
        self.suffix = kwargs.get('report-suffix', '')
        self.extension = kwargs.get('report-extension', 'report')
        self.id_length = int(kwargs.get('report-id-length', 8))
        self.id_characters = list(kwargs.get(
            'report-id-characters', string.ascii_letters + string.digits
        ))
        self.location = kwargs.get('report-location', './data/reports')
        self.timestamp_format = kwargs.get(
            'timestamp-format', '%d-%m-%Y.%H:%M:%S'
        )
        if not check_file_exists(self.location):
            ensure_directories_exist(self.location)
        self.identifier = kwargs.get(
            'report-id', generate_msg_id(self.id_length, self.id_characters)
        )
        self.report_generators = {
            'deposit-history': self.generate_deposit_history_report,
            'withdrawal-history': self.generate_withdrawal_history_report,
            'trade-history': self.generate_trade_history_report,
            'current-trades': self.generate_current_trades_report,
            'success-rate': self.generate_success_rate_report,
            'market-snapshot': self.generate_market_snapshot_report,
            'account-snapshot': self.generate_account_snapshot_report,
            'api-permissions': self.generate_api_permissions_report,
            'coin-details': self.generate_coin_details_report,
        }

    # INTERFACE

#   @pysnooper.snoop()
    def view(self, *args, **kwargs):
        '''
        [ NOTE ]: Lists existing reports.
        '''
        log.debug('')
        stdout_msg(
            'Listing all reports in location... ({})'.format(self.location),
            info=True
        )
        out, err, exit  = shell_cmd('ls -1 ' + self.location)
        report_files = out.replace('b\'', '').replace('\'', '').split('\\n')
        if "'" in report_files:
            report_files.remove('\'')
        if '' in report_files:
            report_files.remove('')
        existing_report_ids = {
            file_path.split('.')[0]: self.location + '/' + file_path \
            for file_path in report_files if file_path
        }
        specified_report_ids = {
            report_id: existing_report_ids[report_id] \
            for report_id in args if report_id
        }
        target_report_ids = existing_report_ids if not specified_report_ids \
            else specified_report_ids
        if not existing_report_ids:
            stdout_msg('No reports found!', nok=True)
        elif not kwargs.get('silent'):
            stdout_msg(
                '{}'.format(pretty_dict_print(target_report_ids)),
                symbol='REPORTS', bold=True,
            )
        return target_report_ids

#   @pysnooper.snoop()
    def remove(self, *args, **kwargs):
        '''
        [ NOTE ]: Deletes specified report files or all if none specified.
        '''
        log.debug('')
        details = kwargs.copy()
        details['silent'] = True
        all_reports, failures = dict(self.view(**details)), 0
        report_ids = list(all_reports.keys()) \
            if not args or len(args) == 1 and args[0] == '' else args
        for report_id in report_ids:
            if not report_id or report_id not in all_reports:
                failures += 1
                continue
            file_path = all_reports[report_id]
            out, err, exit = shell_cmd('rm ' + file_path + ' 2> /dev/null')
            if exit == 0:
                stdout_msg(
                    'Removed report {} - {}'.format(report_id, file_path),
                    ok=True,
                )
            else:
                stdout_msg(
                    'Could not remove report {} - {}'.format(
                        report_id, file_path
                    ), nok=True
                )
        return False if failures else True

#   @pysnooper.snoop()
    def read(self, *args, **kwargs):
        '''
        [ NOTE ]: Displays the content of an existing report.
        '''
        log.debug('')
        details = kwargs.copy()
        details['silent'] = True
        all_reports, failures = dict(self.view(**details)), 0
        report_ids = list(all_reports.keys()) \
            if not args or len(args) == 1 and args[0] == '' else args
        for report_id in report_ids:
            if report_id not in all_reports:
                failures += 1
                stdout_msg(
                    'Invalid report ID! ({})'.format(report_id), nok=True
                )
                continue
            self.display_report_content(report_id, all_reports[report_id])
        return False if failures else True

#   @pysnooper.snoop()
    def generate(self, *args, **kwargs):
        '''
        [ NOTE ]: High level interface function for report generation. Currently
                  supports trade history reports, current (active) trades and
                  success rate.

        [ NOTE ]: Whenever a report is generated, it is also written to a file
                  in JSON format.

        [ INPUT ]: *args - (<report-type>, ...)

                   **kwargs - Context + {
                        ...
                        'evaluation': {
                            'buy': {},
                            'sell': {},
                        },
                        ...
                   }

        [ RETURN ]: {
            'flag': False,
            'reports': {
                'trade-history': {
                    'timestamp': '',
                    'report-id': '',
                    'report-type': '',
                    'report-location': '',
                    'raw-data': {},
                    'report': {},
                },
                'deposit-history': {
                    'timestamp': '',
                    ...
                },
                'withdrawal-history': {
                    'timestamp': '',
                    ...
                },
                'current-trades': {
                    'timestamp': '',
                    ...
                },
                'success-rate': {
                    'timestamp': '',
                    ...
                },
                'market-snapshot': {
                    'timestamp': '',
                    ...
                },
                'account-snapshot': {
                    'timestamp': '',
                    ...
                },
                'coin-details': {
                    'timestamp': '',
                    ...
                },
                'api-permissions': {
                    'timestamp': '',
                    ...
                },
            }
            'errors': [{msg: '', type: '', code: ,}],
        }
        '''
        log.debug('')
        return_dict = {
            'flag': False,
            'reports': {
                'trade-history': {},
                'deposit-history': {},
                'withdrawal-history': {},
                'current-trades': {},
                'success-rate': {},
                'market-snapshot': {},
                'account-snapshot': {},
                'coin-details': {},
                'api-permissions': {},
            },
            'errors': [],
        }
        report_labels = args or list(self.report_generators.keys())
        for label in report_labels:
            if label not in self.report_generators.keys():
                continue
            generate = self.report_generators[label](**kwargs)
            if generate and isinstance(generate, dict):
                return_dict['reports'][label].update(generate)
            else:
                return_dict['errors'].append({
                    'msg': 'Could not generate {} report!'.format(label),
                    'type': 'Reporter High Level ERROR',
                    'code': 10,
                    'details': generate,
                })
        return return_dict

    # GENERAL

    def display_report_content(self, report_id, file_path, **kwargs):
        log.debug('')
        stdout_msg(
            '{} - {}\n{}\n'.format(
                report_id, file_path, pretty_dict_print(json2dict(file_path))
            ), symbol='REPORT', bold=True
        )
        return True

    def write_report_to_file(self, return_dict, *args, **kwargs):
        log.debug('')
        report_file_path = return_dict['report-location'] + '/' \
            + return_dict['report-id'] + return_dict['report-extension']
        write = write2file(
            dict2json(return_dict), file_path=report_file_path, mode='w'
        )
        if not write:
            stdout_msg(
                'Could not write Trade History report to file! ({})'.format(
                    report_file_path
                ), err=True
            )
        else:
            return_dict.update({'report-file': report_file_path})
        return return_dict

    # GENERATORS

    def generate_coin_details_report(self, *args, **kwargs):
        log.debug('')
        return_dict = self.generate_default_report_details(*args, **kwargs)
        return_dict.update({
            'report-extension': '.cdt',
            'report-type': 'Coin Details',
        })
        return_dict.update(
            self.format_coin_details_report_details(*args, **kwargs)
        )
        write_to_file = self.write_report_to_file(return_dict, **kwargs)
        return return_dict

    def generate_api_permissions_report(self, *args, **kwargs):
        log.debug('')
        return_dict = self.generate_default_report_details(*args, **kwargs)
        return_dict.update({
            'report-extension': '.api',
            'report-type': 'Api Permissions',
        })
        return_dict.update(
            self.format_api_permissions_report_details(*args, **kwargs)
        )
        write_to_file = self.write_report_to_file(return_dict, **kwargs)
        return return_dict

    def generate_market_snapshot_report(self, *args, **kwargs):
        log.debug('')
        return_dict = self.generate_default_report_details(*args, **kwargs)
        return_dict.update({
            'report-extension': '.mks',
            'report-type': 'Market Snapshot',
        })
        return_dict.update(
            self.format_market_snapshot_report_details(*args, **kwargs)
        )
        write_to_file = self.write_report_to_file(return_dict, **kwargs)
        return return_dict

    def generate_account_snapshot_report(self, *args, **kwargs):
        log.debug('')
        return_dict = self.generate_default_report_details(*args, **kwargs)
        return_dict.update({
            'report-extension': '.acs',
            'report-type': 'Account Snapshot',
        })
        return_dict.update(
            self.format_account_snapshot_report_details(*args, **kwargs)
        )
        write_to_file = self.write_report_to_file(return_dict, **kwargs)
        return return_dict

    def generate_withdrawal_history_report(self, *args, **kwargs):
        log.debug('')
        return_dict = self.generate_default_report_details(*args, **kwargs)
        return_dict.update({
            'report-extension': '.wdr',
            'report-type': 'Withdrawals',
        })
        return_dict.update(
            self.format_withdrawal_report_details(*args, **kwargs)
        )
        write_to_file = self.write_report_to_file(return_dict, **kwargs)
        return return_dict

    def generate_deposit_history_report(self, *args, **kwargs):
        log.debug('')
        return_dict = self.generate_default_report_details(*args, **kwargs)
        return_dict.update({
            'report-extension': '.dep',
            'report-type': 'Deposits',
        })
        return_dict.update(
            self.format_deposit_report_details(*args, **kwargs)
        )
        write_to_file = self.write_report_to_file(return_dict, **kwargs)
        return return_dict

    def generate_current_trades_report(self, *args, **kwargs):
        log.debug('')
        return_dict = self.generate_default_report_details(*args, **kwargs)
        return_dict.update({
            'report-extension': '.ctd',
            'report-type': 'Current Trades',
        })
        return_dict.update(
            self.format_current_trades_report_details(*args, **kwargs)
        )
        write_to_file = self.write_report_to_file(return_dict, **kwargs)
        return return_dict

    def generate_success_rate_report(self, *args, **kwargs):
        log.debug('')
        return_dict = self.generate_default_report_details(*args, **kwargs)
        return_dict.update({
            'report-extension': '.srt',
            'report-type': 'Success Rate',
        })
        return_dict.update(
            self.format_success_rate_report_details(*args, **kwargs)
        )
        write_to_file = self.write_report_to_file(return_dict, **kwargs)
        return return_dict

    def generate_trade_history_report(self, *args, **kwargs):
        log.debug('')
        return_dict = self.generate_default_report_details(*args, **kwargs)
        return_dict.update({
            'report-extension': '.ths',
            'report-type': 'Trade History',
        })
        return_dict.update(
            self.format_trade_history_report_details(*args, **kwargs)
        )
        write_to_file = self.write_report_to_file(return_dict, **kwargs)
        return return_dict

    def generate_default_report_details(self, *args, **kwargs):
        log.debug('')
        return_dict = {
            'timestamp': datetime.datetime.now().strftime(self.timestamp_format),
            'report-id': generate_msg_id(
                self.id_length, id_characters=self.id_characters
            ),
            'report-location': self.location,
        }
        return return_dict

    # FORMATTERS

    def format_api_permissions_report_details(self, *args, **kwargs):
        log.debug('TODO - Actually format something pretty, bro')
        log.debug('args, kwargs - {}, {}'.format(args, kwargs))
        if not kwargs.get('raw-report-data') or \
                not kwargs['raw-report-data'].get('api-permissions'):
            return {}
        # TODO - Formatt report data
        return {
#           'raw-data': kwargs['raw-report-data']['api-permissions'],
            'report': kwargs['raw-report-data']['api-permissions'],
        }

    def format_coin_details_report_details(self, *args, **kwargs):
        log.debug('TODO - Actually format something pretty, bro')
        log.debug('args, kwargs - {}, {}'.format(args, kwargs))
        if not kwargs.get('raw-report-data') or \
                not kwargs['raw-report-data'].get('coin-details'):
            return {}
        # TODO - Formatt report data
        return {
#           'raw-data': kwargs['raw-report-data']['coin-details'],
            'report': kwargs['raw-report-data']['coin-details'],
        }

    def format_market_snapshot_report_details(self, *args, **kwargs):
        log.debug('TODO - Actually format something pretty, bro')
        log.debug('args, kwargs - {}, {}'.format(args, kwargs))
        if not kwargs.get('raw-report-data') or \
                not kwargs['raw-report-data'].get('market-snapshot'):
            return {}
        # TODO - Formatt report data
        return {
#           'raw-data': kwargs['raw-report-data']['market-snapshot'],
            'report': kwargs['raw-report-data']['market-snapshot'],
        }

    def format_account_snapshot_report_details(self, *args, **kwargs):
        log.debug('TODO - Actually format something pretty, bro')
        log.debug('args, kwargs - {}, {}'.format(args, kwargs))
        if not kwargs.get('raw-report-data') or \
                not kwargs['raw-report-data'].get('account-snapshot'):
            return {}
        # TODO - Formatt report data
        return {
#           'raw-data': kwargs['raw-report-data']['account-snapshot'],
            'report': kwargs['raw-report-data']['account-snapshot'],
        }

    def format_withdrawal_report_details(self, *args, **kwargs):
        log.debug('TODO - Actually format something pretty, bro')
        log.debug('args, kwargs - {}, {}'.format(args, kwargs))
        if not kwargs.get('raw-report-data') or \
                not kwargs['raw-report-data'].get('withdrawal-history'):
            return {}
        # TODO - Formatt report data
        return {
#           'raw-data': kwargs['raw-report-data']['withdrawal-history'],
            'report': kwargs['raw-report-data']['withdrawal-history'],
        }

    def format_deposit_report_details(self, *args, **kwargs):
        log.debug('TODO - Actually format something pretty, bro')
        log.debug('args, kwargs - {}, {}'.format(args, kwargs))
        if not kwargs.get('raw-report-data') or \
                not kwargs['raw-report-data'].get('deposit-history'):
            return {}
        # TODO - Formatt report data
        return {
#           'raw-data': kwargs['raw-report-data']['deposit-history'],
            'report': kwargs['raw-report-data']['deposit-history'],
        }

    def format_current_trades_report_details(self, *args, **kwargs):
        log.debug('TODO - Actually format something pretty, bro')
        log.debug('args, kwargs - {}, {}'.format(args, kwargs))
        if not kwargs.get('raw-report-data') or \
                not kwargs['raw-report-data'].get('current-trades'):
            return {}
        # TODO - Formatt report data
        return {
#           'raw-data': kwargs['raw-report-data']['current-trades'],
            'report': kwargs['raw-report-data']['current-trades'],
        }

    def format_success_rate_report_details(self, *args, **kwargs):
        log.debug('TODO - Actually format something pretty, bro')
        log.debug('args, kwargs - {}, {}'.format(args, kwargs))
        if not kwargs.get('raw-report-data') or \
                not kwargs['raw-report-data'].get('success-rate'):
            return {}
        # TODO - Formatt report data
        return {
#           'raw-data': kwargs['raw-report-data']['success-rate'],
            'report': kwargs['raw-report-data']['success-rate'],
        }

    def format_trade_history_report_details(self, *args, **kwargs):
        log.debug('TODO - Actually format something pretty, bro')
        log.debug('args, kwargs - {}, {}'.format(args, kwargs))
        if not kwargs.get('raw-report-data') or \
                not kwargs['raw-report-data'].get('trade-history'):
            return {}
        # TODO - Formatt report data
        return {
#           'raw-data': kwargs['raw-report-data']['trade-history'],
            'report': kwargs['raw-report-data']['trade-history'],
        }

# CODE DUMP

