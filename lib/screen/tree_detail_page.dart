import 'dart:convert';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/data/tree_model.dart';
import 'package:wanandroid/screen/article_detail.dart';
import 'package:wanandroid/utils/app_styles.dart';
import 'package:wanandroid/utils/toast.dart';

import '../api/api.dart';
import '../data/article_model.dart';
import '../data/extend_root_model.dart';
import '../network/HttpUtil.dart';
import 'login.dart';

class TreeDetailPage extends StatefulWidget {
  final int panelIndex; //一级分类选中下标
  final int index; //二级分类选中下标
  const TreeDetailPage({ Key? key,  required this.panelIndex, required this.index}) : super(key: key);

  // const TreeDetailPage( {Key key,required this.panelIndex, required this.index})
  //     : super(key: key);

  @override
  State<TreeDetailPage> createState() => _TreeDetailPageState();
}

class _TreeDetailPageState extends State<TreeDetailPage>
    with TickerProviderStateMixin {
  late TabController _controller;
  int _currentIndex = 0;

  List<TreeList> _datas = []; //一级分类集合
  List<TreeDatachild> _tabDatas = []; //二级分类 即 tab集合
  List<ArticleData> articleDatas = []; //内容集合

  String _title = "标题";

  int _page = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(vsync: this, length: 0);
    loadData();
  }

  loadData() async {
    var response = await HttpUtil().get(Api.BASE_URL+Api.TREE);
    Map<String, dynamic> userMap = json.decode(response.toString());
    var treeModel = TreeModel.fromJson(userMap);
    setState(() {
      _datas = treeModel.data;
      _tabDatas = _datas[widget.panelIndex].children;
      _controller = TabController(vsync: this, length: _tabDatas.length);

      _currentIndex = widget.index;
      _title = _datas[widget.panelIndex].name;
    });
    //controller添加监听
    _controller.addListener(() => _onTabChanged());
    //选中指定下标
    _controller.animateTo(_currentIndex);

    getDetail();
  }

  _onTabChanged() {
    if (_controller.index.toDouble() == _controller.animation?.value) {
      //赋值 并更新数据
      setState(() {
        _currentIndex = _controller.index;
      });
      getDetail();
    }
  }

  /// 根据tab下标获取数据
  Future getDetail() async {
    //加载重置
    setState(() {
      _page = 0;
    });
    var data = {"cid": _tabDatas[_currentIndex].id};
    var response =
        await HttpUtil().get("${Api.ARTICLE_LIST}$_page/json", data: data);
    Map<String, dynamic> articleMap = json.decode(response.toString());
    var articleEntity = ArticleModel.fromJson(articleMap);

    if (articleEntity.data.datas.isEmpty) {
      Toast.show(context, "数据为空~");
    } else {
      setState(() {
        articleDatas = articleEntity.data.datas;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.primaryColor,
        title: Text(_title),
        bottom: TabBar(
          controller: _controller,
          labelColor: Colors.white,
          labelStyle: const TextStyle(fontSize: 16),
          unselectedLabelColor: Colors.white60,
          unselectedLabelStyle: const TextStyle(fontSize: 16),
          isScrollable: true,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: _tabDatas.map((TreeDatachild choice) {
            return Tab(text: choice.name);
          }).toList(),
          onTap: (int i) {
            print("tree tab:$i");
          },
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: _tabDatas.map((TreeDatachild choice) {
          return EasyRefresh(
            header: const TaurusHeader(),
            footer: const TaurusFooter(),
            onRefresh: () async {
              await Future.delayed(Duration(seconds: 1), () {
                setState(() {
                  _page = 0;
                });
                getDetail();
              });
            },
            onLoad: () async {
              await Future.delayed(const Duration(seconds: 1), () async {
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
                }, childCount: articleDatas.length)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget getRow(int i) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: ListTile(
          leading: IconButton(
            icon: articleDatas[i].collect
                ? Icon(
                    Icons.favorite,
                    color: Theme.of(context).primaryColor,
                  )
                : const  Icon(Icons.favorite_border),
            tooltip: '收藏',
            onPressed: () {
              if (articleDatas[i].collect) {
                cancelCollect(articleDatas[i].id);
              } else {
                addCollect(articleDatas[i].id);
              }
            },
          ),
          title: Text(
            articleDatas[i].title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular((20.0)), // 圆角度
                  ),
                  child: Text(
                    articleDatas[i].superChapterName,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(articleDatas[i].author),
                ),
              ],
            ),
          ),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleDetail(
                title: articleDatas[i].title, url: articleDatas[i].link),
          ),
        );
      },
    );
  }

  Future addCollect(int id) async {
    var collectResponse = await HttpUtil().post('${Api.COLLECT}$id/json');
    Map<String, dynamic> map = json.decode(collectResponse.toString());
    var entity = ExtendRootModel.fromJson(map);
    if (entity.errorCode == -1001) {
      Toast.show(context, entity.errorMsg);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      Toast.show(context, "取消成功");
      loadData();
    }
  }

  Future cancelCollect(int id) async {
    var collectResponse =
        await HttpUtil().post('${Api.UN_COLLECT_ORIGIN_ID}$id/json');
    Map<String, dynamic> map = json.decode(collectResponse.toString());
    var entity = ExtendRootModel.fromJson(map);
    if (entity.errorCode == -1001) {
      Toast.show(context, entity.errorMsg);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      Toast.show(context, "取消成功");
      loadData();
    }
  }

  void getMoreData() async {
    var data = {"cid": _tabDatas[_currentIndex].id};
    var response =
        await HttpUtil().get("${Api.ARTICLE_LIST}$_page/json", data: data);
    Map<String, dynamic> articleMap = json.decode(response.toString());
    var articleEntity = ArticleModel.fromJson(articleMap);
    setState(() {
      articleDatas.addAll(articleEntity.data.datas);
    });
  }
}
