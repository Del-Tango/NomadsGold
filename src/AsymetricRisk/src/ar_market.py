#!/usr/bin/python3
#
# Excellent Regards, the Alveare Solutions #!/Society -x
#
# ASYMETRIC RISK TRADING MARKET

import os
import logging
import time
import datetime
import json
import pysnooper
import pandas
import numpy
#import matplotlib.pyplot as plt   # needs pip install

from binance.client import Client
#from binance import ThreadedWebsocketManager
from src.ar_indicator import TradingIndicator
from src.backpack.bp_general import stdout_msg, pretty_dict_print

log = logging.getLogger('AsymetricRisk')


class TradingMarket(Client):

#   @pysnooper.snoop()
    def __init__(self, *args, sync=False, **kwargs):
        calling_all_ancestors_from_beyond_the_grave = super().__init__(*args)
        self.base_currency = kwargs.get('base-currency', 'BTC')
        self.API_URL = kwargs.get(
            'api-url', 'https://testnet.binance.vision/api'
        )                                                                            # Place where all the trades happen
        if not self.API_KEY:
            self.API_KEY = kwargs.get('api-key', os.environ.get('binance_api'))
        if not self.API_SECRET:
            self.API_SECRET = kwargs.get(
                'api-secret', os.environ.get('binance_secret')
            )
        self.taapi_url = kwargs.get('taapi-url', "https://api.taapi.io")
        self.taapi_key = kwargs.get('taapi-key', os.environ.get('taapi_api'))
        self.quote_currency = kwargs.get('quote-currency', 'USDT')
        self.ticker_symbol = kwargs.get(
            'ticker-symbol', self.compute_ticker_symbol(
                base=self.base_currency, quote=self.quote_currency
            )                                                                        # 'BTC/USDT'
        )
        self.period_interval = kwargs.get('period-interval', '1h')                   # Time represented by each candle in chart
        self.period = float(kwargs.get('period', 30))                                # No. of candles when backtracking a chart
        self.period_start = kwargs.get('period-start', '')
        self.period_stop = kwargs.get('period-start', '')
        self.chart = kwargs.get('chart', 'candles')
        self.cache_size_limit = int(kwargs.get('cache-size-limit', 20))              # Records (dict keys)
        self.history_backtrack = int(kwargs.get('backtrack', 5)),                    # Candles
        self.history_backtracks = int(kwargs.get('backtracks', 14)),                 # Candles
        self.indicator_update_delay = int(kwargs.get('indicator-update-delay', 18))  # Seconds
        self.market_open = kwargs.get('market-open', '08:00')                        # Hour at which the bot's mission begins!!
        self.market_close = kwargs.get('market-close', '22:00')                      # Hour at which the bot starts generating reports for the past day
        # WARNING: Longer delays between indicator api calls will result in
        # longer execution time. Delays that are too short may not retreive all
        # necessary data (depending on chosen Taapi API plan specifications)
        self.indicator = TradingIndicator(**kwargs)
        self.data_frame = None
        self.time_offset = 0
        self.buy_price = float()
        self.sell_price = float()
        self.volume = float()
        self.adx = float()
        self.macd = float()
        self.macd_signal = float()
        self.macd_hist = float()
        self.ma = float()
        self.ema = float()
        self.rsi = float()
        self.vwap = float()
        self.last_indicator_update_timestamp = None
        self.success_count = 0
        self.failure_count = 0
        self.active_trades = {}
        self.trades_to_report = {}
        self.supported_tickers_cache = {}
        self.supported_coins_cache = {}
        self.recent_trades_cache = {}
        self.account_cache = {}
        self.coin_info_cache = {}
        self.ticker_info_cache = {}
        self.trade_fee_cache = {}
        self.history_cache = {}
        if sync:
            self.time_offset = self._fetch_time_offset()
        if kwargs.get('update-flag'):
            self.data_frame = pandas.DataFrame()
            self.update_details('all', **kwargs)
        return calling_all_ancestors_from_beyond_the_grave

    # FETCHERS

#   @pysnooper.snoop('log/nomads-gold.log')
    def fetch_candle_info(self, *args, **kwargs):
        log.debug('')
        sanitized_ticker = kwargs.get('ticker-symbol', self.ticker_symbol)\
            .replace('/', '')
        getter_kwargs = {'limit': int(kwargs.get('period', self.period or 0)),}
        if kwargs.get('period-start'):
            getter_kwargs.update({'start_str': kwargs['period-start']})
        if kwargs.get('period-end'):
            getter_kwargs.update({'end_str': kwargs['period-end']})
        log.debug(
            'Getting historical klines with args/kwargs: {}, {}, {}'.format(
                sanitized_ticker, kwargs.get('interval', self.period_interval),
                getter_kwargs
            ),
        )
        return self.get_historical_klines(
            sanitized_ticker, kwargs.get('interval', self.period_interval),
            **getter_kwargs
        )

