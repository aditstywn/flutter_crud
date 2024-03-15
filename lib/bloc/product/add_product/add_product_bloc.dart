// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_application_crud/data/product/product_remote_datasource.dart';

import '../../../models/request/product/add_product_request_models.dart';
import '../../../models/response/product/add_product_response_models.dart';

part 'add_product_bloc.freezed.dart';
part 'add_product_event.dart';
part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  ProductRemoteDatasource productRemoteDatasource;
  AddProductBloc(
    this.productRemoteDatasource,
  ) : super(const _Initial()) {
    on<_AddProduct>((event, emit) async {
      emit(const _Loading());

      final response =
          await productRemoteDatasource.addProduct(event.addproduct);

      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_AddProductSuccess(r)),
      );
    });
  }
}
