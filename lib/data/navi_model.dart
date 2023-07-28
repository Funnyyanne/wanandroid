import 'package:wanandroid/data/root_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'navi_model.g.dart';

@JsonSerializable()
class NaviModel extends RootModel<List<NaviData>> {
  NaviModel(List<NaviData> data, int errorCode, String errorMsg)
      : super(data, errorCode, errorMsg);

  factory NaviModel.fromJson(Map<String, dynamic> json) =>
      _$NaviModelFromJson(json);

  Map<String, dynamic> toJson() {
    return _$NaviModelToJson(this);
  }
}

@JsonSerializable()
class NaviData {
  String name;
  List<NaviDataArticle> articles;
  int cid;

  NaviData(this.articles, this.name, this.cid);

  factory NaviData.fromJson(Map<String, dynamic> json) =>
      _$NaviDataFromJson(json);

  Map<String, dynamic> toJson() {
    return _$NaviDataToJson(this);
  }
}

@JsonSerializable()
class NaviDataArticle {
  String superChapterName;
  int publishTime;
  int visible;
  String niceDate;
  String projectLink;
  String author;
  String prefix;
  int zan;
  String origin;
  String chapterName;
  String link;
  String title;
  int type;
  int userId;
  List<dynamic> tags;
  String apkLink;
  String envelopePic;
  int chapterId;
  int superChapterId;
  int id;
  bool fresh;
  bool collect;
  int courseId;
  String desc;

  NaviDataArticle(
      this.superChapterName,
      this.publishTime,
      this.visible,
      this.niceDate,
      this.projectLink,
      this.author,
      this.prefix,
      this.zan,
      this.origin,
      this.chapterName,
      this.link,
      this.title,
      this.type,
      this.userId,
      this.tags,
      this.apkLink,
      this.envelopePic,
      this.chapterId,
      this.superChapterId,
      this.id,
      this.fresh,
      this.collect,
      this.courseId,
      this.desc);

  factory NaviDataArticle.fromJson(Map<String, dynamic> json) =>
      _$NaviDataArticleFromJson(json);

  Map<String, dynamic> toJson() {
    return _$NaviDataArticleToJson(this);
  }
}
