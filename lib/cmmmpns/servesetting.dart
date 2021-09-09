

import 'package:onelet/pages/login/login.dart';

import 'package:onelet/until/shared.dart';
import 'package:onelet/until/showtoast.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qiniu_flutter_sdk/qiniu_flutter_sdk.dart';

//系统设置
class ServiceSetting extends StatefulWidget {
  @override
  _ServiceSettingState createState() => _ServiceSettingState();
}

class _ServiceSettingState extends State<ServiceSetting> {
  Storage  storage = Storage();
  String token  ='cyIcJU0RXy1nD1t0I6DauqqCblEcFX1npjtld5Ky:huKG-Ckj5U4ZBeDFCtAX-xXax7s=:eyJzY29wZSI6InRhbmdodWFkb25nIiwiZGVhZGxpbmUiOjE2MjYzNDIyNjB9';

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(244, 107, 69, 1),
                  Color.fromRGBO(238, 168, 73, 1),
                ],
              )
          ),
        ),
        title: Text("设置",)),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            color: Colors.white,
            child: ListTile(
            onTap: (){
              PopupUntil.showToast("功能尚在开发中");
            },leading: Text("账号绑定设置"),trailing: FaIcon(FontAwesomeIcons.angleRight),),
          ),
         Container(
           margin: EdgeInsets.only(bottom: 10,top: 10),
           color: Colors.white,
           child:ListTile(onTap: (){
           PopupUntil.showToast("功能尚在开发中");
         },leading: Text("消息提醒设置"),trailing: FaIcon(FontAwesomeIcons.angleRight),),),
          Container(
            margin: EdgeInsets.only(bottom: 40,),
            color: Colors.white,
            child: ListTile(onTap: (){
              PopupUntil.showToast("功能尚在开发中");
            },leading: Text("注销账号",style: TextStyle(color: Colors.red,fontWeight: FontWeight.w900,letterSpacing: 1.0),),trailing: FaIcon(FontAwesomeIcons.angleRight),),
          ),
          ElevatedButton(
            style:ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.orange),
                shape: MaterialStateProperty.all(StadiumBorder(side: BorderSide(
                    style: BorderStyle.solid,
                    color: Colors.orange
                )))
            ) ,
            child: Text("退出登录"),onPressed: ()async{
            await Shared.clearPreferences();
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>MyHomePage()), (route) => false);
          },),
        ],
      ),
    );
  }
}
