import 'package:binance_demo/core/data/data.dart';
import 'package:binance_demo/core/errors/errors.dart';
import 'package:binance_demo/core/models/models.dart';
import 'package:binance_demo/presentation/states/states.dart';
import 'package:binance_demo/utils/utils.dart';
import 'package:candlesticks/candlesticks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomeViewModel extends BaseViewModel {
  final Ref ref;
  HomeViewModel(this.ref);
  final _logger = appLogger(HomeViewModel);
  int _selectedInterval = 0;
  int get selectedInterval => _selectedInterval;
  List<SymbolResponseModel> _symbols = [];
  List<SymbolResponseModel> get symbols => _symbols;
  WebSocketChannel? _channel;
  WebSocketChannel? get channel => _channel;
  Stream<dynamic> _candleSticksStream = Stream.empty();
  Stream<dynamic> get candleSticksStream => _candleSticksStream;
  List<Candle> _candles = [];
  List<Candle> get candles => _candles;
  String _currentInterval = "1m";
  String get currentInterval => _currentInterval;
  SymbolResponseModel? _currentSymbol;
  SymbolResponseModel? get currentSymbol => _currentSymbol;
  int _currentTabIndex = 0;
  int get currentTabIndex => _currentTabIndex;
  int _bottomTabIndex = 0;
  int get bottomTabIndex => _bottomTabIndex;
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

  final intervals = [
    '1m',
    '3m',
    '5m',
    '15m',
    '30m',
    '1h',
    '2h',
    '4h',
    '6h',
    '8h',
    '12h',
    '1d',
    '3d',
    '1w',
    '1M',
  ];
  Future<void> getSymbols() async {
    try {
      changeState(const ViewModelState.busy());
      final result = await ref.read(binanceRepositoryProvider).getSymbols();
      _symbols = result;
      changeState(const ViewModelState.idle());
      if (_symbols.isNotEmpty) {
        _currentSymbol = _symbols[0];
        await getCandles(_symbols[0], _currentInterval);
      }
    } on Failure catch (e) {
      changeState(ViewModelState.error(e));
    } catch (e) {
      final err = AppError("unknown error", e.toString());
      changeState(ViewModelState.error(err));
    }
  }

  Future<void> getCandles(SymbolResponseModel symbol, String interval) async {
    if (_channel != null) {
      _channel!.sink.close();
      _channel = null;
    }
    _candles = [];
    _currentInterval = interval;
    notifyListeners();
    try {
      final result = await ref
          .read(binanceRepositoryProvider)
          .getCandles(symbol: symbol.symbol, interval: interval);
      // _logger.d(result);
      _channel = await ref
          .read(binanceRepositoryProvider)
          .establishSocketConnection(symbol: symbol.symbol, interval: interval);
      _candleSticksStream =
          _channel?.stream.asBroadcastStream() ?? const Stream.empty();
      _candles = result;
      _currentInterval = interval;
      _currentSymbol = symbol;
      notifyListeners();
    } catch (e) {
      _logger.e(e.toString());
    }
  }

  listenToCandleStreamAndUpdate(AsyncSnapshot<dynamic> data) {}
}

final homeViewModelProvider = ChangeNotifierProvider<HomeViewModel>((ref) {
  return HomeViewModel(ref);
});
