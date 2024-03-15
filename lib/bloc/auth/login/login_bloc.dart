// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_application_crud/data/auth/auth_remote_data_source.dart';

import '../../../models/request/auth/login_request_models.dart';
import '../../../models/response/auth/login_response_models.dart';

part 'login_bloc.freezed.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthRemoteDatasource authRemoteDatasource;
  LoginBloc(
    this.authRemoteDatasource,
  ) : super(const _Initial()) {
    on<_Login>(
      (event, emit) async {
        emit(const _Loading());
        final response =
            await authRemoteDatasource.login(event.loginRequestModel);

        response.fold(
          (l) => emit(_Error(l)),
          (r) => emit(_LoginSuccess(r)),
        );
      },
    );
  }
}
