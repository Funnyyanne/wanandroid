// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectListModel _$ProjectListModelFromJson(Map<String, dynamic> json) =>
    ProjectListModel(
      ProjectListData.fromJson(json['data'] as Map<String, dynamic>),
      json['errorCode'] as int,
      json['errorMsg'] as String,
    );

Map<String, dynamic> _$ProjectListModelToJson(ProjectListModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };

ProjectListData _$ProjectListDataFromJson(Map<String, dynamic> json) =>
    ProjectListData(
      json['over'] as bool,
      json['pageCount'] as int,
      json['total'] as int,
      json['curPage'] as int,
      json['offset'] as int,
      json['size'] as int,
      (json['datas'] as List<dynamic>)
          .map((e) => ProjectListDataData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProjectListDataToJson(ProjectListData instance) =>
    <String, dynamic>{
      'over': instance.over,
      'pageCount': instance.pageCount,
      'total': instance.total,
      'curPage': instance.curPage,
      'offset': instance.offset,
      'size': instance.size,
      'datas': instance.datas,
    };

ProjectListDataData _$ProjectListDataDataFromJson(Map<String, dynamic> json) =>
    ProjectListDataData(
      json['superChapterName'] as String,
      json['publishTime'] as int,
      json['visible'] as int,
      json['niceDate'] as String,
      json['projectLink'] as String,
      json['author'] as String,
      json['prefix'] as String,
      json['zan'] as int,
      json['origin'] as String,
      json['chapterName'] as String,
      json['link'] as String,
      json['title'] as String,
      json['type'] as int,
      json['userId'] as int,
      (json['tags'] as List<dynamic>)
          .map(
              (e) => ProjectListDataDataTag.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['apkLink'] as String,
      json['envelopePic'] as String,
      json['chapterId'] as int,
      json['superChapterId'] as int,
      json['id'] as int,
      json['fresh'] as bool,
      json['collect'] as bool,
      json['courseId'] as int,
      json['desc'] as String,
    );

Map<String, dynamic> _$ProjectListDataDataToJson(
        ProjectListDataData instance) =>
    <String, dynamic>{
      'superChapterName': instance.superChapterName,
      'publishTime': instance.publishTime,
      'visible': instance.visible,
      'niceDate': instance.niceDate,
      'projectLink': instance.projectLink,
      'author': instance.author,
      'prefix': instance.prefix,
      'zan': instance.zan,
      'origin': instance.origin,
      'chapterName': instance.chapterName,
      'link': instance.link,
      'title': instance.title,
      'type': instance.type,
      'userId': instance.userId,
      'tags': instance.tags,
      'apkLink': instance.apkLink,
      'envelopePic': instance.envelopePic,
      'chapterId': instance.chapterId,
      'superChapterId': instance.superChapterId,
      'id': instance.id,
      'fresh': instance.fresh,
      'collect': instance.collect,
      'courseId': instance.courseId,
      'desc': instance.desc,
    };

ProjectListDataDataTag _$ProjectListDataDataTagFromJson(
        Map<String, dynamic> json) =>
    ProjectListDataDataTag(
      json['name'] as String,
      json['url'] as String,
    );

Map<String, dynamic> _$ProjectListDataDataTagToJson(
        ProjectListDataDataTag instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };
