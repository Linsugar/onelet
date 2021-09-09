import 'package:onelet/network/requests.dart';
import 'package:onelet/provider/grobleState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class MySetting extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MySettingState();
  }
}

class MySettingState extends State<MySetting>{
  @override
  void initState(){
    super.initState();
  }

  getuserdata()async{
   var result = await Request.getNetwork('user/',params: {'user_id':context.read<GlobalState>().userInfo['user_id']});
   print("result:${result}");
   return result;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
        ),
        title: Text("个人信息"),actions: [MaterialButton(onPressed: (){},child: Text("保存"),)],),
      body: FutureBuilder(
        future:getuserdata() ,
        builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.hasError){
          // ignore: dead_code
          return Center(child: Text("数据加载有误"));
        }
        if(snapshot.connectionState ==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }else{
          return Container(child: Flex(direction: Axis.vertical,children: [
            Flexible(flex: 4,child: Container(
                padding: EdgeInsets.only(left: 10),
                margin: EdgeInsets.only(top: 5,bottom: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black45,offset: Offset(0.0,1.0),spreadRadius: 1.0,blurRadius: 10.0)]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Row(children: [Text("头像"),],),
                      Row(children: [
                        CircleAvatar(backgroundImage: NetworkImage(snapshot.data['avator_image']),),Icon(Icons.chevron_right)
                      ],)],),
                    Centerwiget(name: "昵称", dircetion: "${snapshot.data['username']}"),
                    Centerwiget(name: "性别", dircetion: "女"),
                    Centerwiget(name: "ID", dircetion: "${snapshot.data['user_id']}"),
                    Centerwiget(name: "个性签名", dircetion: "千年轮回"),],
                )
            ),
            ),
            Flexible(flex: 3,child:  Container(
                padding: EdgeInsets.only(left: 10),
                margin: EdgeInsets.only(top: 5,bottom: 5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black45,offset: Offset(0.0,1.0),spreadRadius: 1.0,blurRadius: 10.0)]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Centerwiget(name: '生日',dircetion: '2月06日',),
                    Centerwiget(name: '星座',dircetion: '水瓶座',),
                    Centerwiget(name: '地区',dircetion: '${snapshot.data['city']}',)
                  ],
                ))),
            Flexible(flex: 3,child:  Container(
                margin: EdgeInsets.only(top: 5,),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black45,offset: Offset(0.0,1.0),spreadRadius: 1.0,blurRadius: 10.0)]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Endwiget(name: "绑定QQ",dircetion: "8888888",),
                    Endwiget(name: "绑定微信",dircetion: "8888888",),
                    Endwiget(name: "绑定微博",dircetion: "8888888",),
                  ],
                ))),
          ],),);
        }
      },),
    );
  }
}


class Centerwiget extends StatelessWidget {
 final String _name;
 final String _dircetion;
  const Centerwiget({
    Key ?key,
    @required name,
    @required dircetion
  }) :_dircetion = dircetion,_name =name, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Row(children: [Text(_name),],), Row(children: [Text(_dircetion),Icon(Icons.chevron_right)],)],);
  }
}

class Endwiget extends StatelessWidget {
  final String ?_name;
  final String ?_dircetion;
  const Endwiget({
    Key ?key,
    @required String ?name,
    @required String ?dircetion,
  }):_name = name,_dircetion=dircetion,super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Row(children: [Icon(Icons.account_circle),Text(_name!),],), Row(children: [Text(_dircetion!),
      SizedBox(width: 5,),
      MaterialButton(shape:RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))) ,color: Colors.blue,onPressed: (){},child: Text("绑定"),)],)],);
  }
}



//

