import 'package:wanandroid/data/root_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'tree_model.g.dart';


@JsonSerializable()
class TreeModel extends RootModel<List<TreeList>> {
  TreeModel(List<TreeList> data, int errorCode, String errorMsg)
      : super(data, errorCode, errorMsg);

  factory TreeModel.fromJson(Map<String, dynamic> json) =>
      _$TreeModelFromJson(json);
  Map<String, dynamic> toJson() => _$TreeModelToJson(this);
}

@JsonSerializable()
class TreeList {
  int visible;
  List<TreeDatachild> children;
  String name;
  bool userControlSetTop;
  int id;
  int courseId;
  int parentChapterId;
  int order;
  bool isExpanded =false; //标识是否初始化

  TreeList(
      this.visible,
      this.children,
      this.name, this.userControlSetTop,
      this.id,
      this.courseId,
      this.parentChapterId,
      this.order,
     );

  factory TreeList.fromJson(Map<String, dynamic> json) =>
      _$TreeListFromJson(json);

  Map<String, dynamic> toJson() => _$TreeListToJson(this);
}

@JsonSerializable()
class TreeDatachild {
  int visible;
  List<dynamic> children;
  String name;
  bool userControlSetTop;
  int id;
  int courseId;
  int parentChapterId;
  int order;

  TreeDatachild(this.visible, this.children, this.name, this.userControlSetTop,
      this.id, this.courseId, this.parentChapterId, this.order);

  factory TreeDatachild.fromJson(Map<String, dynamic> json) =>
      _$TreeDatachildFromJson(json);

  Map<String, dynamic> toJson() => _$TreeDatachildToJson(this);
}
