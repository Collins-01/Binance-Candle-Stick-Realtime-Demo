import 'package:binance_demo/core/data/remote/binance/binance_interface.dart';
import 'package:binance_demo/core/network_config/network_client.dart';
import 'package:candlesticks/candlesticks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BinanceServiceImpl implements BinanceService {
  final NetworkClient _networkClient;
  BinanceServiceImpl(this._networkClient);
  @override
  Future<void> establishSocketConnection(
      {required String symbol, required String interval}) {
    // TODO: implement establishSocketConnection
    throw UnimplementedError();
  }

  @override
  Future<List<Candle>> getCandles(
      {required String symbol, required String interval, int? endTime}) {
    // TODO: implement getCandles
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getSymbols() {
    // TODO: implement getSymbols
    throw UnimplementedError();
  }
}

final binanceServiceProvider = Provider<BinanceService>((ref) {
  return BinanceServiceImpl(
    ref.read(networkClientProvider),
  );
});
