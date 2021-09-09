import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:flutter/material.dart';
class webviewcpns extends StatefulWidget {
  Map ?arguments;
  webviewcpns(this.arguments);
  @override
  _webviewcpnsState createState() => _webviewcpnsState();
}

class _webviewcpnsState extends State<webviewcpns> {
  WebViewController ?_controller;
  var wxcontext;
  @override
  void initState() {
     wxcontext = widget.arguments!['wxcontext'];
    // TODO: implement initState
    if(Platform.isAndroid) WebView.platform =SurfaceAndroidWebView();
    super.initState();
  }

  _getitle()async{
    var titl =await _controller!.getTitle();
    var back =await _controller!.canGoBack();
    print("titl:${titl}");
    print("back:${back}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(244, 107, 69, 1),
                Color.fromRGBO(238, 168, 73, 1),
              ],
            )
        ),
      ),title: Text("${wxcontext.wxtitle}"),),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
//        页面加载完成的回调
        onPageFinished: (value){
          print("页面完成：${value}");
          _getitle();
        },
//        创建页面的回调
        onWebViewCreated: (WebViewController controller){
          print("创建完成1");
          _controller = controller;
          _getitle();
          _controller!.loadUrl("${wxcontext.wxurl}");
        },
        initialUrl: "https://mp.weixin.qq.com/s/9mgnjye6JHPuecgQBuQDQg",
      ),
    );
  }
}








