import 'dart:convert';

class UpdateProductsRequestModel {
  final String name;
  final int price;
  final int stock;
  final String category;

  UpdateProductsRequestModel({
    required this.name,
    required this.price,
    required this.stock,
    required this.category,
  });

  factory UpdateProductsRequestModel.fromJson(String str) =>
      UpdateProductsRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UpdateProductsRequestModel.fromMap(Map<String, dynamic> json) =>
      UpdateProductsRequestModel(
        name: json["name"],
        price: json["price"],
        stock: json["stock"],
        category: json["category"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "price": price,
        "stock": stock,
        "category": category,
      };
}
