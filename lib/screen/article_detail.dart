import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/utils/app_styles.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ArticleDetail extends StatefulWidget {
  String url;
  String title;

   ArticleDetail({super.key, required this.url, required this.title});

    @override
  State<ArticleDetail> createState() => _ArticleDetailState();


}

class _ArticleDetailState extends State<ArticleDetail> {

  InAppWebViewController? webViewController;

  final GlobalKey webViewKey = GlobalKey();
  late PullToRefreshController pullToRefreshController;

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  //没看到有这个类  大哥 这个是 6.x.x版本的呀， 上面5的才是webview的设置
  // InAppWebViewSettings settings = InAppWebViewSettings(
  //     useShouldOverrideUrlLoading: true,
  //     mediaPlaybackRequiresUserGesture: false,
  //     allowsInlineMediaPlayback: true,
  //     iframeAllow: "camera; microphone",
  //     iframeAllowFullscreen: true
  // );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Styles.primaryColor),
        routes: {
          "/": (context) =>
              InAppWebView(
                key: webViewKey,
                initialUrlRequest:
                URLRequest(url: Uri.parse(widget.url,)),
                initialOptions: options,
                pullToRefreshController: pullToRefreshController,
                onWebViewCreated: (controller) {
                  webViewController = controller;
                },
                //   routes: {
                //     "/":(context)   =>{   }
                // }
                // {
                // var url = WebUri(valu/e);
                // if (url.scheme.isEmpty) {
                // url = WebUri("https://www.google.com/search?q=" + value);
                // }
                // }

              )});
  }
}