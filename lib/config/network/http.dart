import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as DGet;

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import '../../common/models/authentication/auth_model.dart';
import '../constants/app_constants.dart';
import '../local/data_storage.dart';
import 'check_connection.dart';

enum ApiServerErrorType {
  noInternet,
  httpException,
  badRequest,
  timeout,
  unAuthorized,
  unKnow,
  serverExpected
}

class ApiServerErrorData {
  ApiServerErrorType? type;
  String? message;
  int? statusCode;
  String? errorCode;

  ApiServerErrorData(
      {this.type, this.statusCode, this.message, this.errorCode});
}

_handleError(DioException error) {
  final result = ApiServerErrorData(
    type: ApiServerErrorType.unKnow,
    errorCode: null,
    message: error.message,
  );

  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      result.type = ApiServerErrorType.timeout;
      break;
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      break;
    case DioExceptionType.badResponse:
      print(
          '''[api] _handleError DioErrorType.RESPONSE status code: ${error.response?.statusCode}''');
      result.statusCode = error.response?.statusCode ?? 0;
      result.message = error.response?.data is String
          ? error.response?.data
          : error.response?.data['message'] ??
              error.response?.data['error_message'] ??
              "";
      if (result.statusCode == 400) {
        result.type = ApiServerErrorType.badRequest;
        if (error.response?.data is! String) {
          result.errorCode = error.response?.data["code"] ??
              error.response?.data['error_code'];
        }
      } else if (result.statusCode == 401) {
        result.type = ApiServerErrorType.unAuthorized;
        if (error.response?.data is! String) {
          dynamic _errCode = error.response?.data["code"] ??
              error.response?.data['error_code'];
          result.errorCode =
              _errCode is String ? _errCode : _errCode?.toString();
        }
      } else if (result.statusCode! >= 500 && result.statusCode! < 600) {
        result.type = ApiServerErrorType.httpException;
      } else {
        result.type = ApiServerErrorType.httpException;
        result.message = error.response?.data ?? {};
      }
      break;
    case DioExceptionType.cancel:
      break;
    case DioExceptionType.unknown:
      print(
          '''[api] _handleError DioErrorType.DEFAULT status code: error.response is null -> Server die or No Internet connection''');
      result.type = ApiServerErrorType.noInternet;
      if (error.message!.contains('Unexpected character')) {
        result.type = ApiServerErrorType.serverExpected;
      }
      break;
    default:
      break;
  }

  throw (result);
}

class _DioConfig {
  static const String _apiDomain = "http://192.168.1.85:8016";
  late Dio _dio;

