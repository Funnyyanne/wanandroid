import 'package:shared_preferences/shared_preferences.dart';

import '../data/user_model.dart';

class Sp {
  //用户信息字段
  static const String SP_USERNAME = 'username';
  static const String SP_PASSWORD = 'password';

  static const String SP_IS_LOGIN = "isLogin";
  static const String SP_ADMIN = "admin";
  static const String SP_CHAPTERTOPS = "chapterTops";
  static const String SP_COLLECTIDS = "collectIds";
  static const String SP_EMAIL = "email";
  static const String SP_ICON = "icon";
  static const String SP_ID = "id";
  static const String SP_NICKNAME = "nickname";
  static const String SP_PUBLICNAME = "publicName";
  static const String SP_TOKEN = "token";
  static const String SP_TYPE = "type";
  static const String SP_COOKIE = "Cookie";

  //是否登录
  static Future<bool> isLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool? isLogin = sp.getBool(SP_IS_LOGIN);
    return isLogin != null && isLogin;
  }

  static Future<void> saveLoginInfo(
      DetailUser loginData, String username, String password) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp
      ..setString(SP_USERNAME, username)
      ..setString(SP_PASSWORD, password)
      ..setBool(SP_ADMIN, loginData.admin!)
      ..setString(SP_EMAIL, loginData.email!)
      ..setString(SP_ICON, loginData.icon!)
      ..setInt(SP_ID, loginData.id)
      ..setString(SP_PASSWORD, loginData.password!)
      ..setString(SP_TOKEN, loginData.token!)
      ..setInt(SP_TYPE, loginData.type)
      ..setString(SP_USERNAME, loginData.username!)
      ..setString(
          SP_COOKIE, "loginUserName=$username;loginUserPassword=$password")
      ..setBool(SP_IS_LOGIN, true);
  }

  static Future<void> clearLoginInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp
      ..setString(SP_USERNAME, '')
      ..setString(SP_PASSWORD, '')
      ..setBool(SP_ADMIN, false)
      ..setInt(SP_ID, -1)
      ..setInt(SP_TYPE, -1)
      ..setString(SP_TOKEN, '')
      ..setString(SP_COOKIE, "")
      ..setStringList(SP_CHAPTERTOPS, [])
      ..setStringList(SP_COLLECTIDS, [])
      ..setString(SP_EMAIL, '')
      ..setString(SP_ICON, "")
      ..setString(SP_NICKNAME, '')
      ..setString(SP_PUBLICNAME, '')
      ..setBool(SP_IS_LOGIN, false);
  }

  //获取用户信息
  static Future<DetailUser?> getUserInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool? isLogin = sp.getBool(SP_IS_LOGIN);
    if (isLogin == null || !isLogin) {
      return null;
    }
    DetailUser user = DetailUser(
        id: sp.getInt(SP_ID)!,
        username: sp.getString(SP_USERNAME),
        nickname: sp.getString(SP_NICKNAME)!,
        publicName: sp.getString(SP_PUBLICNAME)!,
        admin: sp.getBool(SP_ADMIN),
        email: sp.getString(SP_EMAIL),
        icon: sp.getString(SP_ICON),
        token: sp.getString(SP_TOKEN),
        type: sp.getInt(SP_TYPE)!,
        password: sp.getString(SP_PASSWORD),
        coinCount: 0);

    return user;
  }

  static Future<Map<String,String>> geHeader() async{
    Map<String, String> headerMap = Map();
    SharedPreferences sp = await SharedPreferences.getInstance();
    headerMap = Map();
    headerMap["Cookie"] = sp.getString(SP_COOKIE)!;
    return headerMap;
}
  static put(String key, String value) async {
    var prefs = await SharedPreferences.getInstance();

    await prefs.setString(key, value);
  }

  static getS(String key, Function callback) async {
    SharedPreferences.getInstance().then((prefs) {
      callback(prefs.getString(key));
    });
  }


}
