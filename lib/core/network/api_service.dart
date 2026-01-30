import 'package:dio/dio.dart';
import 'package:hungryapp/core/network/api_exceptions.dart';
import 'package:hungryapp/core/network/dio_client.dart';

class ApiService {
  final DioClient dioClient = DioClient();

  ///get
  Future<dynamic> get(String endPoint) async {
    try {
      final response = await dioClient.dio.get(endPoint);
      return response.data;
    } on DioError catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }

  ///post
  Future<dynamic> post(String endPoint, Map<String, dynamic> body) async {
    try {
      final response = await dioClient.dio.post(endPoint, data: body);
      return response.data;
    } on DioError catch (e) {
    throw ApiExceptions.handleError(e);
    }
  }

  ///put
  Future<dynamic> put(String endPoint, Map<String, dynamic> body) async {
    try {
      final response = await dioClient.dio.put(endPoint, data: body);
      return response.data;
    } on DioError catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }

  ///Delete
  Future<dynamic> delete(String endPoint, Map<String, dynamic> body) async {
    try {
      final response = await dioClient.dio.delete(endPoint, data: body);
      return response.data;
    } on DioError catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }
}
