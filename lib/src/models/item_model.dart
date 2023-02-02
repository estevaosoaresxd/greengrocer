import 'package:greengrocer/src/models/category_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_model.g.dart';

@JsonSerializable()
class ItemModel {
  String id;
  String title;
  String description;
  String unit;
  double price;
  String picture;
  CategoryModel category;

  ItemModel({
    required this.id,
    required this.title,
    required this.description,
    required this.unit,
    required this.price,
    required this.picture,
    required this.category,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);

  @override
  String toString() {
    return 'ItemModel(id: $id, title: $title, description: $description, unit: $unit, price: $price, picture: $picture, category: $category)';
  }
}
