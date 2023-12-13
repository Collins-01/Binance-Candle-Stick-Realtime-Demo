import 'package:dio/dio.dart';

import 'package:binance_demo/core/errors/errors.dart';

import 'get_error.dart';

///No Internet Connection
class NoInternetConnectionException extends DioException implements Failure {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'title: $title message: $message';
  }

  @override
  String get message => "No internet connection, please try again";

  @override
  String get title => "No Network";

  String getErrorInfo(error, [String key = '']) {
    return getErrorInfoFromResponse(error);
  }
}
