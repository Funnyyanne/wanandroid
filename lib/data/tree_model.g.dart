// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tree_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreeModel _$TreeModelFromJson(Map<String, dynamic> json) => TreeModel(
      (json['data'] as List<dynamic>)
          .map((e) => TreeList.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['errorCode'] as int,
      json['errorMsg'] as String,
    );

Map<String, dynamic> _$TreeModelToJson(TreeModel instance) => <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };

TreeList _$TreeListFromJson(Map<String, dynamic> json) => TreeList(
      json['visible'] as int,
      (json['children'] as List<dynamic>)
          .map((e) => TreeDatachild.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['name'] as String,
      json['userControlSetTop'] as bool,
      json['id'] as int,
      json['courseId'] as int,
      json['parentChapterId'] as int,
      json['order'] as int,
);

Map<String, dynamic> _$TreeListToJson(TreeList instance) => <String, dynamic>{
      'visible': instance.visible,
      'children': instance.children,
      'name': instance.name,
      'userControlSetTop': instance.userControlSetTop,
      'id': instance.id,
      'courseId': instance.courseId,
      'parentChapterId': instance.parentChapterId,
      'order': instance.order,
      'isExpanded': instance.isExpanded,
    };

TreeDatachild _$TreeDatachildFromJson(Map<String, dynamic> json) =>
    TreeDatachild(
      json['visible'] as int,
      json['children'] as List<dynamic>,
      json['name'] as String,
      json['userControlSetTop'] as bool,
      json['id'] as int,
      json['courseId'] as int,
      json['parentChapterId'] as int,
      json['order'] as int,
    );

Map<String, dynamic> _$TreeDatachildToJson(TreeDatachild instance) =>
    <String, dynamic>{
      'visible': instance.visible,
      'children': instance.children,
      'name': instance.name,
      'userControlSetTop': instance.userControlSetTop,
      'id': instance.id,
      'courseId': instance.courseId,
      'parentChapterId': instance.parentChapterId,
      'order': instance.order,
    };
