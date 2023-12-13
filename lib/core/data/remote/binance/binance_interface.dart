import 'package:candlesticks/candlesticks.dart';

abstract class BinanceInterface {
  Future<List<String>> getSymbols();
  Future<List<Candle>> getCandles({
    required String symbol,
    required String interval,
    int? endTime,
  });

  Future<void> establishSocketConnection({
    required String symbol,
    required String interval,
  });
}

abstract class BinanceService implements BinanceInterface {}

abstract class BinanceRepository implements BinanceInterface {}
