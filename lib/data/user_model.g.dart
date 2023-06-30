// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      DetailUser.fromJson(json['data'] as Map<String, dynamic>),
      json['errorCode'] as int,
      json['errorMsg'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };

DetailUser _$DetailUserFromJson(Map<String, dynamic> json) => DetailUser(
      (json['chapterTops'] as List<dynamic>).map((e) => e as String).toList(),
      (json['collectIds'] as List<dynamic>).map((e) => e as int).toList(),
      json['email'] as String,
      json['icon'] as String,
      json['id'] as int,
      json['password'] as String,
      json['token'] as String,
      json['type'] as int,
      json['username'] as String,
    );

Map<String, dynamic> _$DetailUserToJson(DetailUser instance) =>
    <String, dynamic>{
      'chapterTops': instance.chapterTops,
      'collectIds': instance.collectIds,
      'email': instance.email,
      'icon': instance.icon,
      'id': instance.id,
      'password': instance.password,
      'token': instance.token,
      'type': instance.type,
      'username': instance.username,
    };
