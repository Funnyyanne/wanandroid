import 'dart:convert';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/data/article_model.dart';
import 'package:wanandroid/data/extend_root_model.dart';
import 'package:wanandroid/network/HttpUtil.dart';
import 'package:wanandroid/screen/article_detail.dart';
import 'package:wanandroid/utils/app_layout.dart';
import 'package:wanandroid/utils/app_styles.dart';
import 'package:wanandroid/utils/toast.dart';
import '../api/api.dart';
import '../common/log.dart';
import '../data/banner_model.dart';
import 'package:card_swiper/card_swiper.dart';

import 'login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  List<BannerData> bannerData = [];
  List<ArticleData> articleData = [];
  late EasyRefreshController _easyRefreshController;
  late SwiperController _swiperController;
  int page = 0;
  bool hasMore = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _easyRefreshController = EasyRefreshController(
        controlFinishLoad: true, controlFinishRefresh: true);
    _swiperController = SwiperController();
    _loadData();
  }

  void _loadData() async {
    try {
      var bannerResponse = await HttpUtil().get(Api.BASE_URL+Api.BANNER);
      Map<String, dynamic> bannerMap = json.decode(bannerResponse.toString());
      var bannerModel = BannerModel.fromJson(bannerMap);

      //article
      var articleResponse =
          await HttpUtil().get("${Api.BASE_URL+Api.ARTICLE_LIST+page.toString()}/json");
      Map<String, dynamic> articleMap = json.decode(articleResponse.toString());
      var articleModel = ArticleModel.fromJson(articleMap);

      setState(() {
        bannerData = bannerModel.data;
        articleData = articleModel.data.datas;
        print("articleData:$articleData");
      });
      _swiperController.startAutoplay();
    } catch (e) {
      Log.e(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EasyRefresh.builder(
        controller: _easyRefreshController,
        header: PhoenixHeader(
          skyColor: Styles.primaryColor,
          position: IndicatorPosition.locator,
          safeArea: false,
        ),
        footer: PhoenixFooter(
            skyColor: Styles.primaryColor, position: IndicatorPosition.locator),
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2), () {
            if (!mounted) {
              return;
            }
            setState(() {
              page = 0;
            });
            _loadData();

            _easyRefreshController.finishRefresh();
            _easyRefreshController.resetFooter();
          });
        },
        onLoad: () async {
          await Future.delayed(Duration(seconds: 3), () {
            if (!mounted) {
              return;
            }
            setState(() {
              page++;
            });
            loadMoreData();

            _easyRefreshController.finishRefresh(
                hasMore ? IndicatorResult.success : IndicatorResult.noMore);
          });
        },
        childBuilder: (BuildContext context, ScrollPhysics physics) {
          return CustomScrollView(
            physics: physics,
            slivers: [
              SliverAppBar(
                backgroundColor: Styles.primaryColor,
                expandedHeight: AppLayout.getScreenWidth() / 1.8 * 0.8 + 20,
                // +20 是上下的padding值,
                pinned: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: getBanner(),
                ),
              ),
              const HeaderLocator.sliver(),
              SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                return getRow(index, articleData.length);
              }, childCount: articleData.length)),
              const FooterLocator.sliver(),
            ],
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;


  Future loadMoreData() async {
    var response = await HttpUtil().get("${Api.ARTICLE_LIST}$page/json");
    Map<String, dynamic> map = json.decode(response.toString());
    var articleEntity = ArticleModel.fromJson(map);
    setState(() {
      articleData.addAll(articleEntity.data.datas);
      if (articleEntity.data.datas.length < 10) {
        hasMore = false;
      }
    });
  }

  Widget? getRow(int index, int length) {
    if (length == 0) return null;
    return GestureDetector(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: ListTile(
            leading: IconButton(
              icon: articleData != null && articleData[index].collect
                  ? Icon(
                      Icons.favorite,
                      color: Theme.of(context).primaryColor,
                    )
                  : Icon(Icons.favorite_border),
              tooltip: '收藏',
              onPressed: () {
                if (articleData[index].collect) {
                  cancelCollect(articleData[index].id);
                } else {
                  addCollect(articleData[index].id);
                }
              },
            ),
            title: Text(
              articleData[index].title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                children: <Widget>[
                  Container(
                      constraints: const BoxConstraints(maxWidth: 150),
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular((20.0)), // 圆角度
                      ),
                      child: Text(articleData[index].superChapterName,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1)),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(articleData[index].author),
                  )
                ],
              ),
            ),
            trailing: const Icon(Icons.chevron_right),
          ),
        ),
        onTap: () {
          if (0 == 1) return;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ArticleDetail(title:articleData[index].title,url:articleData[index].link),
            ),
          );
        });
  }

  Future addCollect(int id) async {
    var collectResponse = await HttpUtil().post('${Api.COLLECT}$id/json');
    Map<String,dynamic> map = json.decode(collectResponse.toString());
    var entity = ExtendRootModel.fromJson(map);
    if (entity.errorCode == -1001) {
      Toast.show( context, entity.errorMsg);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      Toast.show( context, "收藏成功");
      _loadData();
    }
  }

  Future cancelCollect(int id) async {
    var collectResponse = await HttpUtil().post('${Api.UN_COLLECT_ORIGIN_ID}$id/json');
    Map<String,dynamic> map = json.decode(collectResponse.toString());
    var entity = ExtendRootModel.fromJson(map);
    if (entity.errorCode == -1001) {
      Toast.show( context, entity.errorMsg);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      Toast.show( context, "收藏成功");
      _loadData();
    }
  }

  Widget getBanner() {
    return Container(
      width: AppLayout.getScreenWidth(),
      height: AppLayout.getScreenWidth() / 1.8 * 0.8,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Swiper(
        itemCount: bannerData.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular((10.0)),
                image: DecorationImage(
                    image: NetworkImage(bannerData[index].imagePath),
                    fit: BoxFit.fill)),
          );
        },
        loop: false,
        autoplay: false,
        autoplayDelay: 3000,
        autoplayDisableOnInteraction: true,
        duration: 600,
        controller: _swiperController,
        //默认分页按钮
        pagination: const SwiperPagination(
            builder: DotSwiperPaginationBuilder(size: 6, activeSize: 9)),
        viewportFraction: 0.8,//视图宽度，
        scale: 0.9,
        onTap: (int index){
          print("index----${index.toString()}");
        },
      ),//默认指示器
    );
  }
  @override
  void dispose() {
    _easyRefreshController.dispose();
    _swiperController.stopAutoplay();
    _swiperController.dispose();
    super.dispose();
  }
}
