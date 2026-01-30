import 'package:dio/dio.dart';
import 'package:hungryapp/core/utils/pref_helper.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://sonic-zdi0.onrender.com/api',
      headers: {'Content_Type': 'application/json'},
      
    ),
  );
  DioClient() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (Options, Handle) {

          final token = PrefHelper.getToken();

            Options.headers['Authorization'] = 'Bearer$token';

          Handle.next(Options);
        },
      ),
    );
  }
  Dio get dio => _dio;
}
