// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      fullname: json['fullname'] as String,
      cpf: json['cpf'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      password: json['password'] as dynamic,
      id: json['id'] as String,
      token: json['token'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'fullname': instance.fullname,
      'cpf': instance.cpf,
      'email': instance.email,
      'phone': instance.phone,
      'password': instance.password,
      'id': instance.id,
      'token': instance.token,
    };
