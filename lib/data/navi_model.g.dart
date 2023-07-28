// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navi_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NaviModel _$NaviModelFromJson(Map<String, dynamic> json) => NaviModel(
      (json['data'] as List<dynamic>)
          .map((e) => NaviData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['errorCode'] as int,
      json['errorMsg'] as String,
    );

Map<String, dynamic> _$NaviModelToJson(NaviModel instance) => <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };

NaviData _$NaviDataFromJson(Map<String, dynamic> json) => NaviData(
      (json['articles'] as List<dynamic>)
          .map((e) => NaviDataArticle.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['name'] as String,
      json['cid'] as int,
    );

Map<String, dynamic> _$NaviDataToJson(NaviData instance) => <String, dynamic>{
      'name': instance.name,
      'articles': instance.articles,
      'cid': instance.cid,
    };

NaviDataArticle _$NaviDataArticleFromJson(Map<String, dynamic> json) =>
    NaviDataArticle(
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
      json['tags'] as List<dynamic>,
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

Map<String, dynamic> _$NaviDataArticleToJson(NaviDataArticle instance) =>
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
