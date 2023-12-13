import 'package:binance_demo/core/errors/errors.dart';

class UserDefinedExceptions extends Failure {
  final String _title;
  final String _message;

  UserDefinedExceptions(this._title, this._message);
  @override
  String get message => _message;

  @override
  String get title => _title;
}
