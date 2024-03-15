import 'package:dartz/dartz.dart';

import 'package:http/http.dart' as http;

import '../../constant/base_url.dart';
import '../../models/request/auth/login_request_models.dart';
import '../../models/request/auth/register_request_models.dart';
import '../../models/response/auth/login_response_models.dart';
import '../../models/response/auth/register_response_models.dart';
import 'auth_local_remote_data_source.dart';

class AuthRemoteDatasource {
  Future<Either<String, LoginResponseModel>> login(
      LoginRequestModel loginRequestModel) async {
    final response = await http.post(
        Uri.parse('${Variables.baseUrl}/api/login'),
        body: loginRequestModel.toJson(),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });

    if (response.statusCode == 200) {
      return Right(LoginResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, RegisterResponseModel>> register(
      RegisterRequestModel registerRequestModel) async {
    final response = await http.post(
        Uri.parse('${Variables.baseUrl}/api/register'),
        body: registerRequestModel.toJson(),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });

    if (response.statusCode == 200) {
      return Right(RegisterResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response =
        await http.post(Uri.parse('${Variables.baseUrl}/api/logout'), headers: {
      'Authorization': 'Bearer ${authData.token}',
    });

    if (response.statusCode == 200) {
      return Right(response.body);
    } else {
      return Left(response.body);
    }
  }
}
