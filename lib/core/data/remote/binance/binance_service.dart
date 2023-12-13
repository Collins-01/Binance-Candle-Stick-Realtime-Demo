import 'package:binance_demo/core/data/remote/binance/binance_interface.dart';
import 'package:binance_demo/core/network_config/network_client.dart';
import 'package:binance_demo/utils/utils.dart';
import 'package:candlesticks/candlesticks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BinanceServiceImpl implements BinanceService {
  final NetworkClient _networkClient;
  BinanceServiceImpl(this._networkClient);
  final _logger = appLogger(BinanceServiceImpl);
  @override
  Future<void> establishSocketConnection(
      {required String symbol, required String interval}) {
    // TODO: implement establishSocketConnection
    throw UnimplementedError();
  }

  @override
  Future<List<Candle>> getCandles(
      {required String symbol, required String interval, int? endTime}) async {
    final String uri =
        "https://api.binance.com/api/v3/klines?symbol=$symbol&interval=$interval${endTime != null ? "&endTime=$endTime" : ""}";
    final data = await _networkClient.get(uri) as List;
    _logger.d("Candles... $data");
    return data.map((e) => Candle.fromJson(e)).toList().reversed.toList();
  }

  @override
  Future<List<String>> getSymbols() async {
    const uri = "https://api.binance.com/api/v3/ticker/price";
    final res = await _networkClient.get(uri) as List;
    _logger.d("Symbols Response:: $res");
    return res.map((e) => e["symbol"] as String).toList();
  }
}

final binanceServiceProvider = Provider<BinanceService>((ref) {
  return BinanceServiceImpl(
    ref.read(networkClientProvider),
  );
});
