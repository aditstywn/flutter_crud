// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_application_crud/data/product/product_remote_datasource.dart';

import '../../../models/response/product/product_response_models.dart';

part 'get_product_bloc.freezed.dart';
part 'get_product_event.dart';
part 'get_product_state.dart';

class GetProductBloc extends Bloc<GetProductEvent, GetProductState> {
  ProductRemoteDatasource productRemoteDatasource;
  GetProductBloc(
    this.productRemoteDatasource,
  ) : super(const _Initial()) {
    on<_GetListProduct>((event, emit) async {
      emit(const _Loading());

      final response = await productRemoteDatasource.getAllProduct();

      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_GetListProductSuccess(r)),
      );
    });
  }
}
