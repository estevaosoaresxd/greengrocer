// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) => ItemModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      unit: json['unit'] as String,
      price: (json['price'] as num).toDouble(),
      picture: json['picture'] as String,
      category:
          CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'unit': instance.unit,
      'price': instance.price,
      'picture': instance.picture,
      'category': instance.category,
    };
