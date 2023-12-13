import 'package:dio/dio.dart';
import 'package:binance_demo/core/errors/errors.dart';

import 'get_error.dart';

/// errors sent back by the server in json
class ServerCommunicationException extends DioException implements Failure {
  ServerCommunicationException(this.r)
      : super(requestOptions: r!.requestOptions);

  /// sustained so that the data sent by the server can be gotten to construct message
  final Response? r;

  @override
  String toString() {
    return 'title: $title message: $message';
  }

  @override
  String get message {
    return "A server error has occured, please try again later";
  }

  @override
  String get title => "Server Error ";

  String getErrorInfo(error, [String key = '']) {
    return getErrorInfoFromResponse(error);
  }
}
