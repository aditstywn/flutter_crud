import 'package:flutter_application_crud/models/response/auth/register_response_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/response/auth/login_response_models.dart';

class AuthLocalDatasource {
  Future<void> saveAuthData(LoginResponseModel loginResponseModel) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('auth_data', loginResponseModel.toJson());
  }

  Future<void> saveAuthDataRegister(
      RegisterResponseModel registerResponseModel) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('auth_data', registerResponseModel.toJson());
  }

  Future<void> removeAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_data');
  }

  Future<LoginResponseModel> getAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    final authData = prefs.getString('auth_data');

    return LoginResponseModel.fromJson(authData!);
  }

  Future<bool> isAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final authData = prefs.getString('auth_data');

    return authData != null;
  }
}
