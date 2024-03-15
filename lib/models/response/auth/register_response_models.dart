import 'dart:convert';

class RegisterResponseModel {
  final String token;
  final User user;

  RegisterResponseModel({
    required this.token,
    required this.user,
  });

  factory RegisterResponseModel.fromJson(String str) =>
      RegisterResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegisterResponseModel.fromMap(Map<String, dynamic> json) =>
      RegisterResponseModel(
        token: json["token"],
        user: User.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "token": token,
        "user": user.toMap(),
      };
}

class User {
  final String name;
  final String email;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  User({
    required this.name,
    required this.email,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}
