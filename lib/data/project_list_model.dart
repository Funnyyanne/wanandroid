import 'package:json_annotation/json_annotation.dart';
import 'package:wanandroid/data/root_model.dart';

part 'project_list_model.g.dart';

@JsonSerializable()
class ProjectListModel extends RootModel<ProjectListData> {
  ProjectListModel(ProjectListData data, int errorCode, String errorMsg)
      : super(data, errorCode, errorMsg);

  factory ProjectListModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectListModelFromJson(json);

  Map<String, dynamic> toJson() {
    return _$ProjectListModelToJson(this);
  }
}

@JsonSerializable()
class ProjectListData {
  bool over;
  int pageCount;
  int total;
  int curPage;
  int offset;
  int size;
  List<ProjectListDataData> datas;

  ProjectListData(this.over, this.pageCount, this.total, this.curPage,
      this.offset, this.size, this.datas,) {
  }

  factory ProjectListData.fromJson(Map<String, dynamic> json) =>
      _$ProjectListDataFromJson(json);

  Map<String, dynamic> toJson() {
    return _$ProjectListDataToJson(this);
  }
}

@JsonSerializable()
class ProjectListDataData {
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
  List<ProjectListDataDataTag> tags;
  String apkLink;
  String envelopePic;
  int chapterId;
  int superChapterId;
  int id;
  bool fresh;
  bool collect;
  int courseId;
  String desc;

  ProjectListDataData(
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

  factory ProjectListDataData.fromJson(Map<String, dynamic> json) =>
    _$ProjectListDataDataFromJson(json);

    // superChapterName = json['superChapterName'];
    // publishTime = json['publishTime'];
    // visible = json['visible'];
    // niceDate = json['niceDate'];
    // projectLink = json['projectLink'];
    // author = json['author'];
    // prefix = json['prefix'];
    // zan = json['zan'];
    // origin = json['origin'];
    // chapterName = json['chapterName'];
    // link = json['link'];
    // title = json['title'];
    // type = json['type'];
    // userId = json['userId'];
    // if (json['tags'] != null) {
    //   tags = new List<ProjectListDataDatasTag>();
    //   (json['tags'] as List).forEach((v) {
    //     tags.add(new ProjectListDataDatasTag.fromJson(v));
    //   });
    // }
    // apkLink = json['apkLink'];
    // envelopePic = json['envelopePic'];
    // chapterId = json['chapterId'];
    // superChapterId = json['superChapterId'];
    // id = json['id'];
    // fresh = json['fresh'];
    // collect = json['collect'];
    // courseId = json['courseId'];
    // desc = json['desc'];


  Map<String, dynamic> toJson() {
    return _$ProjectListDataDataToJson(this);}
    //
    // final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['superChapterName'] = this.superChapterName;
    // data['publishTime'] = this.publishTime;
    // data['visible'] = this.visible;
    // data['niceDate'] = this.niceDate;
    // data['projectLink'] = this.projectLink;
    // data['author'] = this.author;
    // data['prefix'] = this.prefix;
    // data['zan'] = this.zan;
    // data['origin'] = this.origin;
    // data['chapterName'] = this.chapterName;
    // data['link'] = this.link;
    // data['title'] = this.title;
    // data['type'] = this.type;
    // data['userId'] = this.userId;
    // if (this.tags != null) {
    //   data['tags'] = this.tags.map((v) => v.toJson()).toList();
    // }
    // data['apkLink'] = this.apkLink;
    // data['envelopePic'] = this.envelopePic;
    // data['chapterId'] = this.chapterId;
    // data['superChapterId'] = this.superChapterId;
    // data['id'] = this.id;
    // data['fresh'] = this.fresh;
    // data['collect'] = this.collect;
    // data['courseId'] = this.courseId;
    // data['desc'] = this.desc;
    // return data;

}

@JsonSerializable()
class ProjectListDataDataTag {
  String name;
  String url;

  ProjectListDataDataTag(this.name, this.url);

 factory ProjectListDataDataTag.fromJson(Map<String, dynamic> json) =>
     _$ProjectListDataDataTagFromJson(json);


  Map<String, dynamic> toJson() {
    return _$ProjectListDataDataTagToJson(this);
  }
}
