import unittest
import os

from src.ar_reporter import TradingReporter
from src.backpack.bp_convertors import json2dict


class TestARReporter(unittest.TestCase):

    conf_file = 'conf/asymetric_risk.conf.json' \
        if os.path.exists('conf/asymetric_risk.conf.json') else ''
    AR_DEFAULT = json2dict(conf_file)['AR_DEFAULT']

    # PREREQUISITS

    @classmethod
    def setUpClass(cls):
        print('\n[ TradingReporter ]: Functional test suit -\n')
        cls.reporter = TradingReporter(**cls.AR_DEFAULT)

    @classmethod
    def tearDownClass(cls):
        print('\n[ DONE ]: TradingReporter\n')

    # TESTERS

    def test_view(self, *args, **kwargs):
        print('\n[ TEST ]: List Reports\n')
        view = self.reporter.view(**self.AR_DEFAULT)
        self.assertTrue(view)
        self.assertTrue(isinstance(report, dict))

    def test_remove(self, *args, **kwargs):
        print('\n[ TEST ]: Remove Reports\n')
        remove = self.reporter.remove(**self.AR_DEFAULT)
        self.assertTrue(remove)

    def test_read(self, *args, **kwargs):
        print('\n[ TEST ]: Read Reports\n')
        read = self.reporter.read(**self.AR_DEFAULT)
        self.assertTrue(read)

    def test_generate_coin_details_report(self, *args, **kwargs):
        print('\n[ TEST ]: Generate Coin Details Report\n')
        report = self.reporter.generate('coin-details', **self.AR_DEFAULT)
        self.assertTrue(report)
        self.assertTrue(isinstance(report, dict))
        self.assertTrue(report['flag'])
        self.assertEqual(len(report.get('errors', 0)), 0)

    def test_generate_api_permissions_report(self, *args, **kwargs):
        print('\n[ TEST ]: Generate API Permissions Report\n')
        report = self.reporter.generate('api-permissions', **self.AR_DEFAULT)
        self.assertTrue(report)
        self.assertTrue(isinstance(report, dict))
        self.assertTrue(report['flag'])
        self.assertEqual(len(report.get('errors', 0)), 0)

    def test_generate_market_snapshot_report(self, *args, **kwargs):
        print('\n[ TEST ]: Generate Market Snapshot Report\n')
        report = self.reporter.generate('market-snapshot', **self.AR_DEFAULT)
        self.assertTrue(report)
        self.assertTrue(isinstance(report, dict))
        self.assertTrue(report['flag'])
        self.assertEqual(len(report.get('errors', 0)), 0)

    def test_generate_account_snapshot_report(self, *args, **kwargs):
        print('\n[ TEST ]: Generate Account Snapshot Report\n')
        report = self.reporter.generate('account-snapshot', **self.AR_DEFAULT)
        self.assertTrue(report)
        self.assertTrue(isinstance(report, dict))
        self.assertTrue(report['flag'])
        self.assertEqual(len(report.get('errors', 0)), 0)

    def test_generate_withdrawal_history_report(self, *args, **kwargs):
        print('\n[ TEST ]: Generate Withdrawal History Report\n')
        report = self.reporter.generate('withdrawal-history', **self.AR_DEFAULT)
        self.assertTrue(report)
        self.assertTrue(isinstance(report, dict))
        self.assertTrue(report['flag'])
        self.assertEqual(len(report.get('errors', 0)), 0)

    def test_generate_deposit_history_report(self, *args, **kwargs):
        print('\n[ TEST ]: Generate Deposit History Report\n')
        report = self.reporter.generate('deposit-history', **self.AR_DEFAULT)
        self.assertTrue(report)
        self.assertTrue(isinstance(report, dict))
        self.assertTrue(report['flag'])
        self.assertEqual(len(report.get('errors', 0)), 0)

    def test_generate_current_trades_report(self, *args, **kwargs):
        print('\n[ TEST ]: Generate Current Trades Report\n')
        report = self.reporter.generate('current-trades', **self.AR_DEFAULT)
        self.assertTrue(report)
        self.assertTrue(isinstance(report, dict))
        self.assertTrue(report['flag'])
        self.assertEqual(len(report.get('errors', 0)), 0)

    def test_generate_success_rate_report(self, *args, **kwargs):
        print('\n[ TEST ]: Generate Success Rate Report\n')
        report = self.reporter.generate('success-rate', **self.AR_DEFAULT)
        self.assertTrue(report)
        self.assertTrue(isinstance(report, dict))
        self.assertTrue(report['flag'])
        self.assertEqual(len(report.get('errors', 0)), 0)

    def test_generate_trade_history_report(self, *args, **kwargs):
        print('\n[ TEST ]: Generate Trade History Report\n')
        report = self.reporter.generate('trade-history', **self.AR_DEFAULT)
        self.assertTrue(report)
        self.assertTrue(isinstance(report, dict))
        self.assertTrue(report['flag'])
        self.assertEqual(len(report.get('errors', 0)), 0)

# CODE DUMP