#   @pysnooper.snoop()
    def fetch_deposit_details(self, *args, **kwargs):
        '''
        [ INPUT ] : *args - (), **kwargs - Context + {
            :param coin: optional
            :type coin: str

            :type status: optional - 0(0:pending,1:success) optional
            :type status: int

            :param startTime: optional
            :type startTime: long

            :param endTime: optional
            :type endTime: long

            :param offset: optional - default:0
            :type offset: long

            :param limit: optional
            :type limit: long

            :param recvWindow: the number of milliseconds the request is valid for
            :type recvWindow: int
        }

        [ RETURN ]: [
            {
                "amount":"0.00999800",
                "coin":"PAXG",
                "network":"ETH",
                "status":1,
                "address":"0x788cabe9236ce061e5a892e1a59395a81fc8d62c",
                "addressTag":"",
                "txId":"0xaad4654a3234aa6118af9b4b335f5ae81c360b2394721c019b5d1e75328b09f3",
                "insertTime":1599621997000,
                "transferType":0,
                "confirmTimes":"12/12"
            },
            {
                "amount":"0.50000000",
                "coin":"IOTA",
                "network":"IOTA",
                "status":1,
                "address":"SIZ9VLMHWATXKV99LH99CIGFJFUMLEHGWVZVNNZXRJJVWBPHYWPPBOSDORZ9EQSHCZAMPVAPGFYQAUUV9DROOXJLNW",
                "addressTag":"",
                "txId":"ESBFVQUTPIWQNJSPXFNHNYHSQNTGKRVKPRABQWTAXCDWOAKDKYWPTVG9BGXNVNKTLEJGESAVXIKIZ9999",
                "insertTime":1599620082000,
                "transferType":0,
                "confirmTimes":"1/1"
            }
        ]
        '''
        log.debug('')
        timestamp = str(time.time())
        return_dict = self.get_deposit_history(
            recvWindow=kwargs.get('order-recv-window', 60000)
        )
        self.update_cache(return_dict, self.history_cache, label=timestamp,)
        return self.history_cache[timestamp]

    def fetch_withdrawal_details(self, *args, **kwargs):
        '''
        [ INPUT ]: *args(), **kwargs - Context + {
            param coin: optional
            type coin: str

            type status: 0(0:Email Sent,1:Cancelled 2:Awaiting Approval 3:Rejected 4:Processing 5:Failure 6Completed) optional
            type status: int

            param offset: optional - default:0
            type offset: int

            param limit: optional
            type limit: int

            param startTime: optional - Default: 90 days from current timestamp
            type startTime: int

            param endTime: optional - Default: present timestamp
            type endTime: int

            param recvWindow: the number of milliseconds the request is valid for
            type recvWindow: int
        }

        [ RETURN ]: [
            {
                "address": "0x94df8b352de7f46f64b01d3666bf6e936e44ce60",
                "amount": "8.91000000",
                "applyTime": "2019-10-12 11:12:02",
                "coin": "USDT",
                "id": "b6ae22b3aa844210a7041aee7589627c",
                "withdrawOrderId": "WITHDRAWtest123",       # will not be returned if there's no withdrawOrderId for this withdraw.
                "network": "ETH",
                "transferType": 0,                          # 1 for internal transfer, 0 for external transfer
                "status": 6,
                "txId": "0xb5ef8c13b968a406cc62a93a8bd80f9e9a906ef1b3fcf20a2e48573c17659268"
            },
            {
                "address": "1FZdVHtiBqMrWdjPyRPULCUceZPJ2WLCsB",
                "amount": "0.00150000",
                "applyTime": "2019-09-24 12:43:45",
                "coin": "BTC",
                "id": "156ec387f49b41df8724fa744fa82719",
                "network": "BTC",
                "status": 6,
                "txId": "60fd9007ebfddc753455f95fafa808c4302c836e4d1eebc5a132c36c1d8ac354"
            }
        ]
        '''
        log.debug('')
        timestamp = str(time.time())
        return_dict = self.get_withdraw_history(
            recvWindow=kwargs.get('order-recv-window', 60000),
        )
        self.update_cache(return_dict, self.history_cache, label=timestamp)
        return self.history_cache[timestamp]

    def fetch_api_permissions_details(self, *args, **kwargs):
        '''
        [ INPUT ]: *(), **kwargs - Context - {}

        [ RETURN ]: {
            "ipRestrict": false,
            "createTime": 1623840271000,
            "enableWithdrawals": false,                         # This option allows you to withdraw via API.
                                                                # You must apply the IP Access Restriction filter
                                                                # in order to enable withdrawals
            "enableInternalTransfer": true,                     # This option authorizes this key to transfer funds
                                                                # between your master account and your sub account instantly
            "permitsUniversalTransfer": true,                   # Authorizes this key to be used for a dedicated universal
                                                                # transfer API to transfer multiple supported currencies.
                                                                # Each business's own transfer API rights are not affected
                                                                # by this authorization
            "enableVanillaOptions": false,                      # Authorizes this key to Vanilla options trading
            "enableReading": true,
            "enableFutures": false,                             # API Key created before your futures account opened does not
                                                                # support futures API service
            "enableMargin": false,                              # This option can be adjusted after the Cross Margin account
                                                                # transfer is completed
            "enableSpotAndMarginTrading": false,                # Spot and margin trading
            "tradingAuthorityExpirationTime": 1628985600000     # Expiration time for spot and margin trading permission
            "data": {                                           # API trading status detail
                "isLocked": false,                              # API trading function is locked or not
                "plannedRecoverTime": 0,                        # If API trading function is locked, this is the planned
                                                                # recover time
                "triggerCondition": {
                        "GCR": 150,                             # Number of GTC orders
                        "IFER": 150,                            # Number of FOK/IOC orders
                        "UFR": 300                              # Number of orders
                },
                "indicators": {                                 # The indicators updated every 30 seconds
                     "BTCUSDT": [                               # The symbol
                        {
                            "i": "UFR",                         # Unfilled Ratio (UFR)
                            "c": 20,                            # Count of all orders
                            "v": 0.05,                          # Current UFR value
                            "t": 0.995                          # Trigger UFR value
                        },
                        {
                            "i": "IFER",                        # IOC/FOK Expiration Ratio (IFER)
                            "c": 20,                            # Count of FOK/IOC orders
                            "v": 0.99,                          # Current IFER value
                            "t": 0.99                           # Trigger IFER value
                        },
                        {
                            "i": "GCR",                         # GTC Cancellation Ratio (GCR)
                            "c": 20,                            # Count of GTC orders
                            "v": 0.99,                          # Current GCR value
                            "t": 0.99                           # Trigger GCR value
                        }
                    ],
                    "ETHUSDT": [
                        {
                            "i": "UFR",
                            "c": 20,
                            "v": 0.05,
                            "t": 0.995
                        },
                        {
                            "i": "IFER",
                            "c": 20,
                            "v": 0.99,
                            "t": 0.99
                        },
                        {
                            "c": 20,
                            "v": 0.99,
                            "t": 0.99
                        }
                    ]
                },
                "updateTime": 1547630471725
            }
          }
        }
        '''
        log.debug('')
        timestamp, return_dict = str(time.time()), {}
        return_dict.update(self.get_account_api_permissions(
            recvWindow=kwargs.get('order-recv-window', 60000)
        ))
        return_dict.update(self.get_account_api_trading_status(
            recvWindow=kwargs.get('order-recv-window', 60000)
        ))
        self.update_cache(return_dict, self.account_cache, label=timestamp)
        return self.account_cache[timestamp]

    def fetch_server_time(self, *args, **kwargs):
        '''
        [ RETURN ]: {
            "serverTime": 1499827319559
        }
        '''
        log.debug('')
        return self.get_server_time()

#   @pysnooper.snoop()
    def fetch_adx_value(self, **kwargs):
        '''
        [ RETURN ]: adx-value, plus-dmi, minus-dmi
                    [{value: x, backtrack: 0}, {value: x, backtrack: 1}, ...]
        '''
        log.debug('')
        self.ensure_indicator_delay()
        adx_kwargs = self.format_adx_indicator_kwargs(**kwargs)
        log.debug('ADX Indicator handler kwargs - {}'.format(adx_kwargs))
        raw_value = self.indicator.adx(**adx_kwargs)
        log.debug('RAW ADX API response - {}'.format(raw_value))
        if not raw_value:
            return False
        self.update_indicator_timestamp()
        values = self.raw_api_response_convertor(raw_value)
        if not kwargs.get('backtrack', kwargs.get('adx-backtrack')) \
                and not kwargs.get('backtracks', kwargs.get('adx-backtracks')):
            if not isinstance(values, dict):
                return {'error': True}
            return values.get('adx'), values.get('plusdi'), \
                values.get('minusdi')
        return values

    def fetch_candle_info_column_labels(self):
        log.debug('')
        return [
            'open_time', 'open', 'high', 'low', 'close', 'volume', 'close_time',
            'qav', 'num_trades', 'taker_base_vol', 'taker_quote_vol', 'ignore'
        ]

    def fetch_details(self, *args, **kwargs):
        '''
        [ NOTE ]: Fetch market details

        [ RETURN ]: {
            "ticker-symbol": "BTC/USDT",
            "interval": "5m",
            "history": {
                "buy-price": [{"value": 16634.68, "backtrack": 1}, ...],
                "sell-price": [{}, ],
                "volume": [{}, ],
                "adx": [{}, ],
                "macd": [{}, ],
                "macd-signal": [{}, ],
                "macd-hist": [{}, ],
                "ma": [{}, ],
                "ema": [{}, ],
                "rsi": [{}, ],
                "vwap": [{}, ]
            },
            "buy-price": 16634.68,
            "sell-price": 16634.79,
            "volume": 113695.42224,
            "indicators": {
                "adx": 15.579493600436063,
                "macd": -3.179918018162425,
                "macd-signal": -6.485571811770549,
                "macd-hist": 3.3056537936081236,
                "ma": 16634.81933333334,
                "ema": 16633.394949095054,
                "rsi": 53.52208448310394,
                "vwap": 16632.333673366094
                }
            }
        '''
        log.debug('')
        return self.update_details(*args, **kwargs)

    def fetch_account(self, *args, **kwargs):
        log.debug('')
        timestamp, return_dict = str(time.time()), {}
        return_dict.update(
            self.get_account_status(recvWindow=kwargs.get('recvWindow', 60000))
        )
        return_dict.update(
            self.get_account(recvWindow=kwargs.get('recvWindow', 60000))
        )
        self.update_cache(return_dict, self.account_cache, label=timestamp)
        return self.account_cache[timestamp]

    def fetch_asset_balance(self, *args, **kwargs):
        log.debug('')
        account = self.fetch_account(**kwargs)
        return account.get('balances', False)

