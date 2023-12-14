import 'package:candlesticks/candlesticks.dart';

class CandleTickerModel {
  final int eventTime;
  final String symbol;
  final Candle candle;
  const CandleTickerModel({
    required this.eventTime,
    required this.candle,
    required this.symbol,
  });

  factory CandleTickerModel.fromJson(Map<String, dynamic> json) {
    return CandleTickerModel(
      symbol: json['s'] as String,
      eventTime: json['E'] as int,
      candle: Candle(
        open: double.parse(json['k']['o']),
        close: double.parse(json['k']['c']),
        volume: double.parse(json['k']['v']),
        date: DateTime.fromMillisecondsSinceEpoch(json['k']['t']),
        high: double.parse(json['k']['h']),
        low: double.parse(json['k']['l']),
      ),
    );
  }
}
