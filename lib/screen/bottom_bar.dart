import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/utils/app_styles.dart';

import '../api/api.dart';
import '../network/HttpUtil.dart';
import 'hoem_page.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() =>
      _BottomBarState();
}

class _BottomBarState
    extends State<BottomBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
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
        title: const Text('BottomBar'),
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
        unselectedItemColor:  Styles.color_dark_gray,
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
      child: ListTile(
        leading: const Icon(Icons.block),
        title: const Text("退出"),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.of(context).pop();
          showLogoutDialog(context);
        },
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
                HttpUtil().get(Api
                    .LOGOUT);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}