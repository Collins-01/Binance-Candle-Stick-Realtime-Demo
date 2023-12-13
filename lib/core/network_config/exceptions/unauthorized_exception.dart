import 'package:dio/dio.dart';
import 'package:binance_demo/core/errors/errors.dart';

import 'get_error.dart';

const _unkownErrorString = "An error occured, please try again. ";

///401
class UnAuthorizedException extends DioException implements Failure {
  final RequestOptions request;
  final Response? serverResponse;
  final String errorKey;
  UnAuthorizedException(this.request, [this.serverResponse, this.errorKey = ''])
      : super(requestOptions: request, response: serverResponse);

  @override
  String toString() {
    return "Error was:\nTitle: $title\nMessage: $message ";
  }

  @override
  String get message {
    if (serverResponse == null) {
      return _unkownErrorString;
    } else {
      return getErrorInfo(serverResponse?.data, errorKey);
    }
  }

  @override
  String get title => "Access denied.";

  String getErrorInfo(error, [String key = '']) {
    return getErrorInfoFromResponse(error);
  }
}
