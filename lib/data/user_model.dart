import 'package:json_annotation/json_annotation.dart';
import 'root_model.dart';

part 'user_model.g.dart';

/***
 * {
    "admin": false,
    "chapterTops": [],
    "coinCount": 658,
    "collectIds": [
    13775,
    25098
    ],
    "email": "",
    "icon": "",
    "id": 129339,
    "nickname": "annelo",
    "password": "",
    "publicName": "annelo",
    "token": "",
    "type": 0,
    "username": "annelo"
    }
 */
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
  List<String>? chapterTops;
  List<int>? collectIds;
  int coinCount;
  String? email;
  String? icon;
  String? password;
  int id;
  String? token;
  bool? admin;
  String? username;
  String nickname;
  int type;
  String publicName;

  DetailUser(
      {this.chapterTops,
      this.collectIds,
      this.email = "",
      this.icon = "",
      required this.id,
      this.password = "",
      this.token="",
      this.type = 0,
      required this.username,
      this.admin = false,
       this.coinCount = 0,
      required this.nickname,
      required this.publicName});

  factory DetailUser.fromJson(Map<String, dynamic> json) =>
      _$DetailUserFromJson(json);

  Map<String, dynamic> toJson() => _$DetailUserToJson(this);
}
