import 'package:image_picker/image_picker.dart';

class AddProductRequest {
  final String name;
  final int price;
  final int stock;
  final String category;
  final XFile image;

  AddProductRequest({
    required this.name,
    required this.price,
    required this.stock,
    required this.category,
    required this.image,
  });

  Map<String, String> toMap() {
    return {
      'name': name,
      'price': price.toString(),
      'stock': stock.toString(),
      'category': category,
    };
  }
}
