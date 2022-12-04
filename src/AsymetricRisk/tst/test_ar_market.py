import unittest
import os

from src.ar_market import TradingMarket
from src.backpack.bp_convertors import json2dict


class TestARMarket(unittest.TestCase):

    conf_file = 'conf/asymetric_risk.conf.json' \
        if os.path.exists('conf/asymetric_risk.conf.json') else ''
    AR_DEFAULT = json2dict(conf_file)['AR_DEFAULT']
    api_key = AR_DEFAULT.get('api-key', '')
    api_secret = AR_DEFAULT.get('api-secret', '')
    taapi_key = AR_DEFAULT.get('taapi-key', '')

    # PREREQUISITS

    @classmethod
    def setUpClass(cls):
        print('\n[ TradingMarket ]: Functional test suit -\n')
        cls.trading_market = TradingMarket(
            cls.api_key, cls.api_secret, sync=True, **{
                'base-currency': 'BTC',
                'api-url': 'https://testnet.binance.vision/api',
                'api-key': cls.api_key,
                'api-secret': cls.api_secret,
                'taapi-key': cls.taapi_key,
                'quote-currency': 'USDT',
            }
        )

    @classmethod
    def tearDownClass(cls):
        print('\n[ DONE ]: TradingMarket\n')

    # TESTERS

    def test_ar_market_close_position(self):
        print('\n[ TEST ]: Market Close\n')
        details = self.AR_DEFAULT.copy()
        details.update({
            'symbol': 'BTCUSDT',
            'order-recv-window': 60000,
        })
        buy_order = self.trading_market.buy(0.0002, **details)
        self.assertTrue(buy_order)
        close_ok, close_nok = self.trading_market.close_position(
            buy_order.get('orderId')
        )
        self.assertTrue(isinstance(close_ok, list))
        self.assertTrue(isinstance(close_nok, list))
        self.assertFalse(close_nok)

    def test_ar_market_trade(self):
        print('\n[ TEST ]: Market Trade Order\n')
        details, trade_amount = self.AR_DEFAULT.copy(), 0.0002
        details.update({
            'take_profit': 30,
            'stop_loss': 10,
            'trailing_stop': 10,
            'side': 'auto',
        })
        order = self.trading_market.trade(trade_amount, **details)
        self.assertTrue(isinstance(order, dict))

    def test_ar_market_buy(self):
        print('\n[ TEST ]: Market Buy Order\n')
        details, trade_amount = self.AR_DEFAULT.copy(), 0.0002
        details.update({
            'take_profit': 30,
            'stop_loss': 10,
            'trailing_stop': 10,
        })
        buy_order = self.trading_market.buy(trade_amount, **details)
        self.assertTrue(isinstance(buy_order, dict))

    def test_ar_market_sell(self):
        print('\n[ TEST ]: Market Sell Order\n')
        details, trade_amount = self.AR_DEFAULT.copy(), 0.0002
        details.update({
            'take_profit': 30,
            'stop_loss': 10,
            'trailing_stop': 10,
        })
        sell_order = self.trading_market.sell(trade_amount, **details)
        self.assertTrue(isinstance(sell_order, dict))

    def test_ar_market_update_details(self):
        print('\n[ TEST ]: Update Market Details\n')
        details = self.AR_DEFAULT.copy()
        update_details = self.trading_market.update_details('all', **details)
        self.assertTrue(isinstance(update_details, dict))
        self.assertFalse(update_detauls.get('error', False))

    def test_ar_market_synced(self):
        print('\n[ TEST ]: Synced Account Details\n')
        account_info = self.trading_market.synced(
            'get_account', recvWindow=60000
        )
        self.assertTrue(account_info)

# CODE DUMP

