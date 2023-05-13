import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import '../../constants/constants.dart';
import '../../utils/utils.dart';
import 'app_endpoint.dart';

const String METHOD_GET = "GET";
const String METHOD_POST = "POST";
const String METHOD_PUT = "PUT";
const String METHOD_DELETE = "DELETE";

class AppClients extends DioForNative {
  static AppClients? _instance;

  factory AppClients(
      {String baseUrl = AppEndpoint.BASE_URL, BaseOptions? options}) {
    _instance ??= AppClients._(baseUrl: baseUrl, options: options);
    if (options != null) _instance!.options = options;
    _instance!.options.baseUrl = baseUrl;
    return _instance!;
  }

  AppClients._({String baseUrl = AppEndpoint.BASE_URL, BaseOptions? options})
      : super(options) {
    interceptors.add(InterceptorsWrapper(
          onRequest: _requestInterceptor,
          onResponse: _responseInterceptor,
          onError: _errorInterceptor,
        ));
    this.options.baseUrl = baseUrl;
  }

  _requestInterceptor(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers.addEntries(
        [MapEntry('Authorization', AppPrefs.instance.getNormalToken())]);
    log("[RequestInterceptor] [${options.method}] ${options.uri}:");
    log("Header: ${options.headers}");
    switch (options.method) {
      case METHOD_GET:
        log("Params: ${options.queryParameters}");
        break;
      default:
        if (options.data is Map) {
          log("Params: ${options.data}");
        } else if (options.data is FormData) {
          log("Params: ${options.data.fields}");
        }
        break;
    }
    options.connectTimeout = AppEndpoint.connectionTimeout;
    options.receiveTimeout = AppEndpoint.receiveTimeout;
    handler.next(options);
  }

  _responseInterceptor(Response response, ResponseInterceptorHandler handler) {
    log("[ResponseInterceptor] ${response.requestOptions.uri}: ${response.statusCode}\nData: ${response.data}");
    handler.next(response);
  }

  _errorInterceptor(DioError dioError, ErrorInterceptorHandler handler) {
    log("[ErrorInterceptor] ${dioError.response?.requestOptions.uri} ${dioError.type}\n${dioError.message}");
    handler.next(dioError);
  }
}
