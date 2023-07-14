import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wanandroid/common/sp.dart';
import 'package:wanandroid/utils/app_layout.dart';
import 'package:wanandroid/utils/app_styles.dart';

import '../api/http_service.dart';
import '../data/user_model.dart';
import '../utils/toast.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _repwdController = TextEditingController();

  // 是否隐藏输入的文本
  bool obscurePassText = true;



  // 是否正在注册
  bool isOnLogin = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var loadingView;
    if (isOnLogin) {
      loadingView = const Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[CupertinoActivityIndicator(), Text("注册中，请稍等...")],
            ),
          ));
    } else {
      loadingView = Center();
    }
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
                     "注册",
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
                      obscureText: obscurePassText,
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
                  InkWell(
                    child: Container(
                      width: AppLayout.getWidth(100),//ScreenUtil.getInstance().setWidth(100),
                      height: AppLayout.getWidth(100),
                      alignment: Alignment.center,
                      child: Image.asset("assets/images/ic_eye.png",
                          width: AppLayout.getWidth(50),
                          height: AppLayout.getWidth(50),
                    )),
                    onTap: () {
                      setState(() {
                        obscurePassText = !obscurePassText;
                      });
                    },
                  ),
                  Gap(AppLayout.getHeigh(16)),
                  TextField(
                      controller: _repwdController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "请再次输入密码",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color:
                                    Styles.color_tags), // set the border color
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)))),
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
                    doRegister(context);
                  },
                  child: Text(
                    "注册并登录",
                    style: Styles.textStyle.copyWith(color: Colors.white),
                  )),
            ),
            Expanded(
                child: Column(
                  children: <Widget>[
                    Expanded(child: loadingView),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  void doRegister(BuildContext context) async {
    setState(() {
      isOnLogin = true;
    });
    var userNameStr = _userNameController.text;
    var pwdStr = _pwdController.text;
    var rePwdSr = _repwdController.text;
    if (null == pwdStr || userNameStr.length < 6 || pwdStr.length < 6) {
      Toast.show(context, "账号/密码不符合标准");
    }else if(pwdStr != rePwdSr){
      Toast.show(context, "两次密码输入不一致！");
    } else {
      FocusScope.of(context).requestFocus(FocusNode());

      var response = await HttpService().register(userNameStr, pwdStr,rePwdSr);

      Map<String, dynamic> userMap = json.decode(response.toString());
      var userEntity = UserModel.fromJson(userMap);
      print("userEntity 输出 ${userEntity.data}");

      if (userEntity.errorCode == 0) {
        //跳转并关闭当前页面
        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(builder: (context) => const BottomBar()),
        //   (route) => route == null,
        // );
        //
        Sp.saveLoginInfo(userEntity.data, userNameStr, pwdStr);
        Navigator.pop(context);
        Toast.show(context, "注册成功");
      } else {
        Toast.show(context, userMap['errorMsg']);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _repwdController.dispose();
    _userNameController.dispose();
    _pwdController.dispose();
  }
}