#   @pysnooper.snoop()
    def fetch_supported_coins(self, *args, **kwargs):
        log.debug('')
        merged = {}
        coins = self.get_all_coins_info(
            recvWindow=kwargs.get('recvWindow', 60000)
        )
        log.debug('Supported crypto coins: {}'.format(coins))
        for coin in coins:
            merged.update({coin.get('coin'): coin,})
        timestamp = str(time.time())
        self.update_cache(
            merged, self.supported_coins_cache, label=timestamp
        )
        return merged

#   @pysnooper.snoop()
    def fetch_supported_tickers(self, *args, **kwargs):
        log.debug('')
        tickers, merged = self.get_all_tickers(), {}
        log.debug('Supported ticker symbols: {}'.format(tickers))
        for ticker_dict in tickers:
            merged.update({ticker_dict.get('symbol'): ticker_dict,})
        timestamp = str(time.time())
        self.update_cache(
            merged, self.supported_tickers_cache, label=timestamp
        )
        return merged

    def fetch_active_trades(self, *args, **kwargs):
        log.debug('')
        all_trades = self.fetch_all_trades(*args, **kwargs)
        active_trades = {}
        for key in all_trades:
            active_trades[key] = [
                item for item in all_trades[key] if item.get('status') == 'NEW'
            ]
        log.debug('Active trades: {}'.format(active_trades))
        return active_trades

#   @pysnooper.snoop()
    def fetch_all_trades(self, *args, **kwargs):
        '''
        [ INPUT ]: *args - ticker symbols to get trades for
                   **kwargs - orderId (type int) - Unique order ID
                            - startTime (type int) - Optional
                            - endTime (type int) - Optional
                            - limit (type int) - Default 500, max 1000
        [ RETURN ]: Dict with all trades grouped by ticker symbol
        '''
        log.debug('')
        timestamp, records = str(time.time()), {}
        for ticker_symbol in args:
            self.update_cache(
                self.get_all_orders(
                    symbol=ticker_symbol,
                    recvWindow=kwargs.get('order-recv-window', 60000),
                ),
                self.recent_trades_cache, label=timestamp
            )
            records.update(
                {ticker_symbol: self.recent_trades_cache[timestamp]}
            )
        log.debug('All trades: {}'.format(records))
        return records

#   @pysnooper.snoop()
    def fetch_price_value(self, **kwargs):
        log.debug('')
        self.ensure_indicator_delay()
        price_kwargs = self.format_price_indicator_kwargs(**kwargs)
        log.debug('Price action handler kwargs - {}'.format(price_kwargs))
        raw_value = self.indicator.price(**price_kwargs)
        log.debug('RAW Price API response - {}'.format(raw_value))
        if not raw_value:
            return False
        self.update_indicator_timestamp()
        value_dict = self.raw_api_response_convertor(raw_value)
        return value_dict.get('value', False) \
            if not kwargs.get('backtrack', kwargs.get('price-backtrack')) \
            and not kwargs.get('backtracks', kwargs.get('price-backtracks')) \
            else value_dict

#   @pysnooper.snoop()
    def fetch_macd_values(self, **kwargs):
        log.debug('')
        self.ensure_indicator_delay()
        raw_value = self.indicator.macd(**self.format_macd_indicator_kwargs(**kwargs))
        if not raw_value:
            return False
        self.update_indicator_timestamp()
        values = self.raw_api_response_convertor(raw_value)
        if not kwargs.get('backtrack', kwargs.get('macd-backtrack')) \
                and not kwargs.get('backtracks', kwargs.get('macd-backtracks')):
            return values.get('valueMACD', False), \
                values.get('valueMACDSignal', False), \
                values.get('valueMACDHist', False)
        return values, None, None

    def fetch_ma_value(self, **kwargs):
        log.debug('')
        self.ensure_indicator_delay()
        raw_value = self.indicator.ma(**self.format_ma_indicator_kwargs(**kwargs))
        if not raw_value:
            return False
        self.update_indicator_timestamp()
        value_dict = self.raw_api_response_convertor(raw_value)
        return value_dict.get('value', False) \
            if not kwargs.get('backtrack', kwargs.get('ma-backtrack')) \
            and not kwargs.get('backtracks', kwargs.get('ma-backtracks')) \
            else value_dict

    def fetch_ema_value(self, **kwargs):
        log.debug('')
        self.ensure_indicator_delay()
        raw_value = self.indicator.ema(**self.format_ema_indicator_kwargs(**kwargs))
        if not raw_value:
            return False
        self.update_indicator_timestamp()
        value_dict = self.raw_api_response_convertor(raw_value)
        return value_dict.get('value', False) \
            if not kwargs.get('backtrack', kwargs.get('ema-backtrack')) \
            and not kwargs.get('backtracks', kwargs.get('ema-backtracks')) \
            else value_dict

    def fetch_rsi_value(self, **kwargs):
        log.debug('')
        self.ensure_indicator_delay()
        raw_value = self.indicator.rsi(**self.format_rsi_indicator_kwargs(**kwargs))
        if not raw_value:
            return False
        self.update_indicator_timestamp()
        value_dict = self.raw_api_response_convertor(raw_value)
        return value_dict.get('value', False) \
            if not kwargs.get('backtrack', kwargs.get('rsi-backtrack')) \
            and not kwargs.get('backtracks', kwargs.get('rsi-backtracks')) \
            else value_dict

    def fetch_vwap_value(self, **kwargs):
        log.debug('')
        self.ensure_indicator_delay()
        raw_value = self.indicator.vwap(**self.format_vwap_indicator_kwargs(**kwargs))
        if not raw_value:
            return False
        self.update_indicator_timestamp()
        value_dict = self.raw_api_response_convertor(raw_value)
        return value_dict.get('value', False) \
            if not kwargs.get('backtrack', kwargs.get('vwap-backtrack')) \
            and not kwargs.get('backtracks', kwargs.get('vwap-backtracks')) \
            else value_dict

    def _fetch_time_offset(self):
        log.debug('')
        res = self.get_server_time()
        return res.get('serverTime') - int(time.time() * 1000)

    # CHECKERS

#   @pysnooper.snoop()
    def check_minimum_required_quantity_for_trade(self, quantity=0, **kwargs):
        log.debug('')
        info = self.get_symbol_info(kwargs['symbol'])
        log.debug('Ticker Symbol Info {} - {}'.format(kwargs['symbol'], info))
        if not quantity:
            stdout_msg('No trade quantity specified!', err=True)
            return False
        if float(quantity) < float(info['filters'][2]['minQty']):
            stdout_msg(
                'Not enough funds to trade withing specified parameters! '
                'Quantity {} is below the minimum required of {} {}.'
                .format(
                    quantity,
                    info['filters'][2]['minQty'],
                    kwargs['base-currency']
                ), warn=True
            )
            return False
        return True

    # FORMATTERS

    def format_trading_order_general_args_kwargs(self, label, trade_amount=None,
                                         take_profit=None, stop_loss=None,
                                         trailing_stop=None, side=None, **kwargs):
        '''
        [ NOTE ]: Returns all possible arguments used for trading in order for
                  them to be filtered according to account and order types
                  afterwards.
        '''
        log.debug('')
        sanitized_ticker = self.ticker_symbol.replace('/', '')
        return_args, return_kwargs = (), {
            'symbol': sanitized_ticker,
            'side': side.upper(),
            'type': kwargs.get('trading-order-type'),
            'quantity': trade_amount or kwargs.get('trade-amount'),
            'quoteOrderQty': kwargs.get('quote-amount'),
            'timeInForce': kwargs.get('order-time-in-force'),
            'stopLimitTimeInForce': kwargs.get('order-time-in-force'),
            'price': kwargs.get('order-price'),
            'stopPrice': kwargs.get('stop-price'),
            'stopLimitPrice': kwargs.get('stop-limit-price'),
            'newClientOrderId': kwargs.get('order-id'),
            'icebergQty': kwargs.get('order-iceberg-quantity'),
            'newOrderRespType': kwargs.get('order-response-type'),
            'recvWindow': kwargs.get('recvWindow', 60000),
        }
        log.debug(
            'return_kwargs - {}'.format(pretty_dict_print(return_kwargs))
        )
        return return_args, return_kwargs

