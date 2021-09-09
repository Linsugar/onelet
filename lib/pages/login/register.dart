import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:onelet/network/requests.dart';
import 'package:onelet/provider/grobleState.dart';
import 'package:onelet/until/CommonUntil.dart';
import 'package:onelet/until/CreamUntil.dart';
import 'package:onelet/until/shared.dart';
import 'package:onelet/until/showtoast.dart';
import 'package:flutter/material.dart';
import 'package:onelet/pages/login/login.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../main.dart';
class Regitser extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterState();
  }
}

class RegisterState extends State<Regitser> {
  bool checkbool = false;
  bool sexbool = false;
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _userController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  String ?avator;
  int ?selectSex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String token = context.watch<GlobalState>().qiNiuToken;
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height,
            child: Flex(direction: Axis.vertical, children: [
              Expanded(flex: 3, child: Container(
                padding: EdgeInsets.only(top: 30),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          var path = await Creamer.GetGrally();
                          var avatorpath= await qiNiuUpImage(path,token);
                          setState(() {
                            avator = avatorpath;
                          }
                          );
                        },
                        child: ClipOval(
                          child: Container(
                            color: Colors.white,
                            width: 70,
                            height: 70,
                            child: avator == null ? Center(
                                child: FaIcon(FontAwesomeIcons.camera)) :
                            Image(
                              image:NetworkImage(avator!),
                              fit: BoxFit.cover,),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                    ]
                ),
              ),),
              Expanded(flex: 6, child: Container(
                padding: EdgeInsets.all(10), child: Form(
                autovalidateMode: AutovalidateMode.always,
                key: _globalKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty || value.length != 11) {
                          print("当前类型：${value.runtimeType}");
                          return "手机号码输入有误";
                        } else {
                          return null;
                        }
                      },
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      maxLength: 13,
                      maxLines: 1,
                      decoration: InputDecoration(
                          icon: FaIcon(
                              FontAwesomeIcons.mobileAlt),
                          hintText: "请输入手机号码",
                          labelText: "手机号"
                      ),),
                    SizedBox(height: 10,),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty || value.length > 5) {
                          return "用户名输入有误";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.name,
                      controller: _userController,
                      maxLength: 5,
                      maxLines: 1,
                      decoration: InputDecoration(
                          icon: FaIcon(
                              FontAwesomeIcons.userTie),
                          hintText: "请输入用户名",
                          labelText: "用户名"
                      ),),
                    SizedBox(height: 10,),
                    TextFormField(
                      onFieldSubmitted: (value) async {
                        await regis(context);
                      },
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 5) {
                          return "请正确输入密码";
                        } else {
                          return null;
                        }
                      },
                      controller: _pwdController,
                      maxLength: 10,
                      maxLines: 1,
                      decoration: InputDecoration(
                          icon: FaIcon(
                              FontAwesomeIcons.key),
                          hintText: "请输入密码",
                          labelText: "密码"
                      ),),
                  ],
                ),
              ),)),
              Row(children: [
                Text("请选择性别："),
                Row(children: [Text("男"),Radio(value: 0, groupValue:selectSex, onChanged: (int ?value){
                  setState(() {
                    selectSex =value;
                  });
                  print("选择$value");})],),
                Row(children: [Text("女"),Radio(value: 1, groupValue: selectSex, onChanged: (int ?value){
                  setState(() {
                    selectSex =value;
                  });
                  print("选择$value");})],),
              ],),
              Expanded(flex: 3,
                  child: Container(
                    margin: EdgeInsets.only(left: 20,right: 20),
                    child: Flex(direction: Axis.vertical, children: [
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.topRight,
                                colors: [ Colors.purpleAccent,Colors.deepPurple,]
                            ),
                            borderRadius: BorderRadius.circular(10)
                        ), child: MaterialButton(
                        child: Text("注册",style: TextStyle(color: Colors.white,fontSize: 20),),
                        onPressed: ()async{
                          Provider.of<GlobalState>(context,listen: false).changeloads(true);

                          await regis(context);
                        },
                        minWidth: double.infinity,
                      ),),
                      SizedBox(height: 10,),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.blue[200],
                            borderRadius: BorderRadius.circular(10)
                        ), child: MaterialButton(
                        minWidth: double.infinity,
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
                        },
                        child: Text("登录"),),)
                    ],),))
            ],)
        ),
      ),
    );
  }
  Future regis(BuildContext context) async {
    if (_globalKey.currentState!.validate()) {
      if (avator != null) {
        var formdata = FormData.fromMap({
          'user_mobile': _phoneController.text,
          'password': _pwdController.text,
          'username': _userController.text,
          'user_sex':selectSex,
          'city': context
              .read<GlobalState>()
              .city,
          'deviceid': context
              .read<GlobalState>()
              .deviceid,
          'platform': context
              .read<GlobalState>()
              .platform,
          'avator_image': avator!,
          'invite_number': 666666,
        });
        var resultData = await Request.setNetwork('user/', formdata);
        String ?token = resultData['token'];
        print("获取到的结果：$resultData");
        if (token!.isNotEmpty) {
          PopupUntil.showToast(resultData['msg']);
          Shared.setStringData("token",jsonEncode(resultData));
          Shared.setIntData('aftertime',saveTime());

          context.read<GlobalState>().changeUserInfo(resultData);
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>
              MainHome()), (route) => false);
        }else{
          Navigator.pop(context);
        }
      } else {
        PopupUntil.showToast("能不能上传照片？");
      }
    }
  }

}