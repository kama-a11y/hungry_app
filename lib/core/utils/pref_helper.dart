import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper {

  static const String _tokenKey = 'auth_token';

  static Future<void> saveToken(String token)async{
    final prefs = await SharedPreferences.getInstance();
   await prefs.setString(_tokenKey, token);
  }

static Future<String?> getToken()async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
     
  }    

  static Future<void> clearToken()async{
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_tokenKey);
  }

   // ================= GUEST =================

  static Future<void> setGuestMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isGuest', value);
  }

  static Future<bool> isGuestMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isGuest') ?? false;
  }

  static Future<void> clearGuestMode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isGuest');
  }
  
}