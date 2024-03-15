import 'dart:convert';

class ProductsResponseModel {
  final bool success;
  final String message;
  final List<Product> data;

  ProductsResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ProductsResponseModel.fromJson(String str) =>
      ProductsResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductsResponseModel.fromMap(Map<String, dynamic> json) =>
      ProductsResponseModel(
        success: json["success"],
        message: json["message"],
        data: List<Product>.from(json["data"].map((x) => Product.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Product {
  final int id;
  final String name;
  final int price;
  final int stock;
  final String category;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    required this.category,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        stock: json["stock"],
        category: json["category"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "price": price,
        "stock": stock,
        "category": category,
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