  _DioConfig() {
    _dio = Dio();
    _dio.options
      ..baseUrl = _apiDomain
      ..headers.clear()
      ..headers[HttpConstants.contentType] = 'application/json'
      ..connectTimeout = Duration(milliseconds: 50000)
      ..receiveTimeout = Duration(milliseconds: 50000);

    final cookieJar = CookieJar();
    _dio.interceptors.add(CookieManager(cookieJar)); //setCookie
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (request, handle) {
        dynamic data = DataStorage().getStorageByKey(TypeDataStorage.Auth);
        if (data != null &&
            request.headers[HttpConstants.authorization] == null) {
          AuthModel? _auth =
              data is Map<String, dynamic> ? AuthModel.fromJson(data) : data;
          request.headers[HttpConstants.authorization] =
              'Bearer ${_auth?.accessToken}';
        }
        return handle.next(request);
      },
      onResponse: (response, handle) {
        return handle.next(response);
      },
      // onError: (error, handler) async {
      //   dynamic data = error.response?.data;
      //   if (data is Map &&
      //       data["error_code"] == "NotAuthorizedException" &&
      //       (data["error_message"] == "Access Token has been revoked" ||
      //           data["error_message"] == "Access Token has expired" ||
      //           data["error_message"] == "Invalid Access Token")) {
      //     // AuthModel? _auth = await refreshToken();
      //     // if (_auth != null) {
      //     //   error.requestOptions.headers[HttpConstants.authorization] =
      //     //       'Bearer ${_auth.accessToken}';
      //     //   final res = await _dio.fetch(error.requestOptions);
      //     //   return handler.resolve(res);
      //     // }
      //   }
      //   return handler.next(error);
      // },
    ));

    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: true,
          responseHeader: false,
          request: false,
          requestBody: true));
    }
  }

  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    bool isLoading = true,
  }) async {
    return checkConnection(() async {
      try {
        if (headers != null) {
          _dio.options..headers[headers.keys.first] = headers.values.first;
        }
        var response = await _dio.get(
          uri,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
        );
        return response.data;
      } on SocketException catch (e) {
        throw SocketException(e.toString());
      } on FormatException catch (_) {
        throw const FormatException("Unable to process the data");
      } on DioException catch (e) {
        return {
          'statusCode': e.response?.statusCode,
          'message': e.response?.data['message']
        };
      } finally {}
    });
  }

  // Future<dynamic> upFile({
  //   required File avatar,
  //   Options? options,
  //   CancelToken? cancelToken,
  //   ProgressCallback? onSendProgress,
  //   ProgressCallback? onReceiveProgress,
  //   bool isLoading = true,
  // }) async {
  //   return checkConnection(() async {
  //     try {
  //       Loading.show();
  //       ;
  //       var formData = FormData.fromMap({
  //         "file": MultipartFile.fromFileSync(avatar.path,
  //             filename: avatar.path.split(Platform.pathSeparator).last)
  //       });
  //       DataStorage _storage = DataStorage();
  //       var _authJson = _storage.getAuth();
  //       AuthModel _auth = _authJson;
  //       final headers = {
  //         "token": _auth.accessToken!,
  //       };
  //       _dio.options..headers[headers.keys.first] = headers.values.first;
  //       var response = await _dio.post(
  //         ApiUrl.UP_FILE,
  //         data: formData,
  //         options: options,
  //         cancelToken: cancelToken,
  //         onSendProgress: onSendProgress,
  //         onReceiveProgress: onReceiveProgress,
  //       );
  //       return response.data;
  //     } on FormatException catch (_) {
  //       throw FormatException("Unable to process the data $_");
  //     } on DioException catch (e) {
  //       // _handleError(e);
  //       return {
  //         'statusCode': e.response?.statusCode,
  //         'message': e.response?.data['message']
  //       };
  //     } finally {
  //       Loading.show();
  //     }
  //   });
  // }

  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool isLoading = true,
  }) async {
    return checkConnection(() async {
      try {
        if (headers != null) {
          _dio.options..headers[headers.keys.first] = headers.values.first;
        }
        var response = await _dio.post(
          uri,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        );
        print(response);
        return response.data;
      } on FormatException catch (_) {
        throw FormatException("Unable to process the data $_");
      } on DioException catch (e) {
        // _handleError(e);
        return {
          'statusCode': e.response?.statusCode,
          'message': e.response?.data['message']
        };
      } finally {}
    });
  }

  Future<dynamic> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool isLoading = true,
  }) async {
    return checkConnection(() async {
      try {
        if (headers != null) {
          _dio.options..headers[headers.keys.first] = headers.values.first;
        }
        var response = await _dio.put(
          uri,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        );
        return response.data;
      } on FormatException catch (_) {
        throw FormatException("Unable to process the data $_");
      } on DioException catch (e) {
        return {
          'statusCode': e.response?.statusCode,
          'message': e.response?.data['message']
        };
      } finally {}
    });
  }

  Future<dynamic> patch(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool isLoading = true,
  }) async {
    return checkConnection(() async {
      try {
        var response = await _dio.patch(
          uri,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        );
        return response.data;
      } on FormatException catch (_) {
        throw const FormatException("Unable to process the data");
      } on DioException catch (e) {
        return {
          'statusCode': e.response?.statusCode,
          'message': e.response?.data['message']
        };
      } finally {}
    });
  }

  Future<dynamic> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Options? options,
    CancelToken? cancelToken,
    bool isLoading = true,
  }) async {
    return checkConnection(() async {
      try {
        if (headers != null) {
          _dio.options..headers[headers.keys.first] = headers.values.first;
        }
        var response = await _dio.delete(
          uri,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        );
        return response.data;
      } on FormatException catch (_) {
        throw const FormatException("Unable to process the data");
      } on DioException catch (e) {
        return {
          'statusCode': e.response?.statusCode,
          'message': e.response?.data['message']
        };
      } finally {}
    });
  }

  lock() {
    _dio.close();
  }

  unlock() {
    // _dio.;
  }
}

_DioConfig http = _DioConfig();
