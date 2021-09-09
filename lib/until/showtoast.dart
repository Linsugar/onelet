
import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class PopupUntil{
 static void showToast(String msg){
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );
  }
}


//自定义进度条
class ShowAlertProgress extends StatefulWidget {
  ShowAlertProgress(this.requestCallback);
  final Future<dynamic> requestCallback;

  @override
  _ShowAlertProgressState createState() => _ShowAlertProgressState();
}

class _ShowAlertProgressState extends State<ShowAlertProgress> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(milliseconds: 10), (){
//      print("当前valu=====================1111：${await widget.requestCallback}");
       widget.requestCallback.then((value) => {
        print("当前valu=====================：${value['msg']}"),
         if(value['msg']!='登录成功'){
           Navigator.of(context).pop()
         }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}



ShowAlerDialog(context)async{
  return showDialog(context: context, builder: (context){
    return AlertDialog(
      title: Text("权限协议"),

      content: Container(
        child: Text(
           '欢迎使用"语论"!我们非常重视您的个人信息和隐私保护。在您使用"语论"服务之前,请仔细阅读《语论视频隐私政策》和《语论用户协议》,我们将严格按照经您同意的各项条款使用您的个人信息,以便为您提供更好的服务请您同意此政策和协议。'
        '请点击“同意"开始使用我们的产品和服务,我们将尽全力保护您的个人信息安全。'
            ''),
      ),
      actions: [
        MaterialButton(child: Text('取消'),onPressed: (){
          Navigator.pop(context);
        },),
        MaterialButton(child: Text('同意'),onPressed: (){
          PopupUntil.showToast("不好意思，我还没想好怎么做");
        },),
      ],
    );
  });

}


