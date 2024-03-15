// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_application_crud/data/product/product_remote_datasource.dart';

part 'delete_product_bloc.freezed.dart';
part 'delete_product_event.dart';
part 'delete_product_state.dart';

class DeleteProductBloc extends Bloc<DeleteProductEvent, DeleteProductState> {
  ProductRemoteDatasource productRemoteDatasource;
  DeleteProductBloc(
    this.productRemoteDatasource,
  ) : super(const _Initial()) {
    on<_DeleteProduct>((event, emit) async {
      emit(const _Loading());

      final response = await productRemoteDatasource.delete(event.id);

      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_DeleteSuccess(r)),
      );
    });
  }
}
