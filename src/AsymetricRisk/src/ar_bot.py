#!/usr/bin/python3
#
# Excellent Regards, the Alveare Solutions #!/Society -x
#
# ASYMETRIC RISK TRADING BOT

import os
import time
import datetime
import logging
import pysnooper

from .ar_reporter import TradingReporter
from .ar_market import TradingMarket
from .ar_strategy import TradingStrategy

from src.backpack.bp_ensurance import ensure_files_exist
from src.backpack.bp_convertors import json2dict, dict2json
from src.backpack.bp_computers import compute_percentage, compute_percentage_of
from src.backpack.bp_general import stdout_msg, pretty_dict_print

log = logging.getLogger('AsymetricRisk')


class TradingBot():

#   @pysnooper.snoop()
    def __init__(self, *args, **kwargs):
        '''
        [ NOTE ]: order_price:      price of 1 unit of BASE currency at which you
                                    place your order.

        [ NOTE ]: stop_price:       price - N% (stop-loss)

        [ NOTE ]: stop_limit_price: price + N% (take-profit)

        [ NOTE ]: amount:           N% of account value (1-100)

        [ NOTE ]: quote_amount:     N% of account value in quote currency (USD)

            [ Ex ]: How much USD for 1% of account value in BTC??
                    (with you, specifying the quote currency amount in percentages)

                For a 1% quote_amount of an 100USD account, that would be how much
                BTC you would be able to buy for 1USD, if you were somehow able to.
                The point IS - it would come down to a quote_amount of 1 (USD)

        [ NOTE ]: trade_amount:     N% of account value in base currency (BTC)

            [ Ex ]: How much BTC for 1% of account value in USD??
                    (with you, specifying the base currency amount in percentages)

                For a 1% trade_amount of an 100USD account, that would be how
                much BTC you would be able to buy for 1USD, which is 0.000000...
        '''
        log.debug('')
        self.trading_stragies = kwargs.get('trading-strategies', 'vwap') # vwap,rsi,macd,adx
        self.max_trades = int(kwargs.get('max-trades', 3))
        self.market = {}
        self.amount = float(kwargs.get('order-amount', 1))
        self.quote_amount = float(0)    # Amount value in quote currency
        self.trade_amount = float(0)    # Amount value in base currency
        self.order_price = float()
        self.order_stop_price = float()
        self.order_stop_limit_price = float()
        self.profit_target = float()
        self.start_account_value = float()
        self.current_account_value = float()
        self.current_account_value_free = float()
        self.current_account_value_locked = float()
        self.profit_baby = float(10)
        self.trading_done_for = None    # DateTime object
        self.nightly_reports = kwargs.get(
            'nightly-reports', (
                'current-trades', 'success-rate', 'account-snapshot',
                'api-permissions'
            )
        )
        if kwargs.get('api-key') and kwargs.get('api-secret'):
            try:
                setup = self._bot_pre_setup(*args, **kwargs)
                if not setup:
                    stdout_msg(
                        '{} pre-setup sequence failed!'.format(self), warn=True
                    )
            except Exception as w:
                stdout_msg(
                    'Could not setup trading bot market! '
                    'Details: ({})'.format(w), warn=True
                )
        self.markets = {arg.ticker_symbol: arg for arg in args} # {'BTC/USDT': TradingMarket(), ...}
        self.markets.update(self.market)
        self.reporter = self.setup_reporter(**kwargs)
        self.analyzer = self.setup_analyzer(**kwargs)
        self.trades_today = {}
        self.trades_archive = {}

    # FETCHERS

#   @pysnooper.snoop()
    def fetch_symbol_current_price(self, **kwargs):
        log.debug('')
        market = self.fetch_active_market()
        if not market:
            log.error(
                'Could not fetch active market! Details: ({})'.format(market)
            )
            return False
        info = market.get_symbol_ticker(symbol=kwargs.get('ticker-symbol').replace('/', ''))
        log.debug('symbol info: {}'.format(info))
        return float(info['price'])

