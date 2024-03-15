// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_application_crud/data/auth/auth_remote_data_source.dart';

import '../../../models/request/auth/register_request_models.dart';
import '../../../models/response/auth/register_response_models.dart';

part 'register_bloc.freezed.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  AuthRemoteDatasource authRemoteDatasource;
  RegisterBloc(
    this.authRemoteDatasource,
  ) : super(const _Initial()) {
    on<_Register>(
      (event, emit) async {
        emit(const _Loading());
        final response =
            await authRemoteDatasource.register(event.registerRequestModel);

        response.fold(
          (l) => emit(_Error(l)),
          (r) => emit(_RegisterSuccess(r)),
        );
      },
    );
  }
}
