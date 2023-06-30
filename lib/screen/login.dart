import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wanandroid/utils/app_layout.dart';
import 'package:wanandroid/utils/app_styles.dart';

import '../api/http_service.dart';
import '../data/user_model.dart';
import '../utils/toast.dart';
import 'bottom_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  bool isLogin = true;
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gap(AppLayout.getHeigh(80)),
            Container(
              width: AppLayout.getWidth(250),
              height: AppLayout.getHeigh(160),
              decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage("images/logo.png"))),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: AppLayout.getScreenWidth(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Hello",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.black)),
                  Text(
                    isLogin ? "登录你的账户" : "注册",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                        color: Colors.grey.shade500),
                  ),
                  SizedBox(height: AppLayout.getHeigh(25)),
                  // Gap(AppLayout.getHeigh(25)),
                  TextField(
                    controller: _userNameController,
                    decoration: InputDecoration(
                        hintText: "请输入用户名",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Styles.color_tags), // set the border color
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  Gap(AppLayout.getHeigh(20)),
                  TextField(
                      controller: _pwdController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "请输入密码",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color:
                                Styles.color_tags), // set the border color
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)))),
                  Gap(AppLayout.getHeigh(16)),
                  Row(
                    children: [
                      Expanded(child: Container()),
                      Text(
                        "forget password？",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                            color: Colors.grey.shade500),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: AppLayout.getScreenWidth() * 0.8,
              height: AppLayout.getScreenHeight() * .08,
              child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {
                    doPost(context);
                  },
                  child: Text(
                    isLogin ? "登录" : "注册并登录",
                    style: Styles.textStyle.copyWith(color: Colors.white),
                  )),
            ),
            SizedBox(height: AppLayout.getScreenHeight() * .2),
            RichText(
              text: TextSpan(
                  text: "还没有账号？",
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 20),
                  children: [
                    TextSpan(
                        text: "创建",
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            setState(() {
                              // isCreate = true;
                            });
                          })
                  ]),
            )
          ],
        ),
      ),
    );
  }

  doPost(BuildContext context)  async {
    var _userNameStr = _userNameController.text;
    var _psdStr = _pwdController.text;
    if (null == _psdStr || _userNameStr.length < 6 || _psdStr.length < 6) {
      Toast.show(context, "账号/密码不符合标准");
    } else {
      var response =  isLogin
          ? await HttpService().login(_userNameStr, _psdStr)
          : await HttpService().register(_userNameStr, _psdStr);
      print("response 输出:${response.toString()}");
      // var pdfText= await json.decode(json.encode(response.databody));
      // print(pdfText);
      Map<String, dynamic> userMap =  json.decode(response.toString());
      var userEntity = UserModel.fromJson(userMap);
      print("userEntity 输出 ${userEntity.data}");
      if (userEntity.errorCode == 0) {
        Toast.show(context, isLogin ? "登录成功~" : "注册成功~");
      //   //跳转并关闭当前页面
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const BottomBar()),
              (route) => route == null,
        );
      } else {
        Toast.show(context, userMap['errorMsg']);
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
