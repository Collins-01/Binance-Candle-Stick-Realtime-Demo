import 'package:dio/dio.dart';
import 'package:binance_demo/core/errors/errors.dart';

import 'get_error.dart';

class RequestUnknownExcpetion extends DioException implements Failure {
  final Response? serverResponse;
  @override
  final RequestOptions requestOptions;
  RequestUnknownExcpetion(this.requestOptions, [this.serverResponse])
      : super(
          requestOptions: requestOptions,
          response: serverResponse,
        );

  @override
  String get message => "An unknown error occured, please try again later.";

  @override
  String get title => "Unkown Error";

  String getErrorInfo(error, [String key = '']) {
    return getErrorInfoFromResponse(error);
  }
}