#   @pysnooper.snoop()
    def format_trading_order_spot_account_args_kwargs(self, label, trade_amount=None,
                                         take_profit=None, stop_loss=None,
                                         trailing_stop=None, side=None, **kwargs):
        '''
        [ NOTE ]: To create an OCO order, the following parameters are required:
                  **{
                        symbol, quantity, side, price, stopPrice, stopLimitPrice,
                        stopLimitTimeInForce,
                    }

        [ EXAMPLE ]: OCO order -
            * Symbol - ticker symbol for the order.
            * Quantity - is the amount of crypto you want to purchase.
            * Side - whether to buy or sell.
            * stopLimitTimeInForce -
                * GTC (Good-Till-Cancel): the order will last until it is
                    completed or you cancel it.

                * IOC (Immediate-Or-Cancel): the order will attempt to execute
                    all or part of it immediately at the price and quantity
                    available, then cancel any remaining, unfilled part of the
                    order. If no quantity is available at the chosen price when
                    you place the order, it will be canceled immediately. Please
                    note that Iceberg orders are not supported.

                * FOK (Fill-Or-Kill): the order is instructed to execute in full
                    immediately (filled), otherwise it will be canceled (killed).
                    Please note that Iceberg orders are not supported.

            [ Limit order ]:
                * Price - The price of your limit order.
                    This order will be visible on the order book.

            [ Stop-Limit order ]:
                * StopPrice - The price at which your stop-limit order will be
                    triggered (e.g., 0.0024950 BTC).

                * StopLimitPrice - The actual price of your limit order after
                    the stop is triggered (e.g., 0.0024900 BTC).

        [ NOTE ]: Implications of order types -

            Market Order:
                Purchases an asset at the market price
                Fills immediately
                Manual

            Limit Order:
                Purchases an asset at a set price or better
                Fills only at the limit order’s price or better
                Can be set in advance

        [ Q/A ]: What is an OCO order?

            A One-Cancels-the-Other (OCO) order combines one stop limit order
            and one limit order, where if one is fully or partially fulfilled,
            the other is canceled.

            An OCO order on Binance consists of a stop-limit order and a limit
            order with the same order quantity. Both orders must be either buy
            or sell orders. If you cancel one of the orders, the entire OCO
            order pair will be canceled.

        [ Q/A ]: What is a limit order?

            A limit order is an order that you place on the order book with a
            specific limit price. It will not be executed immediately like a
            market order. Instead, the limit order will only be executed if the
            market price reaches your limit price (or better). Therefore, you
            may use limit orders to buy at a lower price or sell at a higher
            price than the current market price.

            For example, you place a buy limit order for 1 BTC at $60,000, and
            the current BTC price is 50,000. Your limit order will be filled
            immediately at $50,000, as it is a better price than the one you
            set ($60,000).

            Similarly, if you place a sell limit order for 1 BTC at $40,000 and
            the current BTC price is $50,000. The order will be filled
            immediately at $50,000 because it is a better price than $40,000.

        [ Q/A ]: What is a stop-limit order?

            A stop-limit order has a stop price and a limit price. You can set
            the minimum amount of profit you’re happy to take or the maximum
            you’re willing to spend or lose on a trade. When the trigger price
            is reached, a limit order will be placed automatically.

            Stop-limit orders are good tools for limiting the losses that may
            incur in a trade. For example, BTC is trading at $40,000, and you
            set up a stop-limit order at a stop price of $39,500 and a limit
            price of $39,000. A limit order at $39,000 will be placed when the
            price drops from $40,000 to $39,500.
        '''
        log.debug('')
        return_args, return_kwargs = self.format_trading_order_general_args_kwargs(
            label, trade_amount=trade_amount, take_profit=take_profit,
            stop_loss=stop_loss, trailing_stop=trailing_stop, side=side,
            **kwargs
        )
        whitelist = ('quantity', 'symbol')
        kwargs_keys2rem = [
            item for item in return_kwargs if not return_kwargs[item] if item
            not in whitelist
        ]
        if label == 'TEST':
            kwargs_keys2rem = kwargs_keys2rem + [
                'newOrderRespType', 'stopLimitTimeInForce', 'quoteOrderQty'
            ]
        for rd_key in kwargs_keys2rem:
            if rd_key not in kwargs_keys2rem:
                continue
            try:
                del return_kwargs[rd_key]
            except KeyError as e:
                log.error(e)
        log.debug(
            'sanitized return_kwargs - {}'.format(pretty_dict_print(return_kwargs))
        )
        return return_args, return_kwargs

    def format_trading_order_args_kwargs(self, label, trade_amount=None,
                                         take_profit=None, stop_loss=None,
                                         trailing_stop=None, side=None, **kwargs):
        '''
        [ NOTE ]: Any order with an icebergQty MUST have timeInForce set to GTC.

        :param symbol: required
        :type symbol: str
        :valid for test orders

        :param side: required
        :type side: str
        :valid for test orders

        :param type: required
        :type type: str
        :valid for test orders

        :param timeInForce: required if limit order
        :type timeInForce: str
        :valid for test orders

        :param quantity: required
        :type quantity: decimal
        :valid for test orders

        :param quoteOrderQty: amount the user wants to spend (when buying) or
            receive (when selling) of the quote asset, applicable to MARKET orders
        :type quoteOrderQty: decimal

        :param price: required
        :type price: str
        :valid for test orders

        :param newClientOrderId: A unique id for the order. Automatically
            generated if not sent.
        :type newClientOrderId: str
        :valid for test orders

        :param icebergQty: Used with LIMIT, STOP_LOSS_LIMIT, and TAKE_PROFIT_LIMIT
            to create an iceberg order.
        :type icebergQty: decimal
        :valid for test orders

        :param newOrderRespType: Set the response JSON. ACK, RESULT, or FULL;
            default: RESULT.
        :type newOrderRespType: str
        :valid for test orders

        :param recvWindow: the number of milliseconds the request is valid for
        :type recvWindow: int
        :valid for test orders

        :param listClientOrderId: A unique id for the list order. Automatically
            generated if not sent.
        :type listClientOrderId: str

        :param limitClientOrderId: A unique id for the limit order. Automatically
            generated if not sent.
        :type limitClientOrderId: str

        :param limitIcebergQty: Used to make the LIMIT_MAKER leg an iceberg order.
        :type limitIcebergQty: decimal

        :param stopClientOrderId: A unique id for the stop order. Automatically
            generated if not sent.
        :type stopClientOrderId: str

        :param stopPrice: required
        :type stopPrice: str

        :param stopLimitPrice: If provided, stopLimitTimeInForce is required.
        :type stopLimitPrice: str

        :param stopIcebergQty: Used with STOP_LOSS_LIMIT leg to make an iceberg
            order.
        :type stopIcebergQty: decimal

        :param stopLimitTimeInForce: Valid values are GTC/FOK/IOC.
        :type stopLimitTimeInForce: str

        :param recvWindow: the number of milliseconds the request is valid for
        :type recvWindow: int

        [ RETURN ]: (), {
            'symbol': ,
            'side': ,
            'type': ,
            'timeInForce': ,
            'quantity': ,
            'quoteOrderQty': ,
            'price': ,
            'newClientOrderId': ,
            'icebergQty': ,
            'newOrderRespType': ,
            'recvWindow': ,
        }
        '''
        log.debug('TODO - Add support for FUTURES, MARGIN and OPTIONS trading.')
        account_type = {
            'SPOT': self.format_trading_order_spot_account_args_kwargs,
#           'FUTURES': self.format_trading_order_futures_account_args_kwargs,
#           'MARGIN': self.format_trading_order_margin_account_args_kwargs,
#           'OPTIONS': self.format_trading_order_options_account_args_kwargs,
        }
        if kwargs.get('trading-account-type') not in account_type:
            stdout_msg(
                'Invalid trading account type specified! ({})'.format(
                    kwargs.get('trading-account-type')
                ), err=True
            )
            return (), {}
        return account_type[kwargs['trading-account-type']](
            label, trade_amount=trade_amount, take_profit=take_profit,
            stop_loss=stop_loss, trailing_stop=trailing_stop, side=side,
            **kwargs
        )

