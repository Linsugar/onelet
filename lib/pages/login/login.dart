
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:onelet/network/requests.dart';
import 'package:onelet/provider/grobleState.dart';
import 'package:onelet/until/CommonUntil.dart';
import 'package:onelet/until/shared.dart';
import 'package:onelet/until/showtoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:onelet/pages/login/register.dart';
import '../../main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key ?key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{
  GlobalKey<FormState> ?_fromglobalKey = GlobalKey<FormState>();
  TextEditingController ?_Usercontroller  =TextEditingController();
  TextEditingController ?_Pwdcontroller  =TextEditingController();
  FocusNode User_focusNode =FocusNode();
  FocusNode Pwd_focusNode =FocusNode();
  var _userdata;

  @override
  void initState(){
    User_focusNode.unfocus();
    Pwd_focusNode.unfocus();
    super.initState();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: (){
            User_focusNode.unfocus();
            Pwd_focusNode.unfocus();
          },
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Flex(direction: Axis.vertical,children: [
                  Expanded(flex: 5,child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/first.jpg')
                            ,fit: BoxFit.cover
                        )
                    ),
                  ),),
                  Expanded(flex: 5,child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft:Radius.circular(10),topRight: Radius.circular(10)),
                    ),
                    child:Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                            top: -10,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.only(left: 10,right: 10),
                              decoration: BoxDecoration(
                              color: Colors.white,
                                boxShadow: [BoxShadow(color: Colors.white30,spreadRadius: 0.2,offset: Offset(0.0,-1.0))],
                                borderRadius: BorderRadius.only(topLeft:Radius.circular(10),topRight: Radius.circular(10)),
                              ),
                              height: MediaQuery.of(context).size.height/2+10,
                              child: fromSubmit(),
                            ))
                      ],
                    ),
                  )),

                ],)
              ],
            ),
          ),
        ),
      )
    );

  }

  Widget fromSubmit(){
    return Form(
      autovalidateMode: AutovalidateMode.always,
      key: _fromglobalKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextFormField(
            focusNode: User_focusNode,
            controller: _Usercontroller,
            keyboardType: TextInputType.phone,
            maxLength: 13,
            validator: (user){
              if(user!.isEmpty || user.length<5){
                return "用户名有误";
              }return null;
            },
            decoration: InputDecoration(
                hintText: "请输入手机号码",
                icon: FaIcon(FontAwesomeIcons.mobileAlt,color: Colors.blue,)),),
          TextFormField(
            focusNode: Pwd_focusNode,
            onFieldSubmitted: (value){
              relogin(_userdata);
            },
            validator: (pwd){
              if(pwd!.isEmpty || pwd.length<5){
                return "密码有误";
              }return null;
            },
            textInputAction: TextInputAction.done,
            obscureText: true,
            keyboardType:TextInputType.number ,
            controller: _Pwdcontroller,
            decoration: InputDecoration(
              hintText: "请输入密码",
              icon:FaIcon(FontAwesomeIcons.key,color: Colors.blue,),),
            maxLength: 15,

          ),
          Flex(direction: Axis.horizontal,children: [
            Expanded(flex: 6,child: Container(height:50,
              child: ElevatedButton.icon(onPressed: (){
                if( _fromglobalKey!.currentState!.validate()){
                  _userdata = FormData.fromMap({
                    'user_mobile':_Usercontroller?.text,
                    'password':_Pwdcontroller?.text
                  });}
                relogin(_userdata);
              }, icon: FaIcon(FontAwesomeIcons.signInAlt), label: Text("登录")),
            )),
            SizedBox(width: 10,),
            Expanded(flex: 4, child: Container(
                height: 50,
                child:ElevatedButton.icon(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                        shape:MaterialStateProperty.all(BeveledRectangleBorder(borderRadius: BorderRadius.circular(20))) )
                    ,onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Regitser()));
                }, icon: FaIcon(FontAwesomeIcons.signInAlt), label: Text("注册"))),
            ),
          ],),
          MaterialButton(onPressed: (){
//                              Wx.wxlogin();
            PopupUntil.showToast("功能暂未开放");
          },child: Text("微信登录"),)
        ],
      ),
    );
  }

  Future relogin(userdata) async {
      var loginResult =  await Request.setNetwork('user/',userdata);
      Provider.of<GlobalState>(context,listen: false).changeloads(false);
      try{
        if(loginResult['token'] !=null &&  loginResult['msg'] == "成功"){
          Shared.setStringData("token",jsonEncode(loginResult));
          Shared.setIntData('aftertime',saveTime());

          context.read<GlobalState>().changeUserInfo(loginResult);
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>
              MainHome()), (route) => false);
        }else{
          PopupUntil.showToast(loginResult['msg']);
        }
      }catch(e){
        print("错误：$e");
      }
      return loginResult;
    }
  }