#   @pysnooper.snoop()
    def fetch_account_value(self, currency='base', **kwargs):
        log.debug('')
        market = self.fetch_active_market()
        if not market:
            log.error(
                'Could not fetch active market! Details: ({})'.format(market)
            )
            return False, False, False
        base, quote = self.fetch_market_currency()
        response = market.get_asset_balance(
            base if currency == 'base' else quote,
            recvWindow=kwargs.get('recvWindow', 60000)
        )
        log.debug('response: {}'.format(response))
        if kwargs.get('free') or kwargs.get('locked'):
            total_value = float(response['free']) if kwargs.get('free') \
                else float(response['locked'])
        else:
            total_value = (float(response['free']) + float(response['locked']))
        return total_value, response['free'], response['locked']

    def fetch_market_currency(self):
        log.debug('')
        market = self.fetch_active_market()
        if not market:
            log.error(
                'Could not fetch active market! Details: ({})'.format(market)
            )
            return False, False
        return market.base_currency, market.quote_currency

    def fetch_valid_report_types(self):
        '''
        [ NOTE ]: Fetch all report types supported by the used version of the
                  report engine.
        '''
        log.debug('')
        return [
            'trade-history', 'success-rate', 'current-trades', 'deposit-history',
            'withdrawal-history', 'api-permissions', 'coin-details',
            'market-snapshot', 'account-snapshot'
        ]

    def fetch_supported_trading_strategies(self):
        '''
        [ NOTE ]: Fetch all trading strategy names supported by the used version
                  of the market strategy analyzer.
        '''
        log.debug('')
        return [
            'vwap', 'rsi', 'macd', 'ma', 'ema', 'adx', 'volume', 'price',
            'intuition-reversal'
        ]

    def fetch_active_market(self):
        log.debug('')
        if not self.market or not isinstance(self.market, dict):
            log.error(
                'Active market not set up! Details: ({})'.format(self.market)
            )
            return False
        market = list(self.market.values())[0]
        if not market:
            log.error(
                'Could not fetch active market! Details: ({})'.format(market)
            )
            return False
        return market

    def fetch_report_data_scrapers(self):
        log.debug('')
        return {
            'trade-history': self.scrape_trade_history_report_data,
            'deposit-history': self.scrape_deposit_history_report_data,
            'withdrawal-history': self.scrape_withdrawal_history_report_data,
            'current-trades': self.scrape_current_trades_report_data,
            'success-rate': self.scrape_success_rate_report_data,
            'market-snapshot': self.scrape_market_snapshot_report_data,
            'account-snapshot': self.scrape_account_snapshot_report_data,
            'coin-details': self.scrape_coin_details_report_data,
            'api-permissions': self.scrape_api_permissions_report_data,
        }

    # SETTERS

    def set_market(self, ticker_symbol, market_obj):
        log.debug('')
        if not ticker_symbol or not market_obj:
            return False
        self.market = {ticker_symbol: market_obj}
        return self.market

    def set_trading_strategy(self, strategy):
        log.debug('')
        supported = self.fetch_supported_trading_strategies()
        for item in strategy.split(','):
            if item not in supported:
                return False
        self.trading_strategy = strategy
        return self.trading_strategy

    # CHECKERS

    def check_market_hours(self, opening=[8, 00], closing=[22, 00]):
        '''
        [ NOTE ]: When testing an order and you're at 4am somewhere in eastern
                  europe maybe, try playing around with --market-open and
                  --market-close values to avoid long hangups.
        '''
        log.debug('')
        now = datetime.datetime.now()
        if (now.hour >= opening[0] or now.minute >= opening[1]) \
                and (now.hour <= closing[0] or now.minute <= closing[1]):
            return True
        return False

    def check_new_day(self, **kwargs):
        log.debug('')
        if not self.trading_done_for:
            return False
        now = datetime.datetime.now()
        if now.weekday() != self.trading_done_for.weekday():
            return True
        return False

#   @pysnooper.snoop()
    def check_trade_count(self, *args, **kwargs):
        log.debug('')
        if len(kwargs.get('trades-today', self.trades_today)) \
                >= int(kwargs.get('max-trades', self.max_trades)):
            if not self.trading_done_for:
                self.trading_done_for = datetime.datetime.now()
            return True
        return False

    # UPDATERS

    def update_trades(self, trade_dict, target='today', **kwargs):
        log.debug('')
        targets = {
            'today': self.trades_today,
            'archive': self.trades_archive
        }
        if target not in targets:
            log.error('Invalid target! ({})'.format(target))
            return False
        targets[target].update({trade_dict['orderId']: trade_dict})
        return True

#   @pysnooper.snoop()
    def update_current_account_value(self, currency='quote', **kwargs):
        log.debug('')
        value, free, locked = self.fetch_account_value(
            currency=currency, **kwargs
        )
        if not isinstance(value, float) and value in (None, False):
            stdout_msg('Could not check account value!', warn=True)
            return False
        stdout_msg(
            'Account value - Total: {} {} - Free: {} - Locked: {}'.format(
                value, kwargs.get('quote-currency') if currency == 'quote' \
                else kwargs.get('base-currency'), float(free), float(locked)
            ), symbol='UPDATE',
            green=True if value else False,
            red=True if not value else False
        )
        if not value or not free:
            stdout_msg('Account empty! Nothing to trade with.', red=True)
        self.current_account_value = value
        self.current_account_value_free = free
        self.current_account_value_locked = locked
        return self.current_account_value, self.current_account_value_free, \
            self.current_account_value_locked

    # ENSURANCE

