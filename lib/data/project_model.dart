import 'package:wanandroid/data/root_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project_model.g.dart';

@JsonSerializable()
class ProjectModel extends RootModel<List<ProjectDataModel>> {
  ProjectModel(List<ProjectDataModel> data, int errorCode, String errorMsg)
      : super(data, errorCode, errorMsg);

  factory ProjectModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectModelFromJson(json);

  Map<String, dynamic> toJson() {
    return _$ProjectModelToJson(this);
  }
}

@JsonSerializable()
class ProjectDataModel {
  List<String> children;
  int courseId;
  int id;
  late String name;
  int order;
  int parentChapterId;
  int visible;
  // String url;

  ProjectDataModel(this.children, this.courseId, this.id, String name,
      this.order, this.parentChapterId, this.visible) {
    this.name = name.replaceAll("&amp;", "&");
    // url = "";
  }

  factory ProjectDataModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectDataModelFromJson(json);

  Map<String, dynamic> toJson() {
    return _$ProjectDataModelToJson(this);
  }
}
