part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.loading() = _Loading;
  const factory LoginState.loginSuccess(LoginResponseModel loginResponseModel) =
      _LoginSuccess;
  const factory LoginState.error(String message) = _Error;
}
