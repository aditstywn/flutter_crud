// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_application_crud/data/auth/auth_remote_data_source.dart';

part 'logout_bloc.freezed.dart';
part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  AuthRemoteDatasource authRemoteDatasource;
  LogoutBloc(
    this.authRemoteDatasource,
  ) : super(const _Initial()) {
    on<_Logout>(
      (event, emit) async {
        emit(const _Loading());
        final response = await authRemoteDatasource.logout();

        response.fold(
          (l) => emit(_Error(l)),
          (r) => emit(_logoutSuccess(r)),
        );
      },
    );
  }
}