#   @pysnooper.snoop()
    def ensure_trading_market_setup(self, **kwargs):
        log.debug('')
        if not self.market:
            self.market = self.setup_market(**kwargs)
        return self.market

    # SCRAPERS

    def scrape_coin_details_report_data(self, *args, **kwargs):
        '''
        [ NOTE ]: Uses API's to scrape data from the cloud thats needed by the
                  report engine in order to generate a deposit-history report.
        '''
        log.debug('')
        return self.view_coin_details(**kwargs)

    def scrape_api_permissions_report_data(self, *args, **kwargs):
        '''
        [ NOTE ]: Uses API's to scrape data from the cloud thats needed by the
                  report engine in order to generate a deposit-history report.
        '''
        log.debug('')
        return self.view_api_details(**kwargs)

    def scrape_deposit_history_report_data(self, *args, **kwargs):
        '''
        [ NOTE ]: Uses API's to scrape data from the cloud thats needed by the
                  report engine in order to generate a deposit-history report.
        '''
        log.debug('')
        return self.view_deposit_details(**kwargs)

    def scrape_withdrawal_history_report_data(self, *args, **kwargs):
        '''
        [ NOTE ]: Uses API's to scrape data from the cloud thats needed by the
                  report engine in order to generate a withdrawal-history report.
        '''
        log.debug('')
        return self.view_withdrawal_details(**kwargs)

    def scrape_market_snapshot_report_data(self, *args, **kwargs):
        '''
        [ NOTE ]: Uses API's to scrape data from the cloud thats needed by the
                  report engine in order to generate a market-snapshot report.
        '''
        log.debug('')
        return self.view_market_details('all', **kwargs)

    def scrape_account_snapshot_report_data(self, *args, **kwargs):
        '''
        [ NOTE ]: Uses API's to scrape data from the cloud thats needed by the
                  report engine in order to generate a account-snapshot report.
        '''
        log.debug('')
        return self.view_account_details(**kwargs)

    def scrape_trade_history_report_data(self, *args, **kwargs):
        '''
        [ NOTE ]: Uses API's to scrape data from the cloud thats needed by the
                  report engine in order to generate a trade-history report.
        '''
        log.debug('')
        return self.view_trade_history(
            kwargs.get('ticker-symbol', '').replace('/', ''), **kwargs
        )

    def scrape_current_trades_report_data(self, *args, **kwargs):
        '''
        [ NOTE ]: Uses API's to scrape data from the cloud thats needed by the
                  report engine in order to generate a current-trades report.
        '''
        log.debug('')
        return self.view_trades(
            kwargs.get('ticker-symbol', '').replace('/', ''), **kwargs
        )

    def scrape_success_rate_report_data(self, *args, **kwargs):
        '''
        [ NOTE ]: Uses API's to scrape data from the cloud thats needed by the
                  report engine in order to generate a success-rate report.
        '''
        log.debug('')
        return self.view_trade_history(
            kwargs.get('ticker-symbol', '').replace('/', ''), **kwargs
        )

    # ACTIONS

#   @pysnooper.snoop()
    def generate_nightly_reports(self, *args, **kwargs):
        log.debug('')
        if not self.reporter:
            log.error('No trading reporter set up!')
            return False
        details = kwargs.copy()
        raw_data_scrapers, raw_data = self.fetch_report_data_scrapers(), {}
        report_types = self.fetch_valid_report_types()
        for report_label in self.nightly_reports:
            if report_label not in report_types:
                stdout_msg(
                    'Invalid report label! Skipping ({})'.format(report_label),
                    err=True
                )
                continue
            elif report_label == 'success-rate' \
                    and raw_data.get('trade-history'):
                raw_data[report_label] = raw_data['trade-history']
                continue
            raw_data[report_label] = raw_data_scrapers[report_label](
                *args, **kwargs
            )
        details['raw-report-data'] = raw_data
        generate = self.reporter.generate(*args, **details)
        return generate

