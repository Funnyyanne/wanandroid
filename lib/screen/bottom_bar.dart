import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/screen/navigation_page.dart';
import 'package:wanandroid/screen/project_page.dart';
import 'package:wanandroid/screen/tree_page.dart';
import 'package:wanandroid/utils/app_styles.dart';

import '../api/api.dart';
import '../network/HttpUtil.dart';
import 'article_detail.dart';
import 'collect_page.dart';
import 'hoem_page.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    TreePage(),
    ProjectPage(),
    NaviPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WanAndroid'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        elevation: 10,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        selectedItemColor: Styles.primaryColor,
        unselectedItemColor: Styles.color_dark_gray,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FluentSystemIcons.ic_fluent_home_regular),
            activeIcon: Icon(FluentSystemIcons.ic_fluent_home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(FluentSystemIcons.ic_fluent_news_regular),
            activeIcon: Icon(FluentSystemIcons.ic_fluent_news_filled),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(FluentSystemIcons.ic_fluent_people_regular),
            activeIcon: Icon(FluentSystemIcons.ic_fluent_people_filled),
            label: 'School',
          ),
          BottomNavigationBarItem(
            icon: Icon(FluentSystemIcons.ic_fluent_settings_regular),
            activeIcon: Icon(FluentSystemIcons.ic_fluent_settings_filled),
            label: 'Settings',
          ),
        ],
      ),
      drawer: showDrawer(context),
    );
  }

  Widget showDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Styles.primaryColor),
              currentAccountPicture: GestureDetector(
                child: ClipOval(
                  child: Image.network(
                      "https://avatars.githubusercontent.com/u/19363761?s=96&v=4"),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage()));
                },
              ),
              otherAccountsPictures: <Widget>[
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArticleDetail(
                              title: "来都来了，点个star吧🌹",
                              url: "https://github.com/Funnyyanne/wanandroid"),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.stars,
                      color: Colors.white,
                    ))
              ],
              accountName: const Text(
                "EGAL",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              accountEmail:
                  const Text("https://github.com/Funnyyanne/wanandroid")),

          ///功能列表
          ListTile(
            leading: Icon(Icons.favorite_border),
            title: Text("我的收藏"),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CollectPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text("我要分享"),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              // Navigator.of(context).pop();
              // Share.share(
              //     '【玩安卓Flutter版】\nhttps://github.com/Funnyyanne/wanandroid');
            },
          ),
          ListTile(
            leading: const Icon(Icons.block),
            title: const Text("退出"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).pop();
              showLogoutDialog(context);
            },
          )
        ],
      ),
    );
  }

  void showLogoutDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('提示'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('确认退出吗？'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('取消', style: Styles.textStyle),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('确定'),
              onPressed: () {
                //退出
                HttpUtil().get(Api.LOGOUT);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
