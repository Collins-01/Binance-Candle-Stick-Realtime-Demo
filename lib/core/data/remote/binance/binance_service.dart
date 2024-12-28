import 'dart:convert';

import 'package:binance_demo/core/data/remote/binance/binance_interface.dart';
import 'package:binance_demo/core/models/models.dart';
import 'package:binance_demo/core/network_config/network_client.dart';
import 'package:binance_demo/utils/utils.dart';
import 'package:candlesticks/candlesticks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BinanceServiceImpl implements BinanceService {
  // inject
  final NetworkClient _networkClient;
  BinanceServiceImpl(this._networkClient);
  final _logger = appLogger(BinanceServiceImpl);
  @override
  WebSocketChannel establishSocketConnection(
      {required String symbol, required String interval}) {
    final channel = WebSocketChannel.connect(
      Uri.parse('wss://stream.binance.com:9443/ws'),
    );

    channel.sink.add(
      jsonEncode(
        {
          'method': 'SUBSCRIBE',
          'params': ['$symbol@kline_$interval'],
          'id': 1
        },
      ),
    );

    channel.sink.add(
      jsonEncode(
        {
          'method': 'SUBSCRIBE',
          'params': ['$symbol@depth'],
          'id': 1
        },
      ),
    );

    return channel;
  }

  @override
  Future<List<Candle>> getCandles(
      {required String symbol, required String interval, int? endTime}) async {
    final String uri =
        "https://api.binance.com/api/v3/klines?symbol=$symbol&interval=$interval${endTime != null ? "&endTime=$endTime" : ""}";
    final data = await _networkClient.get(uri) as List;
    // _logger.d("Candles... $data");
    return data.map((e) => Candle.fromJson(e)).toList().reversed.toList();
  }

  @override
  Future<List<SymbolResponseModel>> getSymbols() async {
    const uri = "https://api.binance.com/api/v3/ticker/price";
    final res = await _networkClient.get(uri) as List;
    // _logger.d("Symbols Response:: $res");
    final arr = res.map((e) => SymbolResponseModel.fromMap(e)).toList();

    return arr;
  }
}

final binanceServiceProvider = Provider<BinanceService>((ref) {
  return BinanceServiceImpl(
    ref.read(networkClientProvider),
  );
});
