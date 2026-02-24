import 'package:dio/dio.dart';
import 'package:hungryapp/core/utils/pref_helper.dart';
class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://sonic-zdi0.onrender.com/api',
      headers: {
        "Content-Type": 'application/json',
        "Accept": 'application/json',
        },
    ),
  );

  DioClient() {
    // _dio.interceptors.add( 
    //   LogInterceptor(requestBody: true, responseBody: true),
    // );
 
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await PrefHelper.getToken();
          print(' API Request to: ${options.path}');
          print(' Token for request: ${token ?? 'null'}');
         // print('token is : $token');
          print('options is : ${_dio.options.contentType}');



          if (token != null && token.isNotEmpty && token != 'guest') {
            options.headers['Authorization'] = 'Bearer $token';
            options.headers['Content-Type'] = 'application/json';
            print('the header is ${options.headers}');
            print('Authorization header added');
          } else {
            print('No authorization header added');
          }
          return handler.next(options);
        },
      ),
    );
  }
  
  Dio get dio => _dio;
}
