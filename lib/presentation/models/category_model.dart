// ignore_for_file: public_member_api_docs, sort_constructors_first
class CategoryModel {
  final String name;
  final String value;
  CategoryModel({
    required this.name,
    required this.value,
  });

  @override
  String toString() => 'CategoryModel(name: $name, value: $value)';
}
