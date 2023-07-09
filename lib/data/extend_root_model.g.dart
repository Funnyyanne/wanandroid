// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extend_root_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtendRootModel _$ExtendRootModelFromJson(Map<String, dynamic> json) =>
    ExtendRootModel(
      json['data'],
      json['errorCode'] as int,
      json['errorMsg'] as String,
    );

Map<String, dynamic> _$ExtendRootModelToJson(ExtendRootModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };
