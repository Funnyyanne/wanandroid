import 'dart:convert';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/utils/app_layout.dart';
import 'package:wanandroid/utils/app_styles.dart';

import '../api/api.dart';
import '../data/project_list_model.dart';
import '../data/project_model.dart';
import '../network/HttpUtil.dart';
import 'article_detail.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> with TickerProviderStateMixin {
  late TabController _controller; //tab控制器
  int _currentIndex = 0; //选中下标

  List<ProjectDataModel> _datas = []; //tab集合
  List<ProjectListDataData> _listDatas = []; //内容集合

  int _page = 1; //看文档时要注意page是从0还是1开始

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 0, vsync: this);
    loadData();
  }

  Future<void> loadData() async {
    try {
      var response = await HttpUtil().get(Api.BASE_URL + Api.PROJECT);
      Map<String, dynamic> userMap = json.decode(response.toString());
      var projectModel = ProjectModel.fromJson(userMap);

      setState(() {
        _datas = projectModel.data;
        _controller = TabController(vsync: this, length: _datas.length);
      });

      getDetail();

      //controller添加监听
      _controller.addListener(() => _onTabChanged());
    } catch (e) {
      print(e);
    }
  }

  _onTabChanged() {
    if (_controller.index.toDouble() == _controller.animation!.value) {
      setState(() {
        _currentIndex = _controller.index;
      });
      getDetail();
    }
  }

  void getDetail() async {
    try {
      var data = {"cid": _datas[_currentIndex].id};
      var response = await HttpUtil()
          .get("${Api.BASE_URL}${Api.PROJECT_LIST}$_page/json", data: data);
      Map<String, dynamic> userMap = json.decode(response.toString());
      var projectListModel = ProjectListModel.fromJson(userMap);
      setState(() {
        _listDatas = projectListModel.data.datas;
      });
    } catch (e) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabBar(
        controller: _controller,
        labelColor: Styles.primaryColor,
        labelStyle: TextStyle(fontSize: 16),
        unselectedLabelColor: Colors.grey.shade600,
        unselectedLabelStyle: TextStyle(fontSize: 14),
        indicatorColor: Styles.primaryColor,
        isScrollable: true,
        tabs: _datas.map((ProjectDataModel choice) {
          return Tab(
            text: choice.name,
          );
        }).toList(),
        onTap: (int i) {
          print(i);
        },
      ),
      body: TabBarView(
          controller: _controller,
          children: _datas.map((ProjectDataModel choice) {
            return EasyRefresh(
                header: TaurusHeader(),
                footer: TaurusFooter(),
                onRefresh: () async {
                  await Future.delayed(Duration(seconds: 1), () {
                    setState(() {
                      _page = 1;
                    });
                    loadData();
                  });
                },
                onLoad: () async {
                  await Future.delayed(Duration(seconds: 1), () async {
                    setState(() {
                      _page++;
                    });
                    getMoreData();
                  });
                },
                child: CustomScrollView(
                  slivers: [
                    SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                      return getRow(index);
                    }, childCount: _listDatas.length)),
                  ],
                ));
          }).toList()),
    );
  }

  Widget getRow(int index) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all(10),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Image.network(_listDatas[index].envelopePic),
                ),
                Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            _listDatas[index].title,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            _listDatas[index].desc,
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey.shade600),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    _listDatas[index].niceDate,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  _listDatas[index].author,
                                  style: TextStyle(fontSize: 14),
                                  textAlign: TextAlign.right,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleDetail(
                  title: _listDatas[index].title, url: _listDatas[index].link),
            ));
      },
    );
  }

  Future<void> getMoreData() async {
    var data = {"cid": _datas[_currentIndex].id};
    var response = await HttpUtil()
        .get("${Api.BASE_URL}${Api.PROJECT_LIST}$_page/json", data: data);
    Map<String, dynamic> map = json.decode(response.toString());
    var projectListModel = ProjectListModel.fromJson(map);
    setState(() {
      _listDatas.addAll(projectListModel.data.datas);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