#   @pysnooper.snoop()
    def generate_report(self, *args, **kwargs):
        '''
        [ INPUT ]: args - Report type labels - *(
                        trade-history, deposit-history, withdrawal-history,
                        current-trades, success-rate, 'coin-details',
                        api-permissions, account-snapshot, market-snapshot
                    )
                   kwargs - Context - **{}

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
                'deposit-history': {},
                'withdrawal-history': {},
                'current-trades': {},
                'success-rate': {},
                'market-snapshot': {},
                'account-snapshot': {},
                'api-permissions': {},
                'coin-details': {},

            }
            'errors': [{msg: '', type: '', code: ,}],
        }
        '''
        log.debug('')
        if not self.reporter:
            log.error('No trading reporter set up!')
            return False
        raw_data_scrapers, raw_data = self.fetch_report_data_scrapers(), {}
        report_types = self.fetch_valid_report_types()
        target_reports, details = args or report_types, kwargs.copy()
        for report_label in target_reports:
            if report_label not in report_types:
                stdout_msg(
                    'Invalid report label! Skipping ({})'.format(report_label),
                    err=True
                )
                continue
            elif report_label == 'success-rate' \
                    and raw_data.get('trade-history'):
                raw_data[report_label] = raw_data['trade-history']
                continue
            raw_data[report_label] = raw_data_scrapers[report_label](
                *args, **kwargs
            )
        details['raw-report-data'] = raw_data
        generate = self.reporter.generate(*args, **details)
        for report_type in generate['reports']:
            report_id = generate['reports'][report_type]['report-id']
            file_path = generate['reports'][report_type]['report-file']
            stdout_msg(
                '{} - {}\n{}\n'.format(
                    report_id, file_path,
                    pretty_dict_print(json2dict(file_path))
                ), symbol='NEW REPORT', bold=True
            )
        return generate

    def remove_report(self, *args, **kwargs):
        log.debug('')
        return self.reporter.remove(*args, **kwargs)

    def list_reports(self, *args, **kwargs):
        log.debug('')
        return self.reporter.view(*args, **kwargs)

#   @pysnooper.snoop()
    def trade_watchdog(self, *args, **kwargs):
        log.debug('')
        failures, anchor_file = 0, kwargs.get(
            'watchdog-anchor-file', '.ar-bot.anch'
        )
        ensure_files_exist(anchor_file)
        cool_down_seconds = kwargs.get('watchdog-interval', 60)
        market_hours = {
            'opening': [
                int(item) for item in kwargs.get('market-open', '08:00').split(':')
            ],
            'closing': [
                int(item) for item in kwargs.get('market-close', '22:00').split(':')
            ]
        }
        market_closed_flag = False
        while True:
            if anchor_file and not os.path.exists(anchor_file):
                break
            check_time = self.check_market_hours(**market_hours)
            if not check_time:
                if not market_closed_flag:
                    stdout_msg(
                        'Market closed until {} tomorrow - {}'.format(
                            kwargs['market-open'], str(datetime.datetime.now())
                        ), red=True
                    )
                    report = self.generate_nightly_reports(*args, **kwargs)
                self.bot_cooldown(cool_down_seconds, silent=market_closed_flag)
                market_closed_flag = True
                continue
            check_max_reached, market_closed_flag = self.check_trade_count(), False
            if check_max_reached:
                if self.check_new_day():
                    reset = self.reset_trading_day()
                    if not reset:
                        stdout_msg(
                            'Could not reset trading day! Max-trades (per day) '
                            'parameter can no longer be considered.', err=True
                        )
                        failures += 1
                else:
                    self.bot_cooldown(cool_down_seconds)
                    continue
            trade = self.trade(*args, **kwargs)
            if not trade:
                if isinstance(trade, dict) and trade.get('error'):
                    failures += 1
            self.update_current_account_value(**kwargs)
            if self.profit_target \
                    and self.current_account_value >= self.profit_target:
                self.mission_accomplished()
                break
            if trade:
                self.update_trades(trade, target='today', **kwargs)
            self.bot_cooldown(cool_down_seconds)
        return failures

