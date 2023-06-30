import 'package:json_annotation/json_annotation.dart';
import 'root_model.dart';
part  'banner_model.g.dart';

@JsonSerializable()
class BannerModel extends RootModel<BannerData> {
  BannerModel(BannerData data, int errorCode, String errorMsg)
      : super(data, errorCode, errorMsg);

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);

  Map<String, dynamic> toJson() => _$BannerModelToJson(this);

}

@JsonSerializable()
class BannerData {
  String imagePath;
  int id;
  int isVisible;
  String title;
  int type;
  String url;
  String desc;
  int order;

  BannerData(this.imagePath, this.id, this.isVisible, this.title, this.type, this.url, this.desc, this.order);
  factory BannerData.fromJson(Map<String, dynamic> json) =>
      _$BannerDataFromJson(json);

  Map<String, dynamic> toJson() => _$BannerDataToJson(this);
}


