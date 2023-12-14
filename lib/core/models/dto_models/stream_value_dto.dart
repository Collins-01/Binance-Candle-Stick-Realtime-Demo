import 'package:binance_demo/core/models/models.dart';

class StreamValueDTO {
  StreamValueDTO({
    required this.symbol,
    required this.interval,
  });
  late SymbolResponseModel symbol;
  late String? interval;
}
