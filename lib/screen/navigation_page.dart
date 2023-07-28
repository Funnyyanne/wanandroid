import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/api/api.dart';
import 'package:wanandroid/network/HttpUtil.dart';
import 'package:wanandroid/screen/article_detail.dart';
import 'package:wanandroid/utils/app_styles.dart';

import '../data/navi_model.dart';

class NaviPage extends StatefulWidget {
  const NaviPage({super.key});

  @override
  State<NaviPage> createState() => _NaviPageState();
}

class _NaviPageState extends State<NaviPage> {
  List<NaviData> _datas = [];
  List<NaviDataArticle> article = [];
  int index = 0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    try {
      var response = await HttpUtil().get(Api.BASE_URL + Api.NAVI);
      Map<String, dynamic> map = json.decode(response.toString());
      var naviModel = NaviModel.fromJson(map);
      setState(() {
        _datas = naviModel.data;
        index = 0;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
            flex: 2,
            child: Container(
              color: Colors.white,
              child: ListView.builder(
                  itemCount: _datas.length,
                  itemBuilder: (BuildContext context, int position) {
                    return getRow(position);
                  }),
            )),
        Expanded(
            flex: 5,
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(10),
                  color: Styles.color_F9F9F9,
                  child: getChip(index),
                )
              ],
            ))
      ],
    );
  }

  Widget getRow(int position) {
    Color textColor = Theme.of(context).primaryColor; //字体颜色
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        decoration: BoxDecoration(
            color: index == position ? Styles.color_F9F9F9 : Colors.white,
            border: Border(
                left: BorderSide(
                    width: 5,
                    color: index == position
                        ? Theme.of(context).primaryColor
                        : Colors.white))),
        child: Text(
          _datas[position].name,
          style: TextStyle(
              color: index == position ? textColor : Styles.primaryColor,
              fontWeight: index == position ? FontWeight.w600 : FontWeight.w400,
              fontSize: 16),
        ),
      ),
      onTap: () {
        setState(() {
          index = position;
          textColor = Styles.colorPrimary;
        });
      },
    );
  }

  getChip(int index) {
    _updateArticles(index);
    return Wrap(
        spacing: 10.0,
        direction: Axis.horizontal,
        alignment: WrapAlignment.start,
        children: List<Widget>.generate(article.length, (int index) {
          return ActionChip(
            label: Text(
              article[index].title,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ArticleDetail(
                          url: article[index].link,
                          title: article[index].title)));
            },
            elevation: 3,
            backgroundColor: Colors.grey.shade200,
          );
        }));
  }

  List<NaviDataArticle> _updateArticles(int i) {
    setState(() {
      if (_datas.length != 0) article = _datas[i].articles;
    });
    return article;
  }
}
