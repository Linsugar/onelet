//话题管理


import 'dart:convert';
import 'package:onelet/pages/ToPic/ToPicHome.dart';
import 'package:onelet/pages/mine/model/family.dart';
import 'package:onelet/until/showtoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class ToPiCpn extends StatefulWidget {
  @override
  _TopicCpn createState() => _TopicCpn();
}

class _TopicCpn extends State<ToPiCpn> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _Manger()async{
    List Mang = [];
    return Mang;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          ),title:Text("话题",)),
      body: Container(
        child: FutureBuilder(
          future: _Manger(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.connectionState ==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }if(snapshot.hasData){
            List snd = snapshot.data;
            if(snd.isEmpty){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("您当前没有团队，请自行选择一个加入"),
                    Row(
                      mainAxisAlignment:MainAxisAlignment.center,
                      children: [
                        MaterialButton(child: Text("创建团队"),onPressed: (){
                          Navigator.pushNamed(context, '/createGroup');
                        }),
                        MaterialButton(child: Text("加入团队"),onPressed: (){
//
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Topic()));
                        }),
                      ],
                    )
                  ],
                ),
              );
            }
            else{
              return Text("加入");

            }
          }
          else{
            return Center(child: Text("请稍后"),);
          }
        },),
      ),
    );
  }
}

