import 'root_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article_model.g.dart';


@JsonSerializable()
class ArticleModel extends RootModel<ArticleList> {
  ArticleModel(ArticleList data, int errorCode, String errorMsg)
      : super(data, errorCode, errorMsg);

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);
}

@JsonSerializable()
class ArticleList {
  bool over;
  int pageCount;
  int total;
  int curPage;
  int offset;
  int size;
  List<ArticleData> datas;

  ArticleList(this.over, this.pageCount, this.total, this.curPage, this.offset,
      this.size, this.datas);


  factory ArticleList.fromJson(Map<String, dynamic> json) =>
      _$ArticleListFromJson(json);

}

@JsonSerializable()
class ArticleData {
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
  List<ArticleTagModel> tags;
  String apkLink;
  String envelopePic;
  int chapterId;
  int superChapterId;
  int id;
  // int originId;
  bool fresh;
  bool collect;
  int courseId;
  String desc;

  ArticleData(this.superChapterName,
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
      // this.originId,
      this.fresh,
      this.collect,
      this.courseId,
      this.desc);

  factory ArticleData.fromJson(Map<String, dynamic> json) =>
      _$ArticleDataFromJson(json);

  Map<String, dynamic> toJson() {
    return _$ArticleDataToJson(this);
  }

}


@JsonSerializable()
class ArticleTagModel {
  String name;
  String url;

  ArticleTagModel(this.name, this.url);

  factory ArticleTagModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleTagModelFromJson(json);
}