#   @pysnooper.snoop()
    def trade(self, *args, **kwargs):
        '''
        [ INPUT ]: args - *(vwap, rsi, macd, ma, ema, adx, price, volume)

            **kwargs - Context + {
                'analyze-risk': True,                     (type bool) - default True
                'strategy': vwap,rsi,macd,price,volume,   (type str) - default vwap
                'side': buy,                              (type str) - <buy, sell, auto> default auto
                'period': 14,
                'backtrack': 5,
                'backtracks': 14,
                'chart': candles,
                'price-movement': 5%,
                'interval': 5m,
                'rsi-top': 70%,
                'rsi-bottom': 30%,
                'rsi-period': 14,
                'rsi-backtrack': 5,
                'rsi-backtracks': 12,
                'rsi-chart': candles,
                'rsi-interval': 5m,
                'volume-movement': 5%,
                'volume-interval': 5m,
                'ma-period': 30,
                'ma-backtrack': 5,
                'ma-backtracks': 12,
                'ma-chart': candles,
                'ma-interval': 5m,
                'ema-period': 30,
                'ema-backtrack': 5,
                'ema-backtracks': 12,
                'ema-chart': candles,
                'ema-interval': 5m,
                'macd-backtrack': 5,
                'macd-backtracks': 12,
                'macd-chart': candles,
                'macd-fast-period': 12,
                'macd-slow-period': 26,
                'macd-signal-period': 9,
                'macd-interval': 5m,
                'adx-period': 14,
                'adx-backtrack': 5,
                'adx-backtracks': 12,
                'adx-chart': candles,
                'adx-interval': 5m,
                'vwap-period': 14,
                'vwap-backtrack': 5,
                'vwap-backtracks': 12,
                'vwap-chart': candles,
                'vwap-interval': 5m,
                'price-period': 14,
                'price-backtrack': 5,
                'price-backtracks': 12,
                'price-chart': candles,
                'price-interval': 5m,
                ...
            }

        [ RETURN ]: {
            'trade-id': 142324,
        }
        '''
        log.debug('')
        market, details = self.fetch_active_market(), kwargs.copy()
        log.debug('Trade kwargs - {}'.format(details))
        if not market:
            stdout_msg('Trading market not set up!', err=True)
            return False
        stdout_msg(
            'Looking for trades... ({})'.format(market.ticker_symbol), info=True
        )
        trading_strategy = ','.join(args) if args \
                else details.get('strategy', '')
        stdout_msg(
            'Updating market details applicable to strategy... ({})'
            .format(trading_strategy), info=True
        )
        market_update_args = trading_strategy.split(',')
        market_details = market.update_details(*market_update_args, **details)
        trade_flag, risk_index, trade = False, 0, None
        trade_values = self.compute_trade_values(details, **kwargs)
        if details.get('analyze-risk'):
            details.update({
                'details': market_details,
                'strategy': trading_strategy,
                'trade-amount': trade_values.get('trade-amount', 0),
                'quote-amount': 0 if trade_values['trade-amount'] \
                    else trade_values.get('quote-amount', 0),
                'side': kwargs.get('side', 'auto'),
                'order-price': trade_values.get('order-price', 0),
                'stop-price': trade_values.get('order-stop-price', 0),
                'stop-limit-price': trade_values.get('order-stop-limit-price', 0),
            })
            stdout_msg('Analyzing trading risk', info=True)
            trade_flag, risk_index, trade_side, failures = self.analyzer.analyze_risk(
                **details
            )
        if risk_index == 0 or not trade_flag:
            # [ NOTE ]: Trading cycle should stop here according to specified
            #           risk tolerance. Do nothing, try again later.
            stdout_msg('[ N/A ]: Skipping trade, not a good ideea right now.')
            return False
        if trade_flag:
            trade_sides = {'buy': market.buy, 'sell': market.sell,}
            trade = trade_sides[trade_side](details['trade-amount'], **details)
            if not trade:
                stdout_msg(
                    'Something went wrong! Errors occured during trade! \n'
                    'Check log file ({}) for more details. God speed!!!'.format(
                        kwargs.get('log-file')
                    ), err=True
                )
        else:
            return False
        return False if (not trade or trade.get('error')) else trade

    def close_trade(self, *args, **kwargs):
        '''
        [ NOTE ]: When in a long-trade (buy) exit at the next price resistance
                  level.

        [ NOTE ]: When in a short-trade (sell) exit at the next price support
                  level.

        [ INPUT ]: *args    - trade orderId's (type str)
                   **kwargs - symbol (type str) - ticker symbol, default is
                              active market
                            - recvWindow (type int) - binance API response
                              window, default is 60000

        [ RETURN ]: closed trades (type lst), failed closes (type lst)
        '''
        log.debug('')
        market = self.fetch_active_market()
        return market.close_position(*args, **kwargs)

    # COMPUTERS

    def compute_trade_values(self, details, **kwargs):
        log.debug('')
        values = {
            'account-value': self.update_current_account_value(
                    currency='quote', **kwargs
                ),
            'trade-amount': self.compute_trade_amount(
                    details.get('order-amount'), **details
                ) or self.trade_amount,
            'quote-amount': self.compute_quote_amount(
                    details.get('order-amount'), **details
                ) or self.quote_amount,
            'order-price': self.compute_order_price(
                    details.get('order-price'), **kwargs
                ) or self.order_price,
            'order-stop-price': self.compute_order_stop_price(
                    details.get('order-stop-price'), **kwargs
                ) or self.order_stop_price,
            'order-stop-limit-price': self.compute_order_stop_limit_price(
                    details.get('order-stop-limit-price'), **kwargs
                ) or self.order_stop_limit_price,
        }
        return values

    @pysnooper.snoop()
    def compute_order_price(self, order_price, **kwargs):
        '''
        [ NOTE ]: order_price:      price of 1 unit of BASE currency at which you
                                    place your order.
        '''
        log.debug('')
        log.debug(
            'previous order_price, kwargs - {}, {}'.format(order_price, kwargs)
        )
        self.order_price = self.fetch_symbol_current_price(**kwargs)
        log.debug('Computed order price: {}'.format(self.order_price))
        return self.order_price

