import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tanami_capital/core/api/api_helper.dart';
import 'package:tanami_capital/core/errors/base.dart';

class DioApiHelper implements ApiHelper<Response> {
  final Dio dio;

  DioApiHelper(this.dio);

  Future<Response> _handleRequest(Future<Response> Function() request) async {
    try {
      final response = await request();

      // ✅ Explicitly validate response if `validateRequest` is always true
      _validateResponse(response);

      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      if (e is ServerFailure) {
        rethrow;
      } else {
        throw GeneralFailure(message: e.toString());
      }
    }
  }

  @override
  Future<Response> get(String url, {Map<String, String>? headers}) async {
    return _handleRequest(
      () => dio.get(url, options: Options(headers: headers)),
    );
  }

  @override
  Future<Response> post(
    String url, {
    dynamic body,
    Map<String, String>? headers,
  }) async {
    return _handleRequest(
      () => dio.post(url, data: body, options: Options(headers: headers)),
    );
  }

  @override
  Future<Response> put(
    String url, {
    dynamic body,
    Map<String, String>? headers,
  }) async {
    return _handleRequest(
      () => dio.put(url, data: body, options: Options(headers: headers)),
    );
  }

  @override
  Future<Response> delete(String url, {Map<String, String>? headers}) async {
    return _handleRequest(
      () => dio.delete(url, options: Options(headers: headers)),
    );
  }

  /// ✅ Validate response manually
  void _validateResponse(Response response) {
    if (response.statusCode == null || response.statusCode! >= 400) {
      log("Response: ${response.data}");
      throw ServerFailure(
        message:
            response.data is Map
                ? response.data['message']
                : response.statusMessage,
        statusCode: response.statusCode ?? 0,
      );
    }
  }

  ServerFailure _handleDioError(DioException error) {
    String errorMessage;
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        errorMessage = "Connection timeout. Please try again.";
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = "Request timeout. Please try again.";
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = "Response timeout. Please try again.";
        break;
      case DioExceptionType.badResponse:
        errorMessage =
            "Server error: ${error.response?.statusCode} - ${error.response?.statusMessage}";
        break;
      case DioExceptionType.cancel:
        errorMessage = "Request was cancelled.";
        break;
      case DioExceptionType.unknown:
      default:
        errorMessage = "Something went wrong. Please try again.";
    }
    return ServerFailure(
      message: errorMessage,
      statusCode: error.response?.statusCode ?? 0,
    );
  }
}
