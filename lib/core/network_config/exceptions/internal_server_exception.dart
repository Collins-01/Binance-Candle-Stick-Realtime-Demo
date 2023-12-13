import 'package:dio/dio.dart';
import 'package:binance_demo/utils/utils.dart';

import 'package:binance_demo/core/errors/errors.dart';

import 'get_error.dart';

class InternalServerErrorException extends DioException implements Failure {
  final _logger = appLogger(InternalServerErrorException);
  final RequestOptions request;
  final Response? serverResponse;
  InternalServerErrorException(this.request, [this.serverResponse])
      : super(requestOptions: request, response: serverResponse);

  @override
  String toString() {
    return "Error was:\nTitle: $title\nMessage: $message ";
  }

  @override
  String get title => "Server Error";
  @override
  String get message {
    _logger.e(serverResponse?.data);
    return "An Unknown error occcured, please try again later";
  }

  String getErrorInfo(error, [String key = '']) {
    return getErrorInfoFromResponse(error);
  }
}