#   @pysnooper.snoop()
    def compute_order_stop_price(self, stop_price, **kwargs):
        '''
        [ NOTE ]: stop_price:       price - N% (stop-loss)
        '''
        log.debug('')
        log.debug(
            'previous stop_price, kwargs - {}, {}'.format(stop_price, kwargs)
        )
        account_value, free, locked = self.fetch_account_value(
            currency='quote', **kwargs
        )
        current_price = self.fetch_symbol_current_price(**kwargs)
        to_subtract = compute_percentage_of(kwargs['stop-loss'], current_price)
        self.order_stop_price = current_price - to_subtract
        log.debug('Computed order stop price: {}'.format(self.order_stop_price))
        return self.order_stop_price

#   @pysnooper.snoop()
    def compute_order_stop_limit_price(self, stop_limit_price, **kwargs):
        '''
        [ NOTE ]: stop_limit_price: price + N% (take-profit)
        '''
        log.debug('')
        log.debug(
            'previous stop_limit_price, kwargs - {}, {}'.format(
                stop_limit_price, kwargs
            )
        )
        account_value, free, locked = self.fetch_account_value(
            currency='quote', **kwargs
        )
        current_price = self.fetch_symbol_current_price(**kwargs)
        to_add_on_top = compute_percentage_of(
            kwargs['take-profit'], current_price
        )
        self.order_stop_limit_price = current_price + to_add_on_top
        log.debug(
            'Computed order stop limit price: {}'.format(
                self.order_stop_limit_price
            )
        )
        return self.order_stop_limit_price

#   @pysnooper.snoop()
    def compute_quote_amount(self, percentage, **kwargs):
        '''
        [ DESCRIPTION ]: The amount (quantity) for a trade is specified by the
            user in the form of a percentage (number 1-100) - this represents a
            percentage of the total account value.

            This method turns that percentage into a Quote currency value.

        [ NOTE ]: amount:           N% of account value (1-100)

        [ NOTE ]: quote_amount:     N% of account value in quote currency (USD)

            [ Ex ]: How much USD for 1% of account value in BTC??
                    (with you, specifying the quote currency amount in percentages)

                For a 1% quote_amount of an 100USD account, that would be how much
                BTC you would be able to buy for 1USD, if you were somehow able to.
                The point IS - it would come down to a quote_amount of 1 (USD)
        '''
        log.debug('')
        if not percentage:
            log.error(
                'No account value percentage given! Details: {} {}'.format(
                    percentage, kwargs
                )
            )
            return False
        value, free, locked = self.fetch_account_value(
            currency='quote', **kwargs
        )
        if not value:
            return False
        self.quote_amount = 0 if not value or not percentage\
            else compute_percentage(percentage, value)
        return self.quote_amount

