import 'dart:async';
import 'dart:convert';
import 'package:binance_demo/core/data/data.dart';
import 'package:binance_demo/core/errors/errors.dart';
import 'package:binance_demo/core/models/models.dart';
import 'package:binance_demo/presentation/states/states.dart';
import 'package:binance_demo/utils/utils.dart';
import 'package:candlesticks/candlesticks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomeViewModel extends BaseViewModel {
  final Ref ref;
  HomeViewModel(this.ref);
  final _logger = appLogger(HomeViewModel);
  // ******************************** [VARIABLES] ************************************
  int _selectedInterval = 0;
  int get selectedInterval => _selectedInterval;
  List<SymbolResponseModel> _symbols = [];
  List<SymbolResponseModel> get symbols => _symbols;
  WebSocketChannel? _channel;
  WebSocketChannel? get channel => _channel;

  List<Candle> _candles = [];
  List<Candle> get candles => _candles;
  String _currentInterval = "1H";
  String get currentInterval => _currentInterval;
  SymbolResponseModel? _currentSymbol;
  SymbolResponseModel? get currentSymbol => _currentSymbol;
  int _currentTabIndex = 0;
  int get currentTabIndex => _currentTabIndex;
  int _bottomTabIndex = 0;
  int get bottomTabIndex => _bottomTabIndex;

  CandleTickerModel? _candleTicker;
  CandleTickerModel? get candleTicker => _candleTicker;
  OrderBook? _orderBooks;
  OrderBook? get orderBooks => _orderBooks;

  // ***************************************[SETTERS]**********************************************
  setBottomTabIndex(int value) {
    _bottomTabIndex = value;
    notifyListeners();
  }

  setTabIndex(int v) {
    _currentTabIndex = v;
    notifyListeners();
  }

  setInterval(String value) {
    _currentInterval = value;
    notifyListeners();
  }

  setCurrentSymbol(SymbolResponseModel v) {
    _currentSymbol = v;
    notifyListeners();
  }

  setSelectedInterval(int index) {
    _selectedInterval = index;
    notifyListeners();
  }

  setCandleTicker(CandleTickerModel candleT) {
    _candleTicker = candleT;
    notifyListeners();
  }

  setOrderBook(OrderBook data) {
    _orderBooks = data;
    notifyListeners();
  }

// ************************************[METHODS]*************************************
  Future<void> getSymbols() async {
    _logger.d("Getting Symbols.....");
    try {
      changeState(const ViewModelState.busy());
      final result = await ref.read(binanceRepositoryProvider).getSymbols();
      changeState(const ViewModelState.idle());
      _symbols = result;
      _logger.d("Symbols Length ===> ${_symbols.length}");
      if (_symbols.isNotEmpty) {
        _currentSymbol = _symbols[11];
      }
      notifyListeners();
    } on Failure catch (e) {
      changeState(ViewModelState.error(e));
      _logger.e(e.message);
    } catch (e) {
      _logger.e(e.toString());
      final err =
          AppError("unknown error", "an error occurred, please try again.");
      changeState(ViewModelState.error(err));
    }
  }

  Future<void> getCandles(SymbolResponseModel symbol, String interval) async {
    _logger.d("Getting Candles......");
    try {
      changeState(const ViewModelState.busy());
      final result = await ref.read(binanceRepositoryProvider).getCandles(
            symbol: symbol.symbol,
            interval: interval.toLowerCase(),
          );
      _candles = result;
      _logger.d("Candles Length :: ${_candles.length}");
      changeState(const ViewModelState.idle());
    } on Failure catch (e) {
      changeState(ViewModelState.error(e));
      _logger.e(e.message);
    } catch (e) {
      _logger.e(e.toString());
      final err =
          AppError("unknown error", "an error occurred, please try again.");
      changeState(ViewModelState.error(err));
    }
  }

  initializeWebSocket({
    required String symbol,
    required String interval,
  }) async {
    _logger.d("Initializing websocket..");
    final binanceRepository = ref.read(binanceRepositoryProvider);

    final chn = binanceRepository.establishSocketConnection(
      interval: interval.toLowerCase(),
      symbol: symbol.toLowerCase(),
    );

    await for (final String value in chn.stream) {
      // _logger.d("Incoming Data from websocket === $value");
      final map = jsonDecode(value) as Map<String, dynamic>;
      final eventType = map['e'];
      // * CHECK IF IT IS KLINE
      if (eventType == 'kline') {
        final candleTicker = CandleTickerModel.fromJson(map);
        setCandleTicker(candleTicker);
        if (_candles[0].date == candleTicker.candle.date &&
            _candles[0].open == candleTicker.candle.open) {
          _candles[0] = candleTicker.candle;
          notifyListeners();
        } else if (candleTicker.candle.date.difference(_candles[0].date) ==
            _candles[0].date.difference(_candles[1].date)) {
          _candles.insert(0, candleTicker.candle);
          notifyListeners();
        }
      } else if (eventType == 'depthUpdate') {
        final orderBookInfo = OrderBook.fromMap(map);
        setOrderBook(orderBookInfo);
      }
    }
  }

  Future<void> loadMoreCandles(StreamValueDTO streamValue) async {
    try {
      final data = await ref.read(binanceRepositoryProvider).getCandles(
            symbol: streamValue.symbol.symbol,
            interval: streamValue.interval!,
            endTime: _candles.last.date.millisecondsSinceEpoch,
          );
      _candles
        ..removeLast()
        ..addAll(data);
      notifyListeners();
    } on Failure catch (e) {
      _logger.d("Custom Error fetching candles ==> ${e.message}");
    } catch (e) {
      _logger.d("Error fetching more candles ::: ${e.toString()}");
    }
  }
}

final homeViewModelProvider = ChangeNotifierProvider<HomeViewModel>((ref) {
  return HomeViewModel(ref);
});
