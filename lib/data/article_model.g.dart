// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleModel _$ArticleModelFromJson(Map<String, dynamic> json) => ArticleModel(
      ArticleList.fromJson(json['data'] as Map<String, dynamic>),
      json['errorCode'] as int,
      json['errorMsg'] as String,
    );

Map<String, dynamic> _$ArticleModelToJson(ArticleModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };

ArticleList _$ArticleListFromJson(Map<String, dynamic> json) => ArticleList(
      json['over'] as bool,
      json['pageCount'] as int,
      json['total'] as int,
      json['curPage'] as int,
      json['offset'] as int,
      json['size'] as int,
      (json['datas'] as List<dynamic>)
          .map((e) => ArticleData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ArticleListToJson(ArticleList instance) =>
    <String, dynamic>{
      'over': instance.over,
      'pageCount': instance.pageCount,
      'total': instance.total,
      'curPage': instance.curPage,
      'offset': instance.offset,
      'size': instance.size,
      'datas': instance.datas,
    };

ArticleData _$ArticleDataFromJson(Map<String, dynamic> json) => ArticleData(
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
          .map((e) => ArticleTagModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['apkLink'] as String,
      json['envelopePic'] as String,
      json['chapterId'] as int,
      json['superChapterId'] as int,
      json['id'] as int,
      // json['originId'] as int,
      json['fresh'] as bool,
      json['collect'] as bool,
      json['courseId'] as int,
      json['desc'] as String,
    );

Map<String, dynamic> _$ArticleDataToJson(ArticleData instance) =>
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
      // 'originId': instance.originId,
      'fresh': instance.fresh,
      'collect': instance.collect,
      'courseId': instance.courseId,
      'desc': instance.desc,
    };

ArticleTagModel _$ArticleTagModelFromJson(Map<String, dynamic> json) =>
    ArticleTagModel(
      json['name'] as String,
      json['url'] as String,
    );

Map<String, dynamic> _$ArticleTagModelToJson(ArticleTagModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };
