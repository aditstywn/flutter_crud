import 'dart:convert';

class UpdateProductsResponseModel {
  final bool success;
  final String message;
  final Data data;

  UpdateProductsResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory UpdateProductsResponseModel.fromJson(String str) =>
      UpdateProductsResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UpdateProductsResponseModel.fromMap(Map<String, dynamic> json) =>
      UpdateProductsResponseModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": data.toMap(),
      };
}

class Data {
  final int id;
  final String name;
  final int price;
  final int stock;
  final String category;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;

  Data({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    required this.category,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
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