#   @pysnooper.snoop()
    def compute_trade_amount(self, percentage, **kwargs):
        '''
        [ DESCRIPTION ]: The amount (quantity) for a trade is specified by the
            user in the form of a percentage (number 1-100) - this represents a
            percentage of the total account value.

            This method turns that percentage into a Base currency value.

        [ NOTE ]: amount:           N% of account value (1-100)

        [ NOTE ]: trade_amount:     N% of account value in base currency (BTC)

            [ Ex ]: How much BTC for 1% of account value in USD??
                    (with you, specifying the base currency amount in percentages)

                For a 1% trade_amount of an 100USD account, that would be how
                much BTC you would be able to buy for 1USD, which is 0.000000...
        '''
        log.debug('')
        if not percentage:
            return 0
        value, free, locked = self.fetch_account_value(currency='base', **kwargs)
        if not value:
            return 0
        self.trade_amount = 0 if not value or not percentage\
            else compute_percentage(percentage, value)
        # WARNING: Cannot use both order-amount and order-quote-amount at the
        #          same time!
        # NOTE: order-amount specifies the amount value in base currency
        # NOTE: order-quote-amount specifies the amount value in quote currency
        quote_quantity = self.compute_quote_amount(percentage, **kwargs)
        if not quote_quantity:
            stdout_msg(
                'Could not compute quote trade quantity from given ({}%) '
                'of account value!'.format(percentage), err=True
            )
        return self.trade_amount

    def compute_profit_baby(self, percentage, **kwargs):
        log.debug('')
        account_value, free, locked = self.fetch_account_value(
            currency='quote', **kwargs
        )
        self.start_account_value = account_value
        self.current_account_value = account_value
        self.profit_baby = 0 if not self.start_account_value \
            else compute_percentage(
                percentage, self.start_account_value
            )
        self.profit_target = (self.start_account_value + self.profit_baby)
        return self.profit_baby

    # GENERAL

    def bot_cooldown(self, cool_down_seconds, silent=False):
        log.debug('')
        if not silent:
            stdout_msg(
                'Bot cool down: {} seconds'.format(cool_down_seconds), red=True
            )
        time.sleep(cool_down_seconds)
        return True

    def reset_trading_day(self, **kwargs):
        log.debug('')
        self.archive_current_day_trades(**kwargs)
        self.trading_done_for = None
        self.trades_today = {}
        return True

    def archive_current_day_trades(self, *args, **kwargs):
        log.debug('')
        self.trades_archive.update({time.time(): self.trades_today.copy(),})
        self.trades_today = {}
        return True

    def mission_accomplished(self):
        log.debug('HELL YES!')
        message = 'Target acquired! PROFIT BABY!! - Started from ({}) '\
            'now we here ({}) :>'.format(
                self.start_account_value, self.current_account_value
            )
        log.info(message)
        stdout_msg('[ DONE ]: ' + message)
        return message

    # VIEWERS

#   @pysnooper.snoop()
    def view_coin_details(self, *args, **kwargs):
        log.debug('')
        market = self.fetch_active_market()
        if not market:
            return False
        return market.fetch_supported_coins(*args, **kwargs)

#   @pysnooper.snoop()
    def view_api_details(self, *args, **kwargs):
        log.debug('')
        market = self.fetch_active_market()
        if not market:
            return False
        return market.fetch_api_permissions_details(*args, **kwargs)

#   @pysnooper.snoop()
    def view_deposit_details(self, *args, **kwargs):
        log.debug('')
        market = self.fetch_active_market()
        if not market:
            return False
        return market.fetch_deposit_details(*args, **kwargs)

#   @pysnooper.snoop()
    def view_withdrawal_details(self, *args, **kwargs):
        log.debug('')
        market = self.fetch_active_market()
        if not market:
            return False
        return market.fetch_withdrawal_details(*args, **kwargs)

#   @pysnooper.snoop()
    def view_report(self, *args, **kwargs):
        log.debug('')
        if not self.reporter:
            log.error('No trading reporter set up!')
            return False
        return self.reporter.read(*args, **kwargs)

#   @pysnooper.snoop()
    def view_market_details(self, *args, **kwargs):
        log.debug('')
        market = self.fetch_active_market()
        if not market:
            return False
        if not args:
            args = ('all', )
        return market.fetch_details(*args, **kwargs)