#   @pysnooper.snoop()
    def format_price_indicator_kwargs(self, **kwargs):
        log.debug('')
        log.debug('Formatter kwargs - {}'.format(kwargs))
        return_dict = self.format_general_indicator_kwargs()
        return_dict.update({
            'period': kwargs.get('price-period', 14),
            'interval': kwargs.get(
                'price-interval', kwargs.get('interval', self.period_interval)
            ),
            'backtrack': kwargs.get(
                'price-backtrack', kwargs.get('backtrack')
            ),
            'backtracks': kwargs.get(
                'price-backtracks', kwargs.get('backtracks')
            ),
            'chart': kwargs.get('price-chart', kwargs.get('chart', self.chart)),
        })
        log.debug('Formatted Price Indicator kwargs - {}'.format(return_dict))
        return return_dict

#   @pysnooper.snoop()
    def format_adx_indicator_kwargs(self, **kwargs):
        log.debug('')
        log.debug('Formatter kwargs - {}'.format(kwargs))
        return_dict = self.format_general_indicator_kwargs()
        return_dict.update({
            'interval': kwargs.get(
                'adx-interval', kwargs.get('interval', self.period_interval)
            ),
            'period': kwargs.get('adx-period', 14),
            'backtrack': kwargs.get('adx-backtrack') or kwargs.get('backtrack'),
            'backtracks': kwargs.get('adx-backtracks') or kwargs.get('backtracks'),
            'chart': kwargs.get('adx-chart', kwargs.get('chart', self.chart)),
        })
        log.debug('Formatted ADX Indicator kwargs - {}'.format(return_dict))
        return return_dict

    def format_general_indicator_kwargs(self, **kwargs):
        log.debug('')
        return {
            'exchange': kwargs.get('exchange', 'binance'),
            'symbol': kwargs.get('ticker-symbol', self.ticker_symbol),
            'interval': kwargs.get('interval', self.period_interval),
        }

    def format_macd_indicator_kwargs(self, **kwargs):
        log.debug('')
        return_dict = self.format_general_indicator_kwargs()
        return_dict.update({
            'interval': kwargs.get('macd-interval', kwargs.get(
                'interval', self.period_interval)
            ),
            'backtrack': kwargs.get('macd-backtrack', kwargs.get('backtrack')),
            'backtracks': kwargs.get('macd-backtracks', kwargs.get('backtracks')),
            'chart': kwargs.get('macd-chart', kwargs.get('chart', self.chart)),
            'optInFastPeriod': kwargs.get('macd-fast-period', 12),
            'optInSlowPeriod': kwargs.get('macd-slow-period', 26),
            'optInSignalPeriod': kwargs.get('macd-signal-period', 9),
        })
        return return_dict

    def format_ma_indicator_kwargs(self, **kwargs):
        log.debug('')
        return_dict = self.format_general_indicator_kwargs()
        return_dict.update({
            'interval': kwargs.get('ma-interval', kwargs.get(
                'interval', self.period_interval)
            ),
            'period': kwargs.get('ma-period', kwargs.get('period', self.period)),
            'backtrack': kwargs.get('ma-backtrack', kwargs.get('backtrack')),
            'backtracks': kwargs.get('ma-backtracks', kwargs.get('backtracks')),
            'chart': kwargs.get('ma-chart', kwargs.get('chart', self.chart)),
        })
        return return_dict

    def format_ema_indicator_kwargs(self, **kwargs):
        log.debug('')
        return_dict = self.format_general_indicator_kwargs()
        return_dict.update({
            'interval': kwargs.get('ema-interval', kwargs.get(
                'interval', self.period_interval)
            ),
            'period': kwargs.get('ema-period', kwargs.get('period', self.period)),
            'backtrack': kwargs.get('ema-backtrack', kwargs.get('backtrack')),
            'backtracks': kwargs.get('ema-backtracks', kwargs.get('backtracks')),
            'chart': kwargs.get('ema-chart', kwargs.get('chart', self.chart)),
        })
        return return_dict

    def format_rsi_indicator_kwargs(self, **kwargs):
        log.debug('')
        return_dict = self.format_general_indicator_kwargs()
        return_dict.update({
            'interval': kwargs.get('rsi-interval', kwargs.get(
                'interval', self.period_interval)
            ),
            'period': kwargs.get('rsi-period', kwargs.get('period', self.period)),
            'backtrack': kwargs.get('rsi-backtrack', kwargs.get('backtrack')),
            'backtracks': kwargs.get('rsi-backtracks', kwargs.get('backtracks')),
            'chart': kwargs.get('rsi-chart', kwargs.get('chart', self.chart)),
        })
        return return_dict

    def format_vwap_indicator_kwargs(self, **kwargs):
        log.debug('')
        return_dict = self.format_general_indicator_kwargs()
        return_dict.update({
            'interval': kwargs.get('vwap-interval', kwargs.get(
                'interval', self.period_interval)
            ),
            'period': kwargs.get('vwap-period', kwargs.get('period', self.period)),
            'backtrack': kwargs.get('vwap-backtrack', kwargs.get('backtrack')),
            'backtracks': kwargs.get('vwap-backtracks', kwargs.get('backtracks')),
            'chart': kwargs.get('vwap-chart', kwargs.get('chart', self.chart)),
        })
        return return_dict

    # GENERAL

#   @pysnooper.snoop('log/nomads-gold.log')
    def build_candle_info_data_frame(self, *args, **kwargs):
        log.debug('')
        try:
            candle_info = self.fetch_candle_info(*args, **kwargs)
            if not candle_info:
                stdout_msg(
                    'Could not fetch candle info! Details: {}'
                    .format(candle_info), err=True
                )
            data_frame = pandas.DataFrame(candle_info)
            data_frame.columns = self.fetch_candle_info_column_labels()
        except Exception as e:
            stdout_msg(
                'Could not build candle info dataframe! \nDetails: {}'.format(e),
                err=True
            )
            return False
        return data_frame

