// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_application_crud/data/product/product_remote_datasource.dart';

import '../../../models/request/product/update_product_request_models.dart';
import '../../../models/response/product/update_product_response_models.dart';

part 'update_product_bloc.freezed.dart';
part 'update_product_event.dart';
part 'update_product_state.dart';

class UpdateProductBloc extends Bloc<UpdateProductEvent, UpdateProductState> {
  ProductRemoteDatasource productRemoteDatasource;
  UpdateProductBloc(
    this.productRemoteDatasource,
  ) : super(const _Initial()) {
    on<_UpdateProduct>((event, emit) async {
      emit(const _Loading());

      final response =
          await productRemoteDatasource.update(event.updateProduct, event.id);

      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_UpdateProductSuccess(r)),
      );
    });
  }
}
