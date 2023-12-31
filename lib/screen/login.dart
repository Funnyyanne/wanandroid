import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wanandroid/common/sp.dart';
import 'package:wanandroid/screen/register.dart';
import 'package:wanandroid/utils/app_layout.dart';
import 'package:wanandroid/utils/app_styles.dart';

import '../api/http_service.dart';
import '../data/user_model.dart';
import '../testlogin/MyApp.dart';
import '../utils/toast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> with SingleTickerProviderStateMixin {
  bool isLogin = false;

  // 是否隐藏输入的文本
  bool obscureText = true;

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gap(AppLayout.getHeigh(30)),
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
                   "登录你的账户" ,
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
                    doLogin();
                  },
                  child: Text(
                     "登录" ,
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
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RegisterPage()),
                            );
                          })
                  ]),
            )
          ],
        ),
      ),
    );
  }

  void doLogin() async {

    var userNameStr = _userNameController.text;
    var pwdStr = _pwdController.text;
    if (null == pwdStr || userNameStr.length < 6 || pwdStr.length < 6) {
      Toast.show(context, "账号/密码不符合标准");
    } else {
      var response = await HttpService().login(userNameStr, pwdStr);
      Map<String, dynamic> userMap = json.decode(response.toString());
      var userEntity = UserModel.fromJson(userMap);
      print("userEntity 输出 ${userEntity.data}");
      setState(() {
        isLogin ;
      });
      if (userEntity.errorCode == 0) {
        Sp.saveLoginInfo(userEntity.data, userNameStr, pwdStr);
        //跳转并关闭当前页面
        Navigator.pop(context);
        Toast.show(context, "登录成功");

      } else {
        Toast.show(context, userMap['errorMsg']);
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _userNameController.dispose();
    _pwdController.dispose();
  }
}