#   @pysnooper.snoop()
    def trade(self, trade_amount, *args, take_profit=None, stop_loss=None,
              trailing_stop=None, side='buy', **kwargs):
        '''
        [ EXCEPTIONS ]:

            binance.exceptions.BinanceAPIException: APIError(code=-1013): \
                Filter failure: MIN_NOTIONAL

            This error appears because you are trying to create an order with a
            quantity lower than the minimun required.

            You can access the minimun required of a specific pair with:

            >>> info = client.get_symbol_info('ETHUSDT')
            >>> print(info)

            Output a dictionary with information about that pair. Now you can
            access the minimun quantity required with:

            >>> print(info['filters'][2]['minQty'])
            # 0.00001

        [ WARNING ]: Using the Binance API only futures trading supports
                     take-profit and stop-loss targets. These include LEVERAGE!

              [ i ]: Sooo.. you could change the trading account type from the
                     config file, but for your safety (we love you!!) the
                     default are SPOT orders which require a combination of puts
                     and calls to ensure take-profit and stop-loss targets are
                     honoured.

              [ ! ]: In order to work around this limitation for SPOT orders,
                     each time a order is placed the bot can write down a
                     notification message to either a file that is constantly
                     monitored, or a FIFO pipe which is constantly read from -
                     that contains the order details including suggested
                     stop-loss and take-profit targets. I duonno, just saying.
        '''
        log.debug('')
        handlers, order = {'buy': self.buy, 'sell': self.sell}, None
        if side not in handlers:
            log.error('Invalid trade side! ({})'.format(side))
        hlabel, handlers = 'TEST' if kwargs.get('test') else 'GODSPEED', {
            'TEST': self.create_test_order,
            'GODSPEED': self.create_oco_order,
        }
        stdout_msg(
            '{} account {} order -'.format(
                kwargs.get('trading-account-type'),
                kwargs.get('trading-order-type')
            ), symbol=side.upper(), bold=True
        )
        if hlabel == 'TEST':
            stdout_msg('Creating test buy order...', info=True)
        else:
            stdout_msg('Creating buy order...', info=True)
        try:
            order_args, order_kwargs = self.format_trading_order_args_kwargs(
                hlabel, trade_amount=trade_amount, take_profit=take_profit,
                stop_loss=stop_loss, trailing_stop=trailing_stop, side=side,
                **kwargs
            )
            log.debug(
                '{} Trade order - Type {} - *args, **kwargs - ({}) ({})'.format(
                    kwargs.get('trading-account-type'),
                    kwargs.get('trading-order-type'),
                    order_args, order_kwargs
                )
            )
            check_qty = self.check_minimum_required_quantity_for_trade(
                **order_kwargs
            )
            if not check_qty and not kwargs.get('test'):
                return False
            elif not check_qty:
                stdout_msg(
                    'Running in testing mode. Pushing through errors...',
                    warn=True
                )
            stdout_msg(
                pretty_dict_print(order_kwargs), symbol='ORDER', bold=True
            )
            order = handlers[hlabel](*order_args, **order_kwargs)
        except Exception as e:
            log.error(e)
        finally:
            return order

#   @pysnooper.snoop()
    def buy(self, trade_amount, *args, take_profit=None, stop_loss=None,
            trailing_stop=None, **kwargs):
        log.debug('')
        details = kwargs.copy()
        details['side'] = 'buy'
        return self.trade(
            trade_amount, *args, take_profit=take_profit, stop_loss=stop_loss,
            trailing_stop=trailing_stop, **details
        )

#   @pysnooper.snoop()
    def sell(self, trade_amount, *args, take_profit=None, stop_loss=None,
             trailing_stop=None,  **kwargs):
        log.debug('')
        details = kwargs.copy()
        details['side'] = 'sell'
        return self.trade(
            trade_amount, *args, take_profit=take_profit, stop_loss=stop_loss,
            trailing_stop=trailing_stop, **details
        )

#   @pysnooper.snoop()
    def raw_api_response_convertor(self, raw_value):
        log.debug('')
        sanitized = ''.join(list(raw_value)[1:]).replace("'", '')
        return json.loads(sanitized)

    def truncate_cache(cache_dict, size_limit):
        log.debug('')
        if not cache_dict or not isinstance(size_limit, int) \
                or size_limit > len(cache_dict):
            return False
        size_limit -= 1
        keys_to_remove = list(reversed(sorted(cache_dict)))[size_limit:]
        for key in keys_to_remove:
            del cache_dict[key]

    def synced(self, func_name, **kwargs):
        log.debug('')
        kwargs['timestamp'] = int(time.time() - self.time_offset)
        return getattr(self, func_name)(**kwargs)

    def close_position(self, *args, **kwargs):
        '''
        [ INPUT ]: *args    - trade ID's (type int)
                   **kwargs - symbol (type str) - ticker symbol, default is
                              active market
                            - recvWindow (type int) - binance API response
                              window, default is 60000
        [ RETURN ]: Closed trades (type lst), failed closes (type lst)
        '''
        log.debug('')
        if not args:
            stdout_msg(
                'No trade ID\'s given to close positions for!', err=True
            )
            return False
        closed_trade, failed_close = [], []
        stdout_msg('Closing trades... {}'.format(args), info=True)
        for trade_id in args:
            close = cancel_order(**{
                'symbol': kwargs.get('symbol', self.ticker_symbol),
                'orderId': trade_id,
                'recvWindow': kwargs.get('recvWindow', 60000),
            })
            if not close:
                failed_close.append(trade_id)
                stdout_msg(
                    'Something went wrong! Could not close trade ({})'
                    .format(trade_id), nok=True
                )
                continue
            closed_trade.append(trade_id)
            stdout_msg(
                'Trade position closed! ({})'.format(trade_id), ok=True
            )
        return closed_trade, failed_close

    # COMPUTERS

#   @pysnooper.snoop()
    def compute_volume_history_from_candle_info(self, candle_info, **kwargs):
        '''
        [ RETURN ]: [{'value':, 'backtrack': ,}]
        '''
        log.debug('')
        info_dict = candle_info.to_dict()
        volume_history = [
            {'value': info_dict['volume'][candle_index], 'backtrack': candle_index}
            for candle_index in info_dict['volume']
        ]
        return volume_history

#   @pysnooper.snoop()
    def compute_price_history_support(self, price_history):
        log.debug('')
        if not price_history or \
                (isinstance(price_history, dict) and price_history.get('error')):
            return False
        return min([
            price_history[index]['value'] for index in range(len(price_history))
        ])

#   @pysnooper.snoop()
    def compute_price_history_resistance(self, price_history):
        log.debug('')
        if not price_history or \
                (isinstance(price_history, dict) and price_history.get('error')):
            return False
        return max([
            price_history[index]['value'] for index in range(len(price_history))
        ])

    def compute_ticker_symbol(self, base=None, quote=None):
        log.debug('')
        return str(base) + '/' + str(quote)

    # ENSURANCE

    def ensure_indicator_delay(self):
        log.debug('')
        if not self.last_indicator_update_timestamp:
            return True
        if self.indicator_update_delay:
            stdout_msg(
                'API call delay: {} seconds'.format(self.indicator_update_delay),
                red=True
            )
        while True:
            now = datetime.datetime.now()
            difference = now - self.last_indicator_update_timestamp
            if float(difference.seconds) < float(self.indicator_update_delay):
                continue
            break
        return True

    # UPDATERS

