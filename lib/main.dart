import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanandroid/screen/bottom_bar.dart';
import 'package:provider/provider.dart';
import 'package:wanandroid/utils/favorite_provide.dart';
import 'package:wanandroid/utils/theme_provide.dart';
import 'package:wanandroid/utils/app_styles.dart';

import 'api/api.dart';
import 'network/HttpUtil.dart';

void main() async {
  //runApp前调用，初始化绑定，手势、渲染、服务等
  WidgetsFlutterBinding.ensureInitialized();

  int themeIndex = await getTheme();

  runApp(MultiProvider(
    providers: [
      //将theme,favorite加到providers中
      ChangeNotifierProvider(create: (ctx) => ThemeProvide()),
      ChangeNotifierProvider(create: (ctx) => FavoriteProvide())
    ],
    child: MyApp(themeIndex),
  ));
}

Future<int> getTheme() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  int? themeIndex = sp.getInt(Styles.themeIndexKey);
  return null == themeIndex ? 0 : themeIndex;
}

class MyApp extends StatelessWidget {
  final int themeIndex;
  MyApp(this.themeIndex);

  @override
  Widget build(BuildContext context) {
    // int themeValue = context.watch<ThemeProvide>().value;
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      // theme: shrineTheme,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 183, 102, 58)),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: const BottomBar(),

      ),

      // home: const LoginPage(),
    );
  }

}
