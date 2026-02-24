import 'package:dio/dio.dart';
import 'package:hungryapp/core/network/api_error.dart';
import 'package:hungryapp/core/network/api_exceptions.dart';
import 'package:hungryapp/core/network/api_service.dart';
import 'package:hungryapp/core/utils/pref_helper.dart';
import 'package:hungryapp/feature/auth/data/user_model.dart';
// import 'package:huungry/core/network/api_error.dart';
// import 'package:huungry/core/network/api_exceptions.dart';
// import 'package:huungry/core/network/api_service.dart';
// import 'package:huungry/core/utils/pref_helper.dart';
// import 'package:huungry/features/auth/data/user_model.dart';

class AuthRepo {
  ApiService apiService = ApiService();
  bool isGuest = false;

  /// Login
  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await apiService.post('/login', {
        'email': email,
        'password': password,
      });
      if (response is ApiError) {
        throw response;
      }

      if (response is Map<String, dynamic>) {
        final msg = response['message'];
        final code = response['code'];
        final data = response['data'];

        print('📡 Login response - code: $code, data: $data');

        if (code != 200 && code != 201) {
          throw ApiError(message: msg ?? 'Unknown error');
        }

        final user = UserModel.fromJson(data);
        print('🔐 Login successful - User token: ${user.token ?? 'null'}');

        if (user.token != null) {
          await PrefHelper.saveToken(user.token!);
          print('💾 Token saved to storage: ${user.token}');
        } else {
          print('⚠️ No token received from server!');
        }

        isGuest = false;
        return user;
      } else {
        throw ApiError(message: 'UnExpected Error From Server');
      }
    } on DioError catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  /// Signup
  Future<UserModel?> signup(String name, String email, String password) async {
    try {
      final response = await apiService.post('/register', {
        'name': name,
        'password': password,
        'email': email,
      });
      if (response is ApiError) {
        throw response;
      }

      if (response is Map<String, dynamic>) {
        final msg = response['message'];
        final code = response['code'];
        final coder = int.tryParse(code);
        final data = response['data'];

        if (coder != 200 && coder != 201) {
          throw ApiError(message: msg ?? 'Unknown error');
        }

        /// condtion assement
        final user = UserModel.fromJson(data);
        if (user.token != null) {
          await PrefHelper.saveToken(user.token!);
        }
        isGuest = false;
        return user;  
      } else {
        throw ApiError(message: 'UnExpected Error From Server');
      }
    } on DioError catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  /// Get Profile data
Future<UserModel> getProfileData()async{
  try {
    final Response = await apiService.get('/profile');
    return UserModel.fromJson(Response["data"]);
  } on DioError catch(e) {
    throw ApiExceptions.handleError(e);
  }catch(e){
    throw ApiError(message: e.toString());
  }
}

  /// Update Profile data
Future<UserModel> updateProfileData({required String name , String? imagePath,required String email,required String address,String? visa})async{
  try {
    final formData = FormData.fromMap({
      'name': name,
        'email': email,
        if(imagePath != null && imagePath.isNotEmpty)
        'image':await MultipartFile.fromFile(imagePath,filename: 'profile.jpg'),
        'address':address,
        if(visa != null && visa.isNotEmpty)
        'Visa':visa,
    });
    final Response = await apiService.post('/update-profile',formData);
    if (Response is ApiError) {
        throw Response;
      }
      if (Response is Map<String, dynamic>) {
        final msg = Response['message'];
        final code = Response['code'];
        final coder = int.tryParse(code);
        final data = Response['data'];

        if (coder != 200 && coder != 201) {
          throw ApiError(message: msg ?? 'Unknown error');
        }}
        
    return UserModel.fromJson(Response["data"]);
  } on DioError catch(e) {
    throw ApiExceptions.handleError(e);
  }catch(e){
    throw ApiError(message: e.toString());
  }
}

}
