// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerModel _$BannerModelFromJson(Map<String, dynamic> json) => BannerModel(
      BannerData.fromJson(json['data'] as Map<String, dynamic>),
      json['errorCode'] as int,
      json['errorMsg'] as String,
    );

Map<String, dynamic> _$BannerModelToJson(BannerModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };

BannerData _$BannerDataFromJson(Map<String, dynamic> json) => BannerData(
      json['imagePath'] as String,
      json['id'] as int,
      json['isVisible'] as int,
      json['title'] as String,
      json['type'] as int,
      json['url'] as String,
      json['desc'] as String,
      json['order'] as int,
    );

Map<String, dynamic> _$BannerDataToJson(BannerData instance) =>
    <String, dynamic>{
      'imagePath': instance.imagePath,
      'id': instance.id,
      'isVisible': instance.isVisible,
      'title': instance.title,
      'type': instance.type,
      'url': instance.url,
      'desc': instance.desc,
      'order': instance.order,
    };
