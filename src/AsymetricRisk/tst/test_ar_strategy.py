import unittest
import os
import time
import json

from src.ar_strategy import TradingStrategy
from src.backpack.bp_convertors import json2dict


class TestARStrategyAnalyzer(unittest.TestCase):

    conf_file = 'conf/asymetric_risk.conf.json' \
        if os.path.exists('conf/asymetric_risk.conf.json') else ''
    AR_DEFAULT = json2dict(conf_file)['AR_DEFAULT']
    api_key = AR_DEFAULT.get('api-key', '')
    api_secret = AR_DEFAULT.get('api-secret', '')
    taapi_key = AR_DEFAULT.get('taapi-key', '')
    strategy = 'vwap,rsi,macd,ema,ma,adx,volume,price'
    side = 'auto'
    risk_tolerance = 5

    # PREREQUISITS

    @classmethod
    def setUpClass(cls):
        print('\n[ TradingStrategy ]: Functional test suit -\n')
        cls.analyzer = TradingStrategy(**{'risk-tolerance': cls.risk_tolerance})
        cls.analyzer_details = cls.format_risk_analyzer_mock_details()
        cls.evaluator_details = cls.format_evaluator_mock_details()
        cls.evaluator_kwargs = cls.format_evaluator_kwargs()

    @classmethod
    def tearDownClass(cls):
        print('\n[ DONE ]: TradingStrategy\n')

    # FORMATTERS

    @classmethod
    def format_risk_analyzer_mock_details(cls):
        return {
            'ticker-symbol': 'BTC/USDT',
            'buy-price': 20903.77,
            'sell-price': 20904.5,
            'volume': 7270.56273,
            'indicators': {
                'adx': 25.79249660682844,
                'macd': -55.08962670456458,
                'macd-signal': -18.088430567653305,
                'macd-hist': -37.001196136911275,
                'ma': 21216.220666666643,
                'ema': 21216.220700066643,
                'rsi': 25.931456303405913,
                'vwap': 20592.650164735693
            },
            'history': {
                'adx': [
                    {
                        "adx": 51.901355849061474,
                        "plusdi": 24.61502060003877,
                        "minusdi": 8.311985604219744,
                        "backtrack": 0
                    },
                    {
                        "adx": 52.08510206539891,
                        "plusdi": 25.490600182017705,
                        "minusdi": 8.936025232398162,
                        "backtrack": 1
                    },
                ],
                'macd': [
                    {
                        "valueMACD": 29.731306570502056,
                        "valueMACDSignal": 29.152685475602173,
                        "valueMACDHist": 0.5786210948998836,
                        "backtrack": 0
                    },
                    {
                        "valueMACD": 31.62907268775598,
                        "valueMACDSignal": 29.0080302018772,
                        "valueMACDHist": 2.621042485878778,
                        "backtrack": 1
                    },
                ],
                'ma': [
                    {'value': 21216.220666666643, 'backtrack': 0},
                    {'value': 21216.220666666643, 'backtrack': 1}
                ],
                'ema': [
                    {'value': 21216.220700066643, 'backtrack': 0},
                    {'value': 21216.220700066643, 'backtrack': 1}
                ],
                'rsi': [
                    {'value': 25.931456303405913, 'backtrack': 0},
                    {'value': 25.931456303405913, 'backtrack': 1}
                ],
                'vwap': [
                    {'value': 20592.650164735693, 'backtrack': 0},
                    {'value': 20592.650164735693, 'backtrack': 1}
                ],
                'price': [
                    {'value': 20903.77, 'backtrack': 0},
                    {'value': 20903.77, 'backtrack': 1}
                ],
                'volume': [
                    {'value': 7270.56273, 'backtrack': 0},
                    {'value': 7270.56273, 'backtrack': 1}
                ],
            }
        }

    @classmethod
    def format_evaluator_mock_details(cls):
        return {
            'price': {
                'price-movement': {
                    'flag': False, 'start-value': 20603.77, 'stop-value': 20903.77
                },
                'confirmed-by-volume': {
                    'flag': False, 'start-value': 7100.56273, 'stop-value': 7270.56273
                },
                'interval': '1h',
                'value': 20903.77,
                'risk': 0,
                'trade': False,
                'description': 'Price Action Strategy',
            },
        }

    @classmethod
    def format_evaluator_kwargs(cls):
        details = cls.AR_DEFAULT.copy()
        details.update({
            'strategy': cls.strategy,
            'side': cls.side,
            'details': cls.analyzer_details or cls.format_risk_analyzer_mock_details()
        })
        return details

    def new_strategy(self, *args, **kwargs):
        return {
            'error': False,
        }

    # TESTERS

    def test_load_strategy(self):
        print('\n[ TEST ]: Load Strategy\n')
        load = self.analyzer.load_strategy(**{'new': self.new_strategy})
        self.assertTrue(load)
        self.assertTrue(isinstance(load, dict))
        self.assertFalse(load.get('error', False))
        self.assertTrue(self.analyzer.strategies.get('new', False))

    def test_set_risk_tolerance(self):
        print('\n[ TEST ]: Set Risk Tolerance\n')
        set_risk = self.analyzer.set_risk_tolerance(1)
        self.assertTrue(set_risk)
        self.assertTrue(isinstance(set_risk, int))

    def test_analyze_risk(self):
        print('\n[ TEST ]: Analyze Risk\n')
        trade_flag, risk_index, trade_side, exit_code = self.analyzer.analyze_risk(
            **self.evaluator_kwargs
        )
        self.assertTrue(isinstance(trade_flag, bool))
        self.assertTrue(isinstance(risk_index, int))
        self.assertTrue(isinstance(trade_side, str))
        self.assertEqual(exit_code, 0)

    def test_evaluate_high_risk_tolerance(self):
        print('\n[ TEST ]: Evaluate High Risk Tolerance\n')
        trade_flag, risk_index, trade_side = self.analyzer.evaluate_high_risk_tolerance(
            self.evaluator_details, **self.evaluator_kwargs
        )
        self.assertTrue(isinstance(trade_flag, bool))
        self.assertTrue(isinstance(risk_index, int))
        self.assertTrue(isinstance(trade_side, str))

    def test_evaluate_mid_high_risk_tolerance(self):
        print('\n[ TEST ]: Evaluate Mid-High Risk Tolerance\n')
        trade_flag, risk_index, trade_side = self.analyzer.evaluate_mid_high_risk_tolerance(
            self.evaluator_details, **self.evaluator_kwargs
        )
        self.assertTrue(isinstance(trade_flag, bool))
        self.assertTrue(isinstance(risk_index, int))
        self.assertTrue(isinstance(trade_side, str))

    def test_evaluate_mid_risk_tolerance(self):
        print('\n[ TEST ]: Evaluate Mid Risk Tolerance\n')
        trade_flag, risk_index, trade_side = self.analyzer.evaluate_mid_risk_tolerance(
            self.evaluator_details, **self.evaluator_kwargs
        )
        self.assertTrue(isinstance(trade_flag, bool))
        self.assertTrue(isinstance(risk_index, int))
        self.assertTrue(isinstance(trade_side, str))

    def test_evaluate_low_mid_risk_tolerance(self):
        print('\n[ TEST ]: Evaluate Low-Mid Risk Tolerance\n')
        trade_flag, risk_index, trade_side = self.analyzer.evaluate_low_mid_risk_tolerance(
            self.evaluator_details, **self.evaluator_kwargs
        )
        self.assertTrue(isinstance(trade_flag, bool))
        self.assertTrue(isinstance(risk_index, int))
        self.assertTrue(isinstance(trade_side, str))

    def test_evaluate_low_risk_tolerance(self):
        print('\n[ TEST ]: Evaluate Low Risk Tolerance\n')
        trade_flag, risk_index, trade_side = self.analyzer.evaluate_low_risk_tolerance(
            self.evaluator_details, **self.evaluator_kwargs
        )
        self.assertTrue(isinstance(trade_flag, bool))
        self.assertTrue(isinstance(risk_index, int))
        self.assertTrue(isinstance(trade_side, str))

    def test_strategy_intuition_reversal(self):
        print('\n[ TEST ]: Strategy Intuition Reversal Buy\n')
        details = self.evaluator_kwargs.copy()
        details['side'] = 'buy'
        buy_strategy = self.analyzer.strategy_intuition_reversal(
            *self.strategy.split(','), **details
        )
        self.assertTrue(buy_strategy)
        self.assertTrue(isinstance(buy_strategy, dict))
        self.assertFalse(buy_strategy.get('error', False))
        print('\n[ TEST ]: Strategy Intuition Reversal Sell\n')
        details['side'] = 'sell'
        sell_strategy = self.analyzer.strategy_intuition_reversal(
            *self.strategy.split(','), **details
        )
        self.assertTrue(sell_strategy)
        self.assertTrue(isinstance(sell_strategy, dict))
        self.assertFalse(sell_strategy.get('error', False))
        print('\n[ TEST ]: Strategy Intuition Reversal Auto\n')
        details['side'] = 'auto'
        auto_strategy = self.analyzer.strategy_intuition_reversal(
            *self.strategy.split(','), **details
        )
        self.assertTrue(auto_strategy)
        self.assertTrue(isinstance(auto_strategy, dict))
        self.assertFalse(auto_strategy.get('error', False))

    def test_strategy_vwap(self):
        print('\n[ TEST ]: Strategy VWAP Buy\n')
        details = self.evaluator_kwargs.copy()
        details['side'] = 'buy'
        buy_strategy = self.analyzer.strategy_vwap(
            **details
        )
        self.assertTrue(buy_strategy)
        self.assertTrue(isinstance(buy_strategy, dict))
        self.assertFalse(buy_strategy.get('error', False))
        print('\n[ TEST ]: Strategy VWAP Sell\n')
        details['side'] = 'sell'
        sell_strategy = self.analyzer.strategy_vwap(
            **details
        )
        self.assertTrue(sell_strategy)
        self.assertTrue(isinstance(sell_strategy, dict))
        self.assertFalse(sell_strategy.get('error', False))
        print('\n[ TEST ]: Strategy VWAP Auto\n')
        details['side'] = 'auto'
        auto_strategy = self.analyzer.strategy_vwap(
            **details
        )
        self.assertTrue(auto_strategy)
        self.assertTrue(isinstance(auto_strategy, dict))
        self.assertFalse(auto_strategy.get('error', False))

    def test_strategy_rsi(self):
        print('\n[ TEST ]: Strategy RSI Buy\n')
        details = self.evaluator_kwargs.copy()
        details['side'] = 'buy'
        buy_strategy = self.analyzer.strategy_rsi(
            **details
        )
        self.assertTrue(buy_strategy)
        self.assertTrue(isinstance(buy_strategy, dict))
        self.assertFalse(buy_strategy.get('error', False))
        print('\n[ TEST ]: Strategy RSI Sell\n')
        details['side'] = 'sell'
        sell_strategy = self.analyzer.strategy_rsi(
            **details
        )
        self.assertTrue(sell_strategy)
        self.assertTrue(isinstance(sell_strategy, dict))
        self.assertFalse(sell_strategy.get('error', False))
        print('\n[ TEST ]: Strategy RSI Auto\n')
        details['side'] = 'auto'
        auto_strategy = self.analyzer.strategy_rsi(
            **details
        )
        self.assertTrue(auto_strategy)
        self.assertTrue(isinstance(auto_strategy, dict))
        self.assertFalse(auto_strategy.get('error', False))

    def test_strategy_macd(self):
        print('\n[ TEST ]: Strategy MACD Buy\n')
        details = self.evaluator_kwargs.copy()
        details['side'] = 'buy'
        buy_strategy = self.analyzer.strategy_macd(
            **details
        )
        self.assertTrue(buy_strategy)
        self.assertTrue(isinstance(buy_strategy, dict))
        self.assertFalse(buy_strategy.get('error', False))
        print('\n[ TEST ]: Strategy MACD Sell\n')
        details['side'] = 'sell'
        sell_strategy = self.analyzer.strategy_macd(
            **details
        )
        self.assertTrue(sell_strategy)
        self.assertTrue(isinstance(sell_strategy, dict))
        self.assertFalse(sell_strategy.get('error', False))
        print('\n[ TEST ]: Strategy MACD Auto\n')
        details['side'] = 'auto'
        auto_strategy = self.analyzer.strategy_macd(
            **details
        )
        self.assertTrue(auto_strategy)
        self.assertTrue(isinstance(auto_strategy, dict))
        self.assertFalse(auto_strategy.get('error', False))

    def test_strategy_ma(self):
        print('\n[ TEST ]: Strategy MA Buy\n')
        details = self.evaluator_kwargs.copy()
        details['side'] = 'buy'
        buy_strategy = self.analyzer.strategy_ma(
            **details
        )
        self.assertTrue(buy_strategy)
        self.assertTrue(isinstance(buy_strategy, dict))
        self.assertFalse(buy_strategy.get('error', False))
        print('\n[ TEST ]: Strategy MA Sell\n')
        details['side'] = 'sell'
        sell_strategy = self.analyzer.strategy_ma(
            **details
        )
        self.assertTrue(sell_strategy)
        self.assertTrue(isinstance(sell_strategy, dict))
        self.assertFalse(sell_strategy.get('error', False))
        print('\n[ TEST ]: Strategy MA Auto\n')
        details['side'] = 'auto'
        auto_strategy = self.analyzer.strategy_ma(
            **details
        )
        self.assertTrue(auto_strategy)
        self.assertTrue(isinstance(auto_strategy, dict))
        self.assertFalse(auto_strategy.get('error', False))

    def test_strategy_ema(self):
        print('\n[ TEST ]: Strategy EMA Buy\n')
        details = self.evaluator_kwargs.copy()
        details['side'] = 'buy'
        buy_strategy = self.analyzer.strategy_ema(
            **details
        )
        self.assertTrue(buy_strategy)
        self.assertTrue(isinstance(buy_strategy, dict))
        self.assertFalse(buy_strategy.get('error', False))
        print('\n[ TEST ]: Strategy EMA Sell\n')
        details['side'] = 'sell'
        sell_strategy = self.analyzer.strategy_ema(
            **details
        )
        self.assertTrue(sell_strategy)
        self.assertTrue(isinstance(sell_strategy, dict))
        self.assertFalse(sell_strategy.get('error', False))
        print('\n[ TEST ]: Strategy EMA Auto\n')
        details['side'] = 'auto'
        auto_strategy = self.analyzer.strategy_ema(
            **details
        )
        self.assertTrue(auto_strategy)
        self.assertTrue(isinstance(auto_strategy, dict))
        self.assertFalse(auto_strategy.get('error', False))

    def test_strategy_adx(self):
        print('\n[ TEST ]: Strategy ADX Buy\n')
        details = self.evaluator_kwargs.copy()
        details['side'] = 'buy'
        buy_strategy = self.analyzer.strategy_adx(
            **details
        )
        self.assertTrue(buy_strategy)
        self.assertTrue(isinstance(buy_strategy, dict))
        self.assertFalse(buy_strategy.get('error', False))
        print('\n[ TEST ]: Strategy ADX Sell\n')
        details['side'] = 'sell'
        sell_strategy = self.analyzer.strategy_adx(
            **details
        )
        self.assertTrue(sell_strategy)
        self.assertTrue(isinstance(sell_strategy, dict))
        self.assertFalse(sell_strategy.get('error', False))
        print('\n[ TEST ]: Strategy ADX Auto\n')
        details['side'] = 'auto'
        auto_strategy = self.analyzer.strategy_adx(
            **details
        )
        self.assertTrue(auto_strategy)
        self.assertTrue(isinstance(auto_strategy, dict))
        self.assertFalse(auto_strategy.get('error', False))

    def test_strategy_volume(self):
        print('\n[ TEST ]: Strategy Volume Buy\n')
        details = self.evaluator_kwargs.copy()
        details['side'] = 'buy'
        buy_strategy = self.analyzer.strategy_volume(
            **details
        )
        self.assertTrue(buy_strategy)
        self.assertTrue(isinstance(buy_strategy, dict))
        self.assertFalse(buy_strategy.get('error', False))
        print('\n[ TEST ]: Strategy Volume Sell\n')
        details['side'] = 'sell'
        sell_strategy = self.analyzer.strategy_volume(
            **details
        )
        self.assertTrue(sell_strategy)
        self.assertTrue(isinstance(sell_strategy, dict))
        self.assertFalse(sell_strategy.get('error', False))
        print('\n[ TEST ]: Strategy Volume Auto\n')
        details['side'] = 'auto'
        auto_strategy = self.analyzer.strategy_volume(
            **details
        )
        self.assertTrue(auto_strategy)
        self.assertTrue(isinstance(auto_strategy, dict))
        self.assertFalse(auto_strategy.get('error', False))

    def test_strategy_price(self):
        print('\n[ TEST ]: Strategy Price Action Buy\n')
        details = self.evaluator_kwargs.copy()
        details['side'] = 'buy'
        buy_strategy = self.analyzer.strategy_price(
            **details
        )
        self.assertTrue(buy_strategy)
        self.assertTrue(isinstance(buy_strategy, dict))
        self.assertFalse(buy_strategy.get('error', False))
        print('\n[ TEST ]: Strategy Price Action Sell\n')
        details['side'] = 'sell'
        sell_strategy = self.analyzer.strategy_price(
            **details
        )
        self.assertTrue(sell_strategy)
        self.assertTrue(isinstance(sell_strategy, dict))
        self.assertFalse(sell_strategy.get('error', False))
        print('\n[ TEST ]: Strategy Price Action Auto\n')
        details['side'] = 'auto'
        auto_strategy = self.analyzer.strategy_price(
            **details
        )
        self.assertTrue(auto_strategy)
        self.assertTrue(isinstance(auto_strategy, dict))
        self.assertFalse(auto_strategy.get('error', False))

# CODE DUMP

