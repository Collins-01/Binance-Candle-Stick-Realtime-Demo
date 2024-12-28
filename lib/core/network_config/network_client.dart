import 'dart:io';

import 'package:binance_demo/core/errors/errors.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'network_interceptors.dart';

// import 'package:mime/mime.dart';

Dio _createDio() {
  // String baseUrl =
  //     'http://${Platform.isAndroid ? '10.0.2.2' : 'localhost'}:3000';
  var dio = Dio(
    BaseOptions(
      receiveTimeout: const Duration(seconds: 35), // 15 seconds
      connectTimeout: const Duration(seconds: 35),
      sendTimeout: const Duration(seconds: 60),
      headers: {},
    ),
  );

  /// Adds our Custom Interceptos to the DIO Interceptors
  dio.interceptors.add(NetworkServiceInterceptors(
    dio,
    errorKey: 'message',
  ));

  return dio;
}

enum FormDataType { post, patch }

class NetworkClient {
  //  const bool _enableLogging = true;
  final Map<String, dynamic> _headers = {
    // "Authorization": "Bearer ${_authService.accessToken}"
  };

  ///Initialises the Dio Variable

  final Dio _dio = _createDio();
  Dio get dio => _dio;

  ///Makes a [GET] request and returns data of type[T]
  Future<T> get<T>(
    /// the api route path without the base url
    String uri, {
    Map<String, dynamic> queryParameters = const {},
    // Options options,
    Map<String, dynamic>? requestHeaders,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      Response response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        options: Options(headers: requestHeaders ?? {}),
      );
      // checkRequest(response);
      return response.data;
    } on Failure {
      rethrow;
    }
  }

  ///[POST] sends a post request to the server.
  Future<dynamic> post(
    /// the api route without the base url
    String uri, {
    ///this are query parameters that would
    /// be attached to the url
    /// [e.g]=>{"a":"yes"}
    /// https://she.com/getPeople?a=yes
    Map<String, dynamic> queryParameters = const {},
    Object? body,
    Map<String, dynamic>? requestHeaders,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      Response response = await _dio.post(
        uri,
        queryParameters: queryParameters,
        data: body,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        options: Options(
          headers: requestHeaders ?? _headers,
        ),
      );
      // checkRequest(response);
      return response.data;
    } on Failure {
      rethrow;
    }
  }

  Future<T> put<T>(
    /// the api route without the base url
    String uri, {
    ///this are query parameters that would
    /// be attached to the url
    /// [e.g]=>{"a":"yes"}
    /// she.com/getPeople?a=yes
    Map<String, dynamic> queryParameters = const {},
    Object body = const {},
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? requestHeaders,
  }) async {
    try {
      Response response = await _dio.put(
        uri,
        queryParameters: queryParameters,
        data: body,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        options: Options(
          headers: requestHeaders ?? _headers,
        ),
      );
      // checkRequest(response);
      return response.data;
    } on Failure {
      rethrow;
    }
  }

  Future<T> patch<T>(
    /// the api route without the base url
    String uri, {
    ///this are query parameters that would
    /// be attached to the url
    /// [e.g]=>{"a":"yes"}
    /// she.com/getPeople?a=yes
    Map<String, dynamic> queryParameters = const {},
    Object body = const {},
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? requestHeaders,
  }) async {
    try {
      Response response = await _dio.patch(
        uri,
        queryParameters: queryParameters,
        data: body,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        options: Options(
          headers: requestHeaders ?? _headers,
        ),
      );
      // checkRequest(response);
      return response.data;
    } on Failure {
      rethrow;
    }
  }

  Future<T> delete<T>(
    /// the api route path without the base url
    ///
    String uri, {
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic>? requestHeaders,
    // Options options,
    CancelToken? cancelToken,
  }) async {
    try {
      Response response = await _dio.delete(
        uri,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: Options(
          headers: requestHeaders ?? _headers,
        ),
      );
      return response.data;
    } on Failure {
      rethrow;
    }
  }

  Future<dynamic> sendFormData(
    FormDataType requestType, {
    /// route path without baseurl
    required String uri,

    ///this are query parameters that would
    /// be attached to the url
    /// [e.g]=>{"a":"yes"}
    /// she.com/getPeople?a=yes
    Map<String, dynamic> queryParameters = const {},

    /// data to be sent
    /// [must not add file]
    required Map<String, dynamic> body,

    /// Files to be sent
    /// [Files only]
    /// for all the images you want to send
    /// the key would act as the parameter sent
    /// to the server
    Map<String, File> images = const {},
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      Map<String, MultipartFile> multipartImages = {};
      await Future.forEach<MapEntry<String, File>>(
        images.entries,
        (item) async {
          multipartImages[item.key] = await MultipartFile.fromFile(
            item.value.path,
          );
        },
      );
      FormData formData = FormData.fromMap({
        ...body,
        ...multipartImages,
      });
      Response response;
      if (FormDataType.patch == requestType) {
        response = await _dio.patch(
          uri,
          queryParameters: queryParameters,
          data: formData,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          options: Options(
            headers: _headers,
          ),
        );
      } else {
        response = await _dio.post(
          uri,
          queryParameters: queryParameters,
          data: formData,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          options: Options(headers: _headers),
        );
      }
      return response.data;
    } on Failure {
      rethrow;
    }
  }

  Future<dynamic> sendArrayImagesFormData(
    FormDataType requestType, {
    /// route path without baseurl
    required String uri,

    ///this are query parameters that would
    /// be attached to the url
    /// [e.g]=>{"a":"yes"}
    /// she.com/getPeople?a=yes
    Map<String, dynamic> queryParameters = const {},

    /// data to be sent
    /// [must not add file]
    // required Map<String, dynamic> body,

    /// Files to be sent
    /// [Files only]
    /// for all the images you want to send
    /// the key would act as the parameter sent
    /// to the server
    // Map<String, File> images = const {},
    List<File> images = const [],
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var tempList = [];
      for (var i = 0; i < images.length; i++) {
        var item = images[i];
        // final mimeTypeData =
        //     lookupMimeType(item.path, headerBytes: [0xFF, 0xD8])?.split("/");
        var multipartFile = await MultipartFile.fromFile(
          item.path,
          // contentType: MediaType(mimeTypeData![0], mimeTypeData[1]),
        );
        tempList.add(multipartFile);
      }

      FormData formData = FormData.fromMap(
        {
          'images': tempList,
        },
      );
      Response response;
      if (FormDataType.patch == requestType) {
        response = await _dio.patch(
          uri,
          queryParameters: queryParameters,
          data: formData,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          options: Options(
            headers: _headers,
          ),
        );
      } else {
        response = await _dio.post(
          uri,
          queryParameters: queryParameters,
          data: formData,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          options: Options(headers: _headers),
        );
      }
      return response.data;
    } on Failure {
      rethrow;
    }
  }
}

final networkClientProvider = Provider<NetworkClient>((ref) {
  return NetworkClient();
});
