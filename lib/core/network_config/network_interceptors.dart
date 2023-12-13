import 'package:binance_demo/core/errors/errors.dart';
import 'package:binance_demo/utils/utils.dart';
import 'package:dio/dio.dart';

import 'exceptions/exceptions.dart';

class NetworkServiceInterceptors extends Interceptor {
  final _logger = const AppLogger(NetworkServiceInterceptors);
  final Dio dio;
  String? token;
  final String errorKey;
  Function(DioException err, ErrorInterceptorHandler handler)? onErrorCustom;
  NetworkServiceInterceptors(this.dio,
      {this.errorKey = '', this.onErrorCustom});
  @override
  Future<dynamic> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    _logger.e("Error from Dio: ",
        functionName: "onError", error: err.toString());
    if (err.response?.statusCode != null) {
      switch (err.response?.statusCode) {
        case 400:
          err = BadRequestException(
            err.requestOptions,
            err.response,
            errorKey,
          );
          break;
        case 401:
          err = UnAuthorizedException(
            err.requestOptions,
            err.response,
            errorKey,
          );
          break;
        case 403:
          err = UnAuthorizedException(
            err.requestOptions,
            err.response,
            errorKey,
          );
          break;
        case 404:
          err = NotFoundException(
            err.requestOptions,
            err.response,
            errorKey,
          );
          break;
        case 409:
          err = ConflictException(
            err.requestOptions,
            err.response,
            errorKey,
          );
          break;
        case 500:
          err = InternalServerErrorException(
            err.requestOptions,
            err.response,
          );
          break;
        case 503:
          err = ServerCommunicationException(err.response);
          break;
        default:
          err = RequestUnknownExcpetion(err.requestOptions, err.response);
          break;
      }
    } else {
      switch (err.type) {
        case DioExceptionType.connectionError:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.connectionTimeout:
          err = DeadlineExceededException(err.requestOptions);
          break;
        case DioExceptionType.badCertificate:
          err = BadCertificateException(err.requestOptions);
          break;
        case DioExceptionType.badResponse:
          err = BadResponseException(err.requestOptions);
          break;
        case DioExceptionType.cancel:
          err = CancelRequestException(err.requestOptions);
          break;
        case DioExceptionType.unknown:
          err = RequestUnknownExcpetion(err.requestOptions);
          break;
      }
    }

    return handler.next(err);
  }

  @override
  Future<dynamic> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    return handler.next(options);
  }

  @override
  Future<dynamic> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    checkStatusCode(response.requestOptions, response);
    return handler.next(response);
  }

  void checkStatusCode(
    RequestOptions requestOptions,
    Response? response,
  ) async {
    try {
      switch (response?.statusCode) {
        case 200:
        case 204:
        case 201:
          break;
        case 400:
          throw BadRequestException(requestOptions, response);
        case 401:
          throw UnAuthorizedException(requestOptions);
        case 404:
          throw NotFoundException(requestOptions);
        case 409:
          throw ConflictException(requestOptions, response);
        case 500:
          throw InternalServerErrorException(requestOptions);
        default:
          throw ServerCommunicationException(response);
      }
    } on Failure {
      rethrow;
    }
  }
}
