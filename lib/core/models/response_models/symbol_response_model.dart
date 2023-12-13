// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SymbolResponseModel {
  final String symbol;
  final String price;
  SymbolResponseModel({
    required this.symbol,
    required this.price,
  });

  SymbolResponseModel copyWith({
    String? symbol,
    String? price,
  }) {
    return SymbolResponseModel(
      symbol: symbol ?? this.symbol,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'symbol': symbol,
      'price': price,
    };
  }

  factory SymbolResponseModel.fromMap(Map<String, dynamic> map) {
    return SymbolResponseModel(
      symbol: map['symbol'] as String,
      price: map['price'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SymbolResponseModel.fromJson(String source) =>
      SymbolResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SymbolResponseModel(symbol: $symbol, price: $price)';

  @override
  bool operator ==(covariant SymbolResponseModel other) {
    if (identical(this, other)) return true;

    return other.symbol == symbol && other.price == price;
  }

  @override
  int get hashCode => symbol.hashCode ^ price.hashCode;
}
