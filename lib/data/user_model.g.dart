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
      chapterTops: (json['chapterTops'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      collectIds:
          (json['collectIds'] as List<dynamic>?)?.map((e) => e as int).toList(),
      email: json['email'] as String? ?? "",
      icon: json['icon'] as String? ?? "",
      id: json['id'] as int,
      password: json['password'] as String? ?? "",
      token: json['token'] as String? ?? "",
      type: json['type'] as int? ?? 0,
      username: json['username'] as String?,
      admin: json['admin'] as bool? ?? false,
      coinCount: json['coinCount'] as int? ?? 0,
      nickname: json['nickname'] as String,
      publicName: json['publicName'] as String,
    );

Map<String, dynamic> _$DetailUserToJson(DetailUser instance) =>
    <String, dynamic>{
      'chapterTops': instance.chapterTops,
      'collectIds': instance.collectIds,
      'coinCount': instance.coinCount,
      'email': instance.email,
      'icon': instance.icon,
      'password': instance.password,
      'id': instance.id,
      'token': instance.token,
      'admin': instance.admin,
      'username': instance.username,
      'nickname': instance.nickname,
      'type': instance.type,
      'publicName': instance.publicName,
    };
