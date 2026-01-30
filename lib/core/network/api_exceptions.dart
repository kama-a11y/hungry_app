import 'package:dio/dio.dart';
import 'package:hungryapp/core/network/api_error.dart';

class ApiExceptions {
  static ApiError handleError(DioException error) {
    final  StatusCode = error.response?.statusCode;
    final data = error.response?.data;

      
      if (data is Map<String, dynamic> && data["message"] != null) {
        return ApiError(
          message: data["message"] ,
          statusCode: StatusCode ,
        );
      }
    
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(message: 'Connection timeout');

      case DioExceptionType.sendTimeout:
        return ApiError(message: 'Request timeout');

      case DioExceptionType.receiveTimeout:
        return ApiError(message: 'Server not responding');

      case DioExceptionType.connectionError:
        return ApiError(message: 'No internet connection');

      default:
        return ApiError(message: 'Something wrong');
    }
  }
}
