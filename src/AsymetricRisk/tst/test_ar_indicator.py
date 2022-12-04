import unittest
import os
import time
import json

from src.ar_indicator import TradingIndicator
from src.backpack.bp_convertors import json2dict, dict2json
from src.backpack.bp_general import write2file


class TestARIndicator(unittest.TestCase):

    conf_file = 'conf/asymetric_risk.conf.json' \
        if os.path.exists('conf/asymetric_risk.conf.json') else ''
    AR_DEFAULT = json2dict(conf_file)['AR_DEFAULT']
    taapi_key = AR_DEFAULT.get('taapi-key', '')
    taapi_url = AR_DEFAULT.get('taapi-url', 'https://api.taapi.io')
    tmp_file = '/tmp/.ar_test.tmp'
    nok_codes = [401]

    # PREREQUISITS

    @classmethod
    def setUpClass(cls):
        print('\n[ TradingIndicator ]: Functional test suit -\n')
        cls.trading_indicator = TradingIndicator(**{
            'taapi-url': cls.taapi_url,
            'taapi-key': cls.taapi_key,
        })

    @classmethod
    def tearDownClass(cls):
        print('\n[ DONE ]: TradingIndicator\n')

    # GENERAL

    def api_delay_msg(self):
        print(
            'API call delay: {} seconds'.format(
                self.AR_DEFAULT['indicator-update-delay']
            )
        )
        return True

    # TESTERS

    def test_ar_indicator_ping(self):
        print('\n[ TEST ]: Ping\n')
        response_raw = self.trading_indicator.ping()
        self.api_delay_msg()
        time.sleep(self.AR_DEFAULT['indicator-update-delay'])
        self.assertTrue(response_raw)

    def test_ar_indicator_set_api_url(self):
        print('\n[ TEST ]: Set API URL\n')
        response_raw = self.trading_indicator.set_api_url(self.taapi_url)
        self.api_delay_msg()
        time.sleep(self.AR_DEFAULT['indicator-update-delay'])
        self.assertEqual(response_raw, self.taapi_url)

    def test_ar_indicator_set_api_key(self):
        print('\n[ TEST ]: Set API key\n')
        response_raw = self.trading_indicator.set_api_secret_key(self.taapi_key)
        self.api_delay_msg()
        time.sleep(self.AR_DEFAULT['indicator-update-delay'])
        self.assertEqual(response_raw, self.taapi_key)

    def test_ar_indicator_format_target_url(self):
        print('\n[ TEST ]: Format Target URL\n')
        response = self.trading_indicator.format_target_url(
            'rsi', secret=self.taapi_key, exchange='binance', symbol='BTC/USDT',
            interval='1h'
        )
        self.api_delay_msg()
        time.sleep(self.AR_DEFAULT['indicator-update-delay'])
        self.assertEqual(
            response,
            'https://api.taapi.io/rsi?secret={}&exchange=binance&symbol=BTC/USDT&interval=1h'
            .format(self.taapi_key)
        )

    def test_ar_indicator_api_call(self):
        print('\n[ TEST ]: API Call\n')
        formatted_url = self.trading_indicator.format_target_url(
            'rsi', secret=self.taapi_key, exchange='binance', symbol='BTC/USDT',
            interval='1h'
        )
        response_raw = self.trading_indicator.api_call(formatted_url)
        sanitized = ''.join(list(response_raw)[1:]).replace("'", '')
        response_dict = json.loads(sanitized)
        if response_dict.get('statusCode') \
                and response_dict['statusCode'] in self.nok_codes:
            return False
        self.api_delay_msg()
        time.sleep(self.AR_DEFAULT['indicator-update-delay'])
        self.assertTrue(response_raw)

    def test_ar_indicator_adx(self):
        print('\n[ TEST ]: Scrape ADX indicator data\n')
        response_raw = self.trading_indicator.adx(
            secret=self.taapi_key, exchange='binance', symbol='BTC/USDT',
            interval='1h'
        )
        sanitized = ''.join(list(response_raw)[1:]).replace("'", '')
        response_dict = json.loads(sanitized)
        if response_dict.get('statusCode') \
                and response_dict['statusCode'] in self.nok_codes:
            return False
        self.api_delay_msg()
        time.sleep(self.AR_DEFAULT['indicator-update-delay'])
        self.assertTrue(response_raw)

    def test_ar_indicator_macd(self):
        print('\n[ TEST ]: Scrape MACD indicator data\n')
        response_raw = self.trading_indicator.macd(
            secret=self.taapi_key, exchange='binance', symbol='BTC/USDT',
            interval='1h'
        )
        sanitized = ''.join(list(response_raw)[1:]).replace("'", '')
        response_dict = json.loads(sanitized)
        if response_dict.get('statusCode') \
                and response_dict['statusCode'] in self.nok_codes:
            return False
        self.api_delay_msg()
        time.sleep(self.AR_DEFAULT['indicator-update-delay'])
        self.assertTrue(response_raw)

    def test_ar_indicator_ema(self):
        print('\n[ TEST ]: Scrape EMA indicator data\n')
        response_raw = self.trading_indicator.ema(
            secret=self.taapi_key, exchange='binance', symbol='BTC/USDT',
            interval='1h'
        )
        sanitized = ''.join(list(response_raw)[1:]).replace("'", '')
        response_dict = json.loads(sanitized)
        if response_dict.get('statusCode') \
                and response_dict['statusCode'] in self.nok_codes:
            return False
        self.api_delay_msg()
        time.sleep(self.AR_DEFAULT['indicator-update-delay'])
        self.assertTrue(response_raw)

    def test_ar_indicator_ma(self):
        print('\n[ TEST ]: Scrape MA indicator data\n')
        response_raw = self.trading_indicator.ma(
            secret=self.taapi_key, exchange='binance', symbol='BTC/USDT',
            interval='1h'
        )
        sanitized = ''.join(list(response_raw)[1:]).replace("'", '')
        response_dict = json.loads(sanitized)
        if response_dict.get('statusCode') \
                and response_dict['statusCode'] in self.nok_codes:
            return False
        self.api_delay_msg()
        time.sleep(self.AR_DEFAULT['indicator-update-delay'])
        self.assertTrue(response_raw)

    def test_ar_indicator_rsi(self):
        print('\n[ TEST ]: Scrape RSI indicator data\n')
        response_raw = self.trading_indicator.rsi(
            secret=self.taapi_key, exchange='binance', symbol='BTC/USDT',
            interval='1h'
        )
        sanitized = ''.join(list(response_raw)[1:]).replace("'", '')
        response_dict = json.loads(sanitized)
        if response_dict.get('statusCode') \
                and response_dict['statusCode'] in self.nok_codes:
            return False
        self.api_delay_msg()
        time.sleep(self.AR_DEFAULT['indicator-update-delay'])
        self.assertTrue(response_raw)

    def test_ar_indicator_vwap(self):
        print('\n[ TEST ]: Scrape VWAP indicator data\n')
        response_raw = self.trading_indicator.vwap(
            secret=self.taapi_key, exchange='binance', symbol='BTC/USDT',
            interval='1h'
        )
        sanitized = ''.join(list(response_raw)[1:]).replace("'", '')
        response_dict = json.loads(sanitized)
        if response_dict.get('statusCode') \
                and response_dict['statusCode'] in self.nok_codes:
            return False
        self.api_delay_msg()
        time.sleep(self.AR_DEFAULT['indicator-update-delay'])
        self.assertTrue(response_raw)

# CODE DUMP

