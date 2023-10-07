// import 'dart:async';
// import 'dart:convert';
//
// import 'package:dio/dio.dart';
// import 'package:wanandroid/api/http_service.dart';
// import '../data/user_model.dart';
// import '../utils/date_util.dart';
// import 'sp.dart';
//
//
// class User {
//   late String userName;
//   late String password;
//   late String cookie;
//   late DateTime cookieExpiresTime;
//   late Map<String, String> _headerMap;
//
//   static final User _singleton = User._internal();
//
//   factory User() {
//     return _singleton;
//   }
//
//   User._internal();
//
//   bool isLogin() {
//     return null != userName &&
//         userName.length >= 6 &&
//         null != password &&
//         password.length >= 6;
//   }
//
//   void logout() {
//     Sp.logout();
//     userName = "";
//     password = "";
//     _headerMap = <String, String>{};
//   }
//
//   void refreshUserData({required Function callback}) {
//     Sp.getPassword((pw) {
//       this.password = pw;
//     });
//     Sp.getUserName((str) {
//       this.userName = str;
//       if (null != callback) {
//         callback();
//       }
//     });
//     Sp.getCookie((str) {
//       this.cookie = str;
//       _headerMap = {};
//     });
//     Sp.getCookieExpires((str) {
//       if (null != str && str.length > 0) {
//         this.cookieExpiresTime = DateTime.parse(str);
//         //提前3天请求新的cookie
//         if (cookieExpiresTime.isAfter(DateUtil.getDaysAgo(3))) {
//           Timer(Duration(milliseconds: 100), () {
//             autoLogin();
//           });
//         }
//       }
//     });
//   }
//
//   void login({required Function callback}) {
//
//     _saveUserInfo(HttpService().login(userName, password), userName, password,
//         callback: callback);
//   }
//
//   void register({required Function callback}) {
//     // _saveUserInfo(
//     //     HttpService().register(userName, password), userName, password,
//     //     callback: callback);
//   }
//
//   void _saveUserInfo(
//       Future<Response> responseF, String userName, String password,
//       {required Function callback}) {
//     responseF.then((response) {
//       var userModel = UserModel.fromJson(response.data);
//       if (userModel.errorCode == 0) {
//         Sp.putUserName(userName);
//         Sp.putPassword(password);
//         String cookie = "";
//         DateTime expires ;
//         response.headers.forEach((String name, List<String> values) {
//           if (name == "set-cookie") {
//             cookie = json
//                 .encode(values)
//                 .replaceAll("\[\"", "")
//                 .replaceAll("\"\]", "")
//                 .replaceAll("\",\"", "; ");
//             try {
//               expires = DateUtil.formatExpiresTime(cookie);
//
//             } catch (e) {
//               expires = DateTime.now();
//             }
//           }
//         });
//
//         if (null != callback) callback(true, null);
//       } else {
//         if (null != callback) callback(false, userModel.errorMsg);
//       }
//     });
//   }
//
//   void autoLogin() {
//     if (isLogin()) {
//       login(callback:(bool loginOK, String errorMsg){});
//     }
//   }
//
//   Map<String, String> getHe3ader() {
//     if (null == _headerMap) {
//       _headerMap = Map();
//       _headerMap["Cookie"] = cookie;
//     }
//     return _headerMap;
//   }
// }
