import 'package:binance_demo/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:binance_demo/core/errors/errors.dart';

import 'get_error.dart';

const _unkownErrorString = "An error occured, please try again. ";

class BadRequestException extends DioException implements Failure {
  final _logger = appLogger(BadRequestException);
  final RequestOptions request;
  final Response? serverResponse;
  final String errorKey;

  BadRequestException(this.request, [this.serverResponse, this.errorKey = ''])
      : super(requestOptions: request, response: serverResponse);

  @override
  String get title {
    if (serverResponse == null) {
      return "Bad Request";
    }
    return serverResponse?.data['message'] ?? "";
  }

  @override
  String get message {
    _logger.d(serverResponse?.data);
    if (serverResponse == null) {
      return _unkownErrorString;
    } else {
      return getErrorInfo(serverResponse?.data, errorKey);
    }
  }

  String getErrorInfo(error, [String key = '']) {
    return getErrorInfoFromResponse(error);
  }
}
