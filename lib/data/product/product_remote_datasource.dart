import 'package:dartz/dartz.dart';

import 'package:http/http.dart' as http;

import '../../constant/base_url.dart';
import '../../models/request/product/add_product_request_models.dart';
import '../../models/request/product/update_product_request_models.dart';
import '../../models/response/product/add_product_response_models.dart';
import '../../models/response/product/product_response_models.dart';
import '../../models/response/product/update_product_response_models.dart';
import '../auth/auth_local_remote_data_source.dart';

class ProductRemoteDatasource {
  Future<Either<String, ProductsResponseModel>> getAllProduct() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http
        .get(Uri.parse('${Variables.baseUrl}/api/products'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData.token}'
    });

    if (response.statusCode == 200) {
      return Right(ProductsResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, AddProductsResponseModel>> addProduct(
      AddProductRequest addProductRequest) async {
    final authData = await AuthLocalDatasource().getAuthData();

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${authData.token}',
    };
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${Variables.baseUrl}/api/products'),
    );

    request.fields.addAll(addProductRequest.toMap());

    request.files.add(await http.MultipartFile.fromPath(
        'image', addProductRequest.image.path));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    final String body = await response.stream.bytesToString();

    if (response.statusCode == 201) {
      return Right(AddProductsResponseModel.fromJson(body));
    } else {
      // return const Left('Add Product Gagal');
      return Left(body);
    }
  }

  Future<Either<String, String>> delete(int id) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http
        .delete(Uri.parse('${Variables.baseUrl}/api/products/$id'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData.token}'
    });

    if (response.statusCode == 200) {
      return const Right('Delete Success');
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, UpdateProductsResponseModel>> update(
      UpdateProductsRequestModel updateProductsRequestModel, int id) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.put(
      Uri.parse('${Variables.baseUrl}/api/products/$id'),
      body: updateProductsRequestModel.toJson(),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData.token}'
      },
    );

    if (response.statusCode == 200) {
      return Right(UpdateProductsResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }
}
