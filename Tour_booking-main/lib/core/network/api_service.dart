import 'package:dio/dio.dart';
import 'package:hotel_booking/app/constants/api_endpoints.dart';
import 'package:hotel_booking/app/di/di.dart';
import 'package:hotel_booking/app/shared_prefs/token_shared_prefs.dart';
import 'package:hotel_booking/core/network/auth_inspector.dart';
import 'package:hotel_booking/core/network/dio_error_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';


class ApiService {
  final Dio _dio;

  Dio get dio => _dio;

  ApiService(this._dio) {
    _dio
      ..options.baseUrl = ApiEndpoints.baseUrl
      ..options.connectTimeout = ApiEndpoints.connectionTimeout
      ..options.receiveTimeout = ApiEndpoints.receiveTimeout
      // Add the error interceptor
      ..interceptors.add(DioErrorInterceptor())
      // Log requests and responses
      ..interceptors.add(PrettyDioLogger(
          requestHeader: true, requestBody: true, responseHeader: true))
      // Add our auth interceptor to attach the token automatically
      ..interceptors.add(AuthInterceptor(getIt<TokenSharedPrefs>()))
      ..options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
  }
}
