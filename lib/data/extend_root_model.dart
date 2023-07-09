import 'package:json_annotation/json_annotation.dart';
import 'package:wanandroid/data/root_model.dart';

part 'extend_root_model.g.dart';

@JsonSerializable()
class ExtendRootModel extends RootModel<dynamic> {
  ExtendRootModel(dynamic data, int errorCode, String errorMsg)
      : super(data, errorCode, errorMsg);

  factory ExtendRootModel.fromJson(Map<String, dynamic> json) =>
      _$ExtendRootModelFromJson(json);

  toJson() => _$ExtendRootModelToJson(this);
}
