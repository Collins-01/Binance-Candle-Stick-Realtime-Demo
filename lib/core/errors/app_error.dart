import 'failure.dart';

class AppError implements Failure {
  final String _title;
  final String _message;
  AppError(this._title, this._message);
  @override
  String get message => _message;

  @override
  String get title => _title;
}
