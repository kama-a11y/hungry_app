//import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:hungryapp/core/network/api_error.dart';
import 'package:hungryapp/core/network/api_exceptions.dart';
//import 'package:hungryapp/core/network/api_exceptions.dart';
import 'package:hungryapp/core/network/api_service.dart';
import 'package:hungryapp/core/utils/pref_helper.dart';
import 'package:hungryapp/feature/auth/data/user_model.dart';

class AuthRepo {
  ApiService apiService = ApiService();

  ///login
    Future<UserModel> login(String email, String password) async {
    try {
      final Response = await apiService.post('/login', {
        "email": email,
        "password": password,
      });
      if(Response is ApiError){
        throw Response;
      }
      if(Response is Map<String,dynamic>){
       final msg = Response[ "message"];
       final code = Response[ "code"];
       final data = Response[  "data"];
       if(code != 200 || data == null){
      throw ApiError(message: msg);
       }
        final user = UserModel.fromJson(Response["data"]);
      if (user.token != null) {
        await PrefHelper.saveToken(user.token!);
      }
      return user;
      }else{
        throw ApiError(message: 'un expected');
      }
     
    } on DioException catch(e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
    
  throw ApiError(message: e.toString() );
}
  }

  ///register
  Future<UserModel> Signup (String name , String email, String password) async {
    try {
      final Response = await apiService.post('/register', {
        "name":name,
        "email": email,
        "password": password,
      });
      final user = UserModel.fromJson(Response["data"]);
      if (user.token != null) {
        await PrefHelper.saveToken(user.token!);
      }
      return user;
    } on ApiError {  
      rethrow;
    } catch (e) {
  throw ApiError(message: 'Unexpected error occurred');
}
  }
  ///
}
