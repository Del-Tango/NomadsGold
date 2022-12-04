#!/usr/bin/python3
#
# Excellent Regards, the Alveare Solutions #!/Society -x
#
# ASYMETRIC RISK TRADING INDICATORS

import logging
import pysnooper

from src.backpack.bp_shell import shell_cmd

log = logging.getLogger('AsymetricRisk')


class TradingIndicator():

    def __init__(self, *args, **kwargs):
        self.api_url = kwargs.get('taapi-url', 'https://api.taapi.io')
        self.api_key = kwargs.get('taapi-key', str())

    # SETTERS

    def set_api_url(self, api_url):
        log.debug('')
        self.api_url = api_url
        return self.api_url

    def set_api_secret_key(self, api_key):
        log.debug('')
        self.api_key = api_key
        return self.api_key

    # FORMATTERS

#   @pysnooper.snoop()
    def format_target_url(self, indicator_label, *args, **kwargs):
        '''
        [ RETURN ]: Obviously... right?
        '''
        log.debug('')
        target_url = '{}/{}?'.format(self.api_url, indicator_label)
        action_data = {
            'secret': kwargs.get('secret', self.api_key),
            'exchange': kwargs.get('exchange', 'binance'),
            'symbol': kwargs.get('symbol', 'BTC/USDT'),
            'interval': kwargs.get('interval', '1h'),
            'period': kwargs.get('period'),
            'backtrack': kwargs.get('backtrack'),
            'backtracks': kwargs.get('backtracks'),
            'chart': kwargs.get('chart'),
            'optInFastPeriod': kwargs.get('macd-fast-period'),
            'optInSlowPeriod': kwargs.get('macd-slow-period'),
            'optInSignalPeriod': kwargs.get('macd-signal-period'),
        }
        action_variables = [
            (str(item) + '=' + str(action_data[item])) for item in action_data
            if action_data[item] != None
        ]
        target_url = target_url + str('&'.join(action_variables))
        log.debug('Formatted target URL - {}'.format(target_url))
        return target_url

    # GENERAL

    def api_call(self, url_target, **kwargs):
        '''
        [ RETURN ]: Command STDOUT or False
        '''
        log.debug('')
        out, err, exit = shell_cmd("curl '{}' 2> /dev/null".format(url_target))
        if exit != 0:
            return False
        return out

    # ACTIONS

    def ping(self, **kwargs):
        '''
        [ RETURN ]: True or False
        '''
        log.debug('')
        out, err, exit = shell_cmd(
            "ping -c 1 '{}' 2> /dev/null".format(
                self.api_url.replace('https://', '').replace('http://', '')
            )
        )
        if exit != 0:
            return False
        return True

    def adx(self, **kwargs):
        '''
        [ RETURN ]: Current or backtrack value example -

            {
                "adx": 27.163106189421097,
                "plusdi": 33.32334015840893,
                "minusdi": 10.438557555722891,
            }

        OR - with specified backtracks value -

            [
                {"adx": 37.09463629080951, "plusdi": ..., "minusdi": ..., "backtrack":0},
                {"adx": 37.09463629080951, "plusdi": ..., "minusdi": ..., "backtrack":1},
                ...
            ]
        '''
        log.debug('')
        log.debug('ADX call received kwargs - {}'.format(kwargs))
        details = kwargs.copy()
        if details.get('adx-backtracks') or details.get('backtracks'):
            details.update({'adx-backtrack': None, 'backtrack': None})
        return self.api_call(self.format_target_url('dmi', **{
            'period': details.get('adx-period', details.get('period')),
            'backtrack': details.get('adx-backtrack', details.get('backtrack')),
            'backtracks': details.get('adx-backtracks', details.get('backtracks')),
            'chart': details.get('adx-chart', details.get('chart')),
            'interval': details.get('adx-interval', details.get('interval'))
        }))

    def macd(self, **kwargs):
        '''
        [ RETURN ]: Example - 'b\'{"valueMACD":47.481220348032366,\
            "valueMACDSignal":78.66025805066222,\
            "valueMACDHist":-31.179037702629856}\''
        '''
        log.debug('')
        details = kwargs.copy()
        if details.get('macd-backtracks') or details.get('backtracks'):
            details.update({'macd-backtrack': None, 'backtrack': None})
        return self.api_call(self.format_target_url('macd',  **{
            'backtrack': details.get('macd-backtrack', details.get('backtrack')),
            'backtracks': details.get('macd-backtracks', details.get('backtracks')),
            'chart': details.get('macd-chart', details.get('chart')),
            'interval': details.get('macd-interval', details.get('interval')),
            'macd-fast-period': details.get('macd-fast-period'),
            'macd-slow-period': details.get('macd-slow-period'),
            'macd-signal-period': details.get('macd-signal-period'),
        }))

    def ma(self, **kwargs):
        '''
        [ RETURN ]: Example - 'b\'{"value":21315.933999999987}\''
        '''
        log.debug('')
        details = kwargs.copy()
        if details.get('ma-backtracks') or details.get('backtracks'):
            details.update({'ma-backtrack': None, 'backtrack': None})
        return self.api_call(self.format_target_url('ma', **{
            'period': details.get('ma-period', details.get('period')),
            'backtrack': details.get('ma-backtrack', details.get('backtrack')),
            'backtracks': details.get('ma-backtracks', details.get('backtracks')),
            'chart': details.get('ma-chart', details.get('chart')),
            'interval': details.get('ma-interval', details.get('interval'))
        }))

    def ema(self, **kwargs):
        '''
        [ RETURN ]: Example - 'b\'{"value":20884.645666666664}\''
        '''
        log.debug('')
        details = kwargs.copy()
        if details.get('ema-backtracks') or details.get('backtracks'):
            details.update({'ema-backtrack': None, 'backtrack': None})
        return self.api_call(self.format_target_url('ema', **{
            'period': details.get('ema-period', details.get('period')),
            'backtrack': details.get('ema-backtrack', details.get('backtrack')),
            'backtracks': details.get('ema-backtracks', details.get('backtracks')),
            'chart': details.get('ema-chart', details.get('chart')),
            'interval': details.get('ema-interval', details.get('interval'))
        }))

    def rsi(self, **kwargs):
        '''
        [ RETURN ]: Example - 'b\'{"value":50.978938548271955}\''
        '''
        log.debug('')
        details = kwargs.copy()
        if details.get('rsi-backtracks') or details.get('backtracks'):
            details.update({'rsi-backtrack': None, 'backtrack': None})
        return self.api_call(self.format_target_url('rsi', **{
            'period': kwargs.get('rsi-period', kwargs.get('period')),
            'backtrack': kwargs.get('rsi-backtrack', kwargs.get('backtrack')),
            'backtracks': kwargs.get('rsi-backtracks', kwargs.get('backtracks')),
            'chart': kwargs.get('rsi-chart', kwargs.get('chart')),
            'interval': kwargs.get('rsi-interval', kwargs.get('interval'))
        }))

    def vwap(self, **kwargs):
        '''
        [ RETURN ]: Example - "b\"{"value":20513.436047490202}\""
        '''
        log.debug('')
        details = kwargs.copy()
        if details.get('vwap-backtracks') or details.get('backtracks'):
            details.update({'vwap-backtrack': None, 'backtrack': None})
        return self.api_call(self.format_target_url('vwap', **{
            'period': details.get('vwap-period', details.get('period')),
            'backtrack': details.get('vwap-backtrack', details.get('backtrack')),
            'backtracks': details.get('vwap-backtracks', details.get('backtracks')),
            'chart': details.get('vwap-chart', details.get('chart')),
            'interval': details.get('vwap-interval', details.get('interval'))
        }))

    def price(self, **kwargs):
        '''
        [ RETURN ]: Current or backtrack value example -

            {"value": 27.163106189421097}

        OR - with specified backtracks value -

            [
                {"value": 37.09463629080951,"backtrack":0},
                {"value": 35.014232435139164,"backtrack":1},
                ...
            ]
        '''
        log.debug('')
        log.debug('Price call received kwargs - {}'.format(kwargs))
        details = kwargs.copy()
        if details.get('price-backtracks') or details.get('backtracks'):
            details.update({'price-backtrack': None, 'backtrack': None})
        return self.api_call(self.format_target_url('price', **{
            'period': details.get('price-period', details.get('period')),
            'backtrack': details.get('price-backtrack', details.get('backtrack')),
            'backtracks': details.get('price-backtracks', details.get('backtracks')),
            'chart': details.get('price-chart', details.get('chart')),
            'interval': details.get('price-interval', details.get('interval'))
        }))

# CODE DUMP

