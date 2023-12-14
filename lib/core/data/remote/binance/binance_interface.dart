import 'package:binance_demo/core/models/models.dart';
import 'package:candlesticks/candlesticks.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

abstract class BinanceInterface {
  Future<List<SymbolResponseModel>> getSymbols();
  Future<List<Candle>> getCandles({
    required String symbol,
    required String interval,
    int? endTime,
  });

  WebSocketChannel establishSocketConnection({
    required String symbol,
    required String interval,
  });
}

abstract class BinanceService implements BinanceInterface {}

abstract class BinanceRepository implements BinanceInterface {}
