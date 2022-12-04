import unittest
import os
import threading
import time

from src.ar_bot import TradingBot
from src.ar_strategy import TradingStrategy
from src.ar_reporter import TradingReporter
from src.backpack.bp_convertors import json2dict


class TestARBot(unittest.TestCase):

    conf_file = 'conf/asymetric_risk.conf.json' \
        if os.path.exists('conf/asymetric_risk.conf.json') else ''
    AR_DEFAULT = json2dict(conf_file)['AR_DEFAULT']
    api_key = AR_DEFAULT.get('api-key', '')
    api_secret = AR_DEFAULT.get('api-secret', '')
    taapi_key = AR_DEFAULT.get('taapi-key', '')
    trading_strategies = (
        'rsi', 'vwap', 'ma', 'ema', 'macd', 'adx', 'price', 'volume',
        'intuition-reversal'
    )
    report_types = (
        'trade-history', 'deposit-history', 'withdrawal-history', 'current-trades',
        'success-rate', 'coin-details', 'api-permissions', 'account-snapshot',
        'market-snapshot'
    )
    nightly_reports = (
        'current-trades', 'success-rate', 'account-snapshot', 'api-permissions'
    )

    # PREREQUISITS

    @classmethod
    def setUpClass(cls):
        print('\n[ TradingBot ]: Functional test suit -\n')
        cls.tbot_kwargs = cls.fetch_trading_market_kwargs('BTC', 'USDT')
        cls.trading_bot = TradingBot(**cls.tbot_kwargs)
        cls.trading_bot.setup_market(**cls.AR_DEFAULT)

    @classmethod
    def tearDownClass(cls):
        print('\n[ DONE ]: TradingBot\n')

    # FETCHERS

    @classmethod
    def fetch_trading_market_kwargs(cls, base_currency, quote_currency):
        return {
            'base-currency': base_currency,
            'quote-currency': quote_currency,
            'ticker-symbol': base_currency + '/' + quote_currency,
            'api-url': 'https://testnet.binance.vision/api',
            'api-key': cls.api_key,
            'api-secret': cls.api_secret,
            'taapi-key': cls.taapi_key,
            'market-sync': True,
            'test': True,
        }

    @classmethod
    def fetch_trade_kwargs(cls, **kwargs):
        return_dict = kwargs.copy()
        return_dict['test'] = True
        return return_dict

    @classmethod
    def fetch_trading_report_setup_kwargs(cls, **kwargs):
        return cls.tbot_kwargs

    @classmethod
    def fetch_strategy_analyzer_setup_kwargs(cls, **kwargs):
        return cls.tbot_kwargs

    # GENERAL

    def remove_file(self, file_path, *args, delay=3, **kwargs):
        time.sleep(delay)
        if not os.path.exists(file_path):
            return False
        return os.remove(file_path)

    # AUTO TESTERS

    def test_generate_report(self):
        print('\n[ TEST ]: Generate Report\n')
        report = self.trading_bot.generate_report(*self.report_types, **self.AR_DEFAULT)
        self.assertTrue(report)

    def test_generate_nightly_report(self):
        print('\n[ TEST ]: Generate Nightly Reports\n')
        report = self.trading_bot.generate_nightly_reports(**self.AR_DEFAULT)
        self.assertTrue(report)

    def test_list_reports(self):
        print('\n[ TEST ]: List Reports\n')
        list_reports = self.trading_bot.list_reports(**self.AR_DEFAULT)
        self.assertTrue(list_reports)

    def test_select_market(self):
        print('\n[ TEST ]: Select Market\n')
        action_kwargs = self.fetch_trading_market_kwargs('BTC', 'USDT')
        enter_market = self.trading_bot.enter_market(**action_kwargs)
        select_market = self.trading_bot.select_market('BTC/USDT')
        self.assertTrue(select_market)

    def test_enter_market(self):
        print('\n[ TEST ]: Enter Market\n')
        action_kwargs = self.fetch_trading_market_kwargs('BTC', 'USDT')
        enter_market = self.trading_bot.enter_market(**action_kwargs)
        self.assertTrue(enter_market)

    def test_exit_market(self):
        print('\n[ TEST ]: Exit Market\n')
        exit_market = self.trading_bot.exit_market('BTC/USDT')
        self.assertTrue(exit_market)
        self.assertTrue(isinstance(exit_market, dict))
        self.assertFalse(exit_market.get('error', False))

    def test_trade(self):
        print('\n[ TEST ]: Trade\n')
        trade = self.trading_bot.trade(
            *self.trading_strategies, **self.fetch_trade_kwargs(**self.AR_DEFAULT)
        )
        self.assertFalse(trade.get('error', True))

    def test_watchdog(self):
        print('\n[ TEST ]: Start Trading Bot Watchdog\n')
        process_anchor_file = '.ar.test.anch'
        with open(process_anchor_file, 'w') as fl:
            fl.write('.')
        t = threading.Thread(
            target=self.remove_file,
            args=(process_anchor_file, ),
            name='Watchdog Killer'
        )
        t.daemon = True
        t.start()
        details = self.AR_DEFAULT.copy()
        details['anchor-file'] = process_anchor_file
        trade = self.trading_bot.trade_watchdog(
            **details
        )
        self.assertEqual(trade, 0)

    def test_setup_reporter(self):
        print('\n[ TEST ]: Setup Trade Reporter\n')
        action_kwargs = self.fetch_trading_report_setup_kwargs()
        setup = self.trading_bot.setup_reporter(**action_kwargs)
        self.assertTrue(isinstance(setup, TradingReporter))

    def test_setup_analyzer(self):
        print('\n[ TEST ]: Setup Strategy Analyzer\n')
        action_kwargs = self.fetch_strategy_analyzer_setup_kwargs()
        setup = self.trading_bot.setup_analyzer(**action_kwargs)
        self.assertTrue(isinstance(setup, TradingStrategy))

    def test_view_trades(self):
        print('\n[ TEST ]: View Active Trades\n')
        view = self.trading_bot.view_trades(**self.AR_DEFAULT)
        self.assertTrue(view)

    def test_view_trade_history(self):
        print('\n[ TEST ]: View Trade History\n')
        view = self.trading_bot.view_trade_history(**self.AR_DEFAULT)
        self.assertTrue(view)

# CODE DUMP

