import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/common/log.dart';
import 'package:wanandroid/network/HttpUtil.dart';
import 'package:wanandroid/screen/tree_detail_page.dart';
import 'package:wanandroid/utils/app_styles.dart';
import 'package:wanandroid/utils/toast.dart';

import '../api/api.dart';
import '../data/tree_model.dart';

class TreePage extends StatefulWidget {
  const TreePage({super.key});

  @override
  State<TreePage> createState() => _TreePageState();
}

class _TreePageState extends State<TreePage> {
  List<TreeList> _data = [];
  final ScrollController _scrollController = ScrollController();
  int _panelIndex = 0; //展开下标
  final List<IconData> _icons = [
    Icons.star_border,
    Icons.child_care,
    Icons.cloud_queue,
    Icons.ac_unit,
    Icons.lightbulb_outline,
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        Toast.show(context, '滑动到底部了');
      }
    });
    loadData();
  }

  void loadData() async {
    try {
      var response = await HttpUtil().get(Api.BASE_URL+Api.TREE);
      Map<String, dynamic> map = json.decode(response.toString());
      var treeModel = TreeModel.fromJson(map);
      for (int i = 0; i < treeModel.data.length; i++) {
        treeModel.data[i].isExpanded = false;
      }
      setState(() {
        _data = treeModel.data;
      });
    } catch (e) {
      Log.e(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        color: Styles.primaryColor,
        displacement: 40,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: ExpansionPanelList(
            animationDuration: const Duration(milliseconds: 500),
            expansionCallback: (panelIndex, isExpanded) {
              setState(() {
                _panelIndex = panelIndex;
                _data[panelIndex].isExpanded = !isExpanded;
              });
            },
            children: _data.map<ExpansionPanel>((TreeList treeList) {
              return ExpansionPanel(
                //标题
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    contentPadding: const EdgeInsets.all(10.0),
                    title: Text(
                      treeList.name,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    //取随机icon
                    leading: Icon(_icons[Random().nextInt(_icons.length)]),
                  );
                },
                //展开内容
                body: Container(
                  height: 200,
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: ListView.builder(
                    itemCount: treeList.children.length,
                    itemBuilder: (BuildContext context, int position) {
                      return getRow(position, treeList);
                    },
                  ),
                ),
                //是否展开
                isExpanded: treeList.isExpanded,
              );
            }).toList(),
          ),
        ),
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1), () {
            Toast.show(context, "下拉刷新");
          });
        },
      ),
    );
  }

  Widget getRow(int i, TreeList treeData) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: ListTile(
          title: Text(
            treeData.children[i].name,
            style: TextStyle(color: Styles.textColor),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: Styles.textColor,
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                TreeDetailPage(panelIndex: _panelIndex, index: i),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
