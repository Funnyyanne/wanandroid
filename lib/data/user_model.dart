import 'package:json_annotation/json_annotation.dart';
import 'root_model.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends RootModel<DetailUser> {
  UserModel(DetailUser data, int errorCode, String errorMsg)
      : super(data, errorCode, errorMsg);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
@JsonSerializable()
class DetailUser {
  List<String> chapterTops;
  List<int> collectIds;
  String email;
  String icon;
  int id;
  String password;
  String token;
  int type;
  String username;

  DetailUser(this.chapterTops, this.collectIds, this.email, this.icon, this.id,
      this.password, this.token, this.type, this.username);

  factory DetailUser.fromJson(Map<String, dynamic> json) =>
      _$DetailUserFromJson(json);

  Map<String, dynamic> toJson() => _$DetailUserToJson(this);
}