#   @pysnooper.snoop('log/nomads-gold.log')
    def update_price_volume_history(self, *update_targets,
                                    timestamp=str(time.time()), **kwargs):
        '''
        [ NOTE ]: Data fetched from binance.com
        '''
        log.debug('TODO - Period date strings not yet supported')
        return_dict = {'history': {
            'price': [], 'volume': [], 'price-support': None,
            'price-resistance': None,
        }}
        details = kwargs.copy()
        stdout_msg('Updating market price action history...', info=True)
        if not kwargs.get('backtrack') and not kwargs.get('backtracks'):
            stdout_msg(
                'No default backtrack(s) values specified! '
                'Defaulting backtracks to ({})'.format(self.history_backtracks),
                warn=True
            )
            details.update({'backtracks': self.history_backtracks,})
        try:
            builder_kwargs = kwargs.copy()
            # TODO - Period date strings not yet supported
            builder_kwargs.update({'period-start': None, 'period-end': None})
            candle_info = self.build_candle_info_data_frame(**builder_kwargs)
        except Exception as e:
            return_dict.update({
                'error': True,
                'msg': 'Could not build candle info data frame!',
            })
            stdout_msg(return_dict['msg'], err=True)
            return return_dict
        log.debug('Candle INFO dataframe - {}'.format(candle_info))
        if 'all' in update_targets or 'price' in update_targets:
            return_dict['history']['price'] = self.fetch_price_value(**details)
            return_dict['history'].update({
                'price-support': self.compute_price_history_support(
                    return_dict['history']['price']
                ),
                'price-resistance': self.compute_price_history_resistance(
                    return_dict['history']['price']
                ),
            })
            stdout_msg(
                'Price History - {} periods of {} candles'.format(
                    len(return_dict['history']['price']),
                    kwargs.get('interval', self.period_interval)
                ), ok=True
            )
        if 'all' in update_targets or 'volume' in update_targets:
            return_dict['history']['volume'] = self.compute_volume_history_from_candle_info(
                candle_info, **kwargs
            )
            stdout_msg(
                'Volume History - {} periods of {} candles'.format(
                    len(return_dict['history']['volume']),
                    kwargs.get('interval', self.period_interval)
                ), ok=True
            )
        return return_dict['history']

#   @pysnooper.snoop()
    def update_indicator_history(self, *update_targets,
                                 timestamp=str(time.time()), **kwargs):
        '''
        [ NOTE ]: Data fetched from taapi.io
        '''
        log.debug('')
        return_dict, details = {'history': {}}, kwargs.copy()
        stdout_msg('Updating market indicator history...', info=True)
        if not details.get('backtrack') and not details.get('backtracks'):
            stdout_msg(
                'No default backtrack(s) values specified! '
                'Defaulting backtracks to ({})'.format(self.history_backtracks),
                warn=True
            )
            details.update({'backtracks': self.history_backtracks,})
        if 'all' in update_targets or 'indicators' in update_targets \
                or 'adx' in update_targets:
            adx_history = self.fetch_adx_value(**details)
            if adx_history:
                stdout_msg(
                    'ADX History - {} periods of {} candles'.format(
                        kwargs.get('period', self.period),
                        kwargs.get('interval', self.period_interval)
                    ), ok=True
                )
            return_dict['history'].update({'adx': adx_history})
        if 'all' in update_targets or 'indicators' in update_targets \
                or 'macd' in update_targets:
            macd_history, _, _ = self.fetch_macd_values(**details)
            if macd_history:
                stdout_msg(
                    'MACD History - {} periods of {} candles'.format(
                        kwargs.get('period', self.period),
                        kwargs.get('interval', self.period_interval)
                    ), ok=True
                )
            return_dict['history'].update({'macd': macd_history,})
        if 'all' in update_targets or 'indicators' in update_targets \
                or 'ma' in update_targets:
            ma_history = self.fetch_ma_value(**details)
            if ma_history:
                stdout_msg(
                    'MA History - {} periods of {} candles'.format(
                        kwargs.get('period', self.period),
                        kwargs.get('interval', self.period_interval)
                    ), ok=True
                )
            return_dict['history'].update({'ma': ma_history})
        if 'all' in update_targets or 'indicators' in update_targets \
                or 'ema' in update_targets:
            ema_history = self.fetch_ema_value(**details)
            if ema_history:
                stdout_msg(
                    'EMA History - {} periods of {} candles'.format(
                        kwargs.get('period', self.period),
                        kwargs.get('interval', self.period_interval)
                    ), ok=True
                )
            return_dict['history'].update({'ema': ema_history})
        if 'all' in update_targets or 'indicators' in update_targets \
                or 'rsi' in update_targets:
            rsi_history = self.fetch_rsi_value(**details)
            if rsi_history:
                stdout_msg(
                    'RSI History - {} periods of {} candles'.format(
                        kwargs.get('period', self.period),
                        kwargs.get('interval', self.period_interval)
                    ), ok=True
                )
            return_dict['history'].update({'rsi': rsi_history})
        if 'all' in update_targets or 'indicators' in update_targets \
                or 'vwap' in update_targets:
            vwap_history = self.fetch_vwap_value(**details)
            if vwap_history:
                stdout_msg(
                    'VWAP History - {} periods of {} candles'.format(
                        kwargs.get('period', self.period),
                        kwargs.get('interval', self.period_interval)
                    ), ok=True
                )
            return_dict['history'].update({'vwap': vwap_history})
        log.debug('Indicator history: {}'.format(return_dict))
        return return_dict['history']

    def update_indicator_timestamp(self):
        log.debug('')
        self.last_indicator_update_timestamp = datetime.datetime.now()
        log.debug(
            'Last indicator update at ({})'.format(
                self.last_indicator_update_timestamp
            )
        )
        return self.last_indicator_update_timestamp

#   @pysnooper.snoop()
    def update_cache(self, element, cache_dict, **kwargs):
        log.debug('')
        size_limit = kwargs.get('size_limit', self.cache_size_limit)
        if len(cache_dict.keys()) > size_limit:
            truncate_cache = truncate_cache(cache_dict, size_limit - 1)
            if not truncate_cache:
                return 1
        label = kwargs.get('label', str(time.time()))
        cache_dict[label] = element
        log.debug('Updated cache - {}: {}'.format(cache_dict[label], element))
        return cache_dict

    def update_coin_details(self, timestamp=str(time.time()), **kwargs):
        log.debug('')
        self.update_cache(
            self.get_all_coins_info(recvWindow=60000),
            self.coin_info_cache, label=timestamp
        )
        return {'coin-info-cache': self.coin_info_cache}

    def update_trade_fee_details(self, timestamp=str(time.time()), **kwargs):
        log.debug('')
        self.update_cache(
            self.get_trade_fee(symbol=self.ticker_symbol, recvWindow=60000),
            self.trade_fee_cache, label=timestamp
        )
        return {'trade-fee-cache': self.trade_fee_cache}

#   @pysnooper.snoop()
    def update_price_volume_details(self, *update_targets,
                                    timestamp=str(time.time()), **kwargs):
        log.debug('')
        return_dict = {}
        stdout_msg('Updating price action details...', info=True)
        self.update_cache(
            self.get_ticker(
                symbol=kwargs.get('ticker-symbol', self.ticker_symbol).replace('/', '')
            ), self.ticker_info_cache, label=timestamp
        )
        if 'all' in update_targets or 'price' in update_targets:
            self.buy_price = float(
                self.ticker_info_cache[timestamp].get('bidPrice')
            )
            self.sell_price = float(
                self.ticker_info_cache[timestamp].get('askPrice')
            )
            return_dict.update({
                'buy-price': self.buy_price,
                'sell-price': self.sell_price,
            })
            stdout_msg(
                'Buy Price value - {}'.format(return_dict['buy-price']),
                ok=True if return_dict['buy-price'] else False,
                nok=True if not return_dict['buy-price'] else False
            )
            stdout_msg(
                'Sell Price value - {}'.format(return_dict['sell-price']),
                ok=True if return_dict['sell-price'] else False,
                nok=True if not return_dict['sell-price'] else False
            )
        if 'all' in update_targets or 'volume' in update_targets:
            self.volume = float(
                self.ticker_info_cache[timestamp].get('volume')
            )
            return_dict.update({'volume': self.volume})
            stdout_msg(
                'Trading Volume value - {}'.format(return_dict['volume']),
                ok=True if return_dict['volume'] else False,
                nok=True if not return_dict['volume'] else False
            )
        log.debug('Price volume details - {}'.format(return_dict))
        return return_dict

