import 'dart:convert';

class AddProductsResponseModel {
  final bool success;
  final String message;
  final Data data;

  AddProductsResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AddProductsResponseModel.fromJson(String str) =>
      AddProductsResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddProductsResponseModel.fromMap(Map<String, dynamic> json) =>
      AddProductsResponseModel(
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
  final String name;
  final String stock;
  final String price;
  final String category;
  final String image;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  Data({
    required this.name,
    required this.stock,
    required this.price,
    required this.category,
    required this.image,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        name: json["name"],
        stock: json["stock"],
        price: json["price"],
        category: json["category"],
        image: json["image"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "stock": stock,
        "price": price,
        "category": category,
        "image": image,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}
