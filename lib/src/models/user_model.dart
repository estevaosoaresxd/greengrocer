import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String? fullname;
  String? cpf;
  String? email;
  String? phone;
  String? password;
  String? id;
  String? token;

  UserModel({
    this.fullname,
    this.cpf,
    this.email,
    this.phone,
    this.password,
    this.id,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