#   @pysnooper.snoop()
    def view_account_details(self, *args, **kwargs):
        log.debug('')
        market = self.fetch_active_market()
        if not market:
            return False
        return market.fetch_account(**kwargs)

    def view_asset_balance(self, *args, **kwargs):
        '''
        [ NOTE ]: View balance of specified or all coins in market account.
        '''
        log.debug('')
        market = self.fetch_active_market()
        if not market:
            return False
        return market.fetch_asset_balance(*args, **kwargs)

    def view_trades(self, *args, **kwargs):
        '''
        [ NOTE ]: View active trades.
        '''
        log.debug('')
        market = self.fetch_active_market()
        if not market:
            return False
        return market.fetch_active_trades(*args, **kwargs)

    def view_trade_history(self, *args, **kwargs):
        '''
        [ NOTE ]: View all trades.
        '''
        log.debug('')
        market = self.fetch_active_market()
        if not market:
            return False
        return market.fetch_all_trades(*args, **kwargs)

    def view_supported_tickers(self, *args, **kwargs):
        '''
        [ NOTE ]: View all supported ticker symbols
        [ RETURN ]: {symbol: {'symbol': str, 'price': str}}
        '''
        log.debug('')
        market = self.fetch_active_market()
        if not market:
            return False
        return market.fetch_supported_tickers()

    def view_supported_coins(self, *args, **kwargs):
        '''
        [ NOTE ]: View all supported crypto coins
        '''
        log.debug('')
        market = self.fetch_active_market()
        if not market:
            return False
        return market.fetch_supported_coins(**kwargs)

    # MARKET MANAGEMENT

    def select_market(self, ticker_symbol, **kwargs):
        '''
        [ NOTE ]: Select one of the previously entered trading markets as the
                  target for bot actions.
        '''
        log.debug('')
        if ticker_symbol not in self.markets.keys():
            return False
        return self.set_market(ticker_symbol, self.markets[ticker_symbol])

    def enter_market(self, **kwargs):
        '''
        [ NOTE ]: Add new TradingMarket object to markets
        '''
        log.debug('')
        market = TradingMarket(
            kwargs.get('api-key'), kwargs.get('api-secret'), **kwargs
        )
        if not market:
            return False
        ticker_symbol = kwargs.get('ticker-symbol') \
            or (kwargs.get('base-currency', str()) + '/' \
            + kwargs.get('quote-currency', str()))
        new_entry = {ticker_symbol: market}
        self.markets.update(new_entry)
        return {
            'error': False if market else True,
            'market': market,
        }

    def exit_market(self, *args, **kwargs):
        '''
        [ NOTE ]: Remove TradingMarket object from markets
        '''
        log.debug('')
        failures, failed_tickers = 0, []
        if not args:
            failures += 1
        for ticker_symbol in args:
            if ticker_symbol not in self.market.keys():
                failures += 1
                failed_tickers.append(ticker_symbol)
                continue
            del self.market[ticker_symbol]
        return {
            'error': False if not failures else True,
            'failures': failures,
            'failed-tickers': failed_tickers,
        }

    # SETUP

    def setup_analyzer(self, **kwargs):
        log.debug('')
        analyzer = TradingStrategy(**kwargs)
        return analyzer

    def setup_reporter(self, **kwargs):
        log.debug('')
        reporter = TradingReporter(**kwargs)
        return reporter

#   @pysnooper.snoop()
    def setup_market(self, **kwargs):
        log.debug('')
        market = TradingMarket(
            kwargs.get('api-key', str()),
            kwargs.get('api-secret', str()),
            testnet=kwargs.get('test'),
            **kwargs
        )
        return {kwargs['ticker-symbol']: market}

    # DERRRP

    def __str__(self, *args, **kwargs):
        return 'TradingBot'

    # PERSONAL

#   @pysnooper.snoop()
    def _bot_pre_setup(self, *args, **kwargs):
        '''
        [ NOTE ]: Called uppon on TradingBot.__init__()
        '''
        log.debug('')
        failures = 0
        self.market = self.setup_market(**kwargs) # {'BTC/USDT': TradingMarket()}
        if not self.market:
            stdout_msg('Could not set up trading market!', nok=True)
            failures += 1
        profit_bby = self.compute_profit_baby(
            kwargs.get('profit-baby', self.profit_baby), **kwargs
        )
        if not profit_bby and not isinstance(profit_bby, int) \
                and not isinstance(profit_bby, float):
            stdout_msg('Invalid profit target! ({})'.format(profit_bby), nok=True)
            failures += 1
        trade_amount = self.compute_trade_amount(
            kwargs.get('order-amount', self.amount), **kwargs
        )
        if not trade_amount and not isinstance(profit_bby, int) \
                and not isinstance(profit_bby, float):
            stdout_msg('Invalid trade amount! ({})'.format(trade_amount), nok=True)
            failures += 1
        order_price = self.compute_order_price(
            kwargs.get('order-price', self.order_price), **kwargs
        )
        if not order_price:
            stdout_msg('Invalid order price! ({})'.format(order_price), nok=True)
            failures += 1
        stop_price = self.compute_order_stop_price(
            kwargs.get('stop-price', self.order_stop_price), **kwargs
        )
        if not stop_price:
            stdout_msg('Invalid stop price! ({})'.format(stop_price), nok=True)
            failures += 1
        stop_limit_price = self.compute_order_stop_limit_price(
            kwargs.get('stop-limit-price', self.order_stop_limit_price), **kwargs
        )
        if not stop_limit_price:
            stdout_msg(
                'Invalid stop limit price! ({})'.format(stop_limit_price), nok=True
            )
            failures += 1
        if failures:
            log.debug(
                '({}) failures detected during ({}) pre-setup sequence!'
                .format(failures, self)
            )
        return False if failures else True

# CODE DUMP