#   @pysnooper.snoop()
    def update_indicator_details(self, *update_targets,
                                 timestamp=str(time.time()), **kwargs):
        log.debug('')
        return_dict, details = {'indicators': {}}, kwargs.copy()
        details.update({
            'backtrack': None,
            'backtracks': None,
            'price-backtrack': None,
            'price-backtracks': None,
            'adx-backtrack': None,
            'macd-backtrack': None,
            'ma-backtrack': None,
            'ema-backtrack': None,
            'rsi-backtrack': None,
            'vwap-backtrack': None,
            'volume-backtrack': None,
            'adx-backtracks': None,
            'macd-backtracks': None,
            'ma-backtracks': None,
            'ema-backtracks': None,
            'rsi-backtracks': None,
            'vwap-backtracks': None,
            'volume-backtracks': None,
        })
        stdout_msg('Updating market indicator details...', info=True)
        if kwargs.get('indicator-update-delay'):
            stdout_msg(
                'This may take a long time! If you used free API keys from \n{} '
                'leave the default of 18 seconds between API calls.\nIf not - you '
                'can speed this process up by modifying the \nindicator-update-delay '
                'value in the .config file in accordance with the \nplan you purchased.'
                .format(self.taapi_url), warn=True
            )
        if 'all' in update_targets or 'indicators' in update_targets \
                or 'adx' in update_targets:
            self.adx, self.plusdi, self.minusdi = self.fetch_adx_value(**details)
            return_dict['indicators'].update({
                'adx': self.adx, '+di': self.plusdi, '-di': self.minusdi,
            })
            stdout_msg(
                'ADX Values - \nADX - {}\n+DI - {}\n-DI - {}'.format(
                    return_dict['indicators']['adx'],
                    return_dict['indicators']['+di'],
                    return_dict['indicators']['-di'],

                ),
                ok=True if self.adx else False,
                nok=True if not self.adx else False
            )
        if 'all' in update_targets or 'indicators' in update_targets \
                or 'macd' in update_targets:
            self.macd, self.macd_signal, self.macd_hist = self.fetch_macd_values(
                **details
            )
            return_dict['indicators'].update({
                'macd': self.macd, 'macd-signal': self.macd_signal,
                'macd-hist': self.macd_hist
            })
            stdout_msg(
                'MACD Values -\nMACD - {}\nSignal - {}\nHistory - {}'.format(
                    return_dict['indicators']['macd'],
                    return_dict['indicators']['macd-signal'],
                    return_dict['indicators']['macd-hist'],
                ),
                ok=True if self.macd else False,
                nok=True if not self.macd else False
            )
        if 'all' in update_targets or 'indicators' in update_targets \
                or 'ma' in update_targets:
            self.ma = self.fetch_ma_value(**details)
            return_dict['indicators'].update({'ma': self.ma})
            stdout_msg(
                'MA Value - {}'.format(return_dict['indicators']['ma']),
                ok=True if self.ma else False,
                nok=True if not self.ma else False
            )
        if 'all' in update_targets or 'indicators' in update_targets \
                or 'ema' in update_targets:
            self.ema = self.fetch_ema_value(**details)
            return_dict['indicators'].update({'ema': self.ema})
            stdout_msg(
                'EMA Value - {}'.format(return_dict['indicators']['ema']),
                ok=True if self.ema else False,
                nok=True if not self.ema else False
            )
        if 'all' in update_targets or 'indicators' in update_targets \
                or 'rsi' in update_targets:
            self.rsi = self.fetch_rsi_value(**details)
            return_dict['indicators'].update({'rsi': self.rsi})
            stdout_msg(
                'RSI Value - {}'.format(return_dict['indicators']['rsi']),
                ok=True if self.rsi else False,
                nok=True if not self.rsi else False
            )
        if 'all' in update_targets or 'indicators' in update_targets \
                or 'vwap' in update_targets:
            self.vwap = self.fetch_vwap_value(**details)
            return_dict['indicators'].update({'vwap': self.vwap})
            stdout_msg(
                'VWAP Value - {}'.format(return_dict['indicators']['vwap']),
                ok=True if self.vwap else False,
                nok=True if not self.vwap else False
            )
        return return_dict

#   @pysnooper.snoop()
    def update_details(self, *args, **kwargs):
        '''
        [ INPUT  ]: *(
                coin, price, volume, trade-fee, indicators, macd, adx, vwap, rsi,
                ma, ema, all, vwap
            )
            **{
                'interval': 5m,
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
            }

        [ RETURN ]: Dict with updated values - {
            'ticker-symbol': 'BTC/USDT',
            'buy-price': 20903.77,
            'sell-price': 20904.5,
            'volume': 7270.56273,
            'interval': '1h'
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
                'price-support': 16547.39,
                'price-resistance': 21903.77,
                'price': [{
                    'value': 20903.77,
                    'backtrack': 0,
                }, ...],
                'volume': [{
                    'value': 7270.56273,
                    'backtrack': 0,
                }, ...],
                "adx": [{
                    "adx": 26.47395654961293,
                    "plusdi": ...,
                    "minusdi": ...,
                    "backtrack": 0
                }, ...],
                "macd": [{
                    "valueMACD": -1.6422658763985964,
                    "valueMACDSignal": 4.268392787839131,
                    "valueMACDHist": -5.910658664237728,
                    "backtrack": 0
                }, ...],
                'ma': [{
                    'value': 21216.220666666643,
                    'backtrack': 0,
                }, ...],
                'ema': [{
                    'value': 21216.220700066643,
                    'backtrack': 0,
                }, ...],
                'rsi': [{
                    'value': 25.931456303405913,
                    'backtrack': 0,
                }, ...],
                'vwap': [{
                    'value': 20592.650164735693,
                    'backtrack': 0,
                }, ...],
            }
        }
        '''
        log.debug('')
        log.debug('Market details update received kwargs - {}'.format(kwargs))
        timestamp, return_dict = str(time.time()), {
            'ticker-symbol': self.ticker_symbol,
            'interval': kwargs.get('interval', self.period_interval),
            'indicators': {},
            'history': {},
        }
        update_targets = args or ('price', 'volume', 'trade-fee')
        if 'all' in update_targets or 'coin' in update_targets:
            self.update_coin_details(timestamp=timestamp, **kwargs)
        if 'all' in update_targets or 'price' in update_targets \
                or 'volume' in update_targets:
            return_dict.update(
                self.update_price_volume_details(
                    *args, timestamp=timestamp, **kwargs
                )
            )
            return_dict['history'].update(
                self.update_price_volume_history(
                    *args, timestamp=timestamp, **kwargs
                )
            )
        if 'all' in update_targets or 'trade-fee' in update_targets:
            self.update_trade_fee_details(timestamp=timestamp, **kwargs)
        if 'all' in update_targets or 'indicators' in update_targets \
                or 'vwap' in update_targets \
                or 'rsi' in update_targets \
                or 'macd' in update_targets \
                or 'ma' in update_targets \
                or 'ema' in update_targets \
                or 'adx' in update_targets:
            return_dict.update(
                self.update_indicator_details(
                    *args, timestamp=timestamp, **kwargs
                )
            )
            return_dict['history'].update(
                self.update_indicator_history(
                    *args, timestamp=timestamp, **kwargs
                )
            )
        log.debug('Updated details - {}'.format(return_dict))
        return return_dict

# CODE DUMP

