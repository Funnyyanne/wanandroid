import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/data/article_model.dart';
import '../data/banner_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BannerData> bannerDatas = [];
  List<ArticleList> articleDatas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Contect'),
    );
  }
}
