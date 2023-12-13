import 'package:dio/dio.dart';
import 'package:binance_demo/core/errors/errors.dart';

import 'get_error.dart';

class CancelRequestException extends DioException implements Failure {
  @override
  final RequestOptions requestOptions;
  CancelRequestException(this.requestOptions)
      : super(requestOptions: requestOptions);
  @override
  String get message => "Request was cancelled, please try again.";

  @override
  String get title => "Request Cancelled";

  String getErrorInfo(error, [String key = '']) {
    return getErrorInfoFromResponse(error);
  }
}
