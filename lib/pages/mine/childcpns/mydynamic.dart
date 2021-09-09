
import 'package:onelet/network/requests.dart';
import 'package:onelet/provider/grobleState.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'getdynamic.dart';

class MyDynamic extends StatefulWidget {
  @override
  _MyDynamicState createState() => _MyDynamicState();
}

class _MyDynamicState extends State<MyDynamic> {
  var imagefile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _getUserdynamic()async{
    var userinfo = context.read<GlobalState>().userInfo;
    List<dynamicdata> dy =[];
    dy.clear();
   var result = await Request.getNetwork('DyImage/',params: {
      'user_id':userinfo['user_id']
    },token:userinfo['token'] );
   print("获取自身的动态");
   result.forEach((value){
       dy.add(dynamicdata(value));
   });
   return dy;
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
          ),
          title: Text("动态"),actions: [MaterialButton(onPressed: ()async{
        },
          child: GestureDetector(onTap: (){
            Navigator.pushNamed(context, '/updynamic');
          },child: Text("发布动态")),)],),
        body: RefreshIndicator(
          onRefresh: ()=>_getUserdynamic(),
          child: Container(
              child: FutureBuilder(
                future:_getUserdynamic(),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  print('状态：${snapshot.data}');
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator());
                  }
                  if(snapshot.hasError){
                    return Center(child: Text("产生了一点小问题，请稍后"),);
                  }
                  if(snapshot.data.isEmpty){
                    return Center(child: Text("您当前还未发布动态哟~"),);
                  }
                  else{
                    return ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                        itemCount: snapshot.data.length,itemBuilder: (context,index){
                      print(snapshot.data);
                      return Card(
                        child: Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(backgroundImage: NetworkImage(snapshot.data[index].avator),),
                              title: Text("${snapshot.data[index].title}"),
                              subtitle:  Text("发布时间:${snapshot.data[index].time}"),
                            ),
                            Container(
                              height: 150,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text("${snapshot.data[index].context}",maxLines: 5,overflow: TextOverflow.ellipsis,),
                                  Expanded(flex: 5,child: Row(mainAxisAlignment: MainAxisAlignment.start,children: [
                                    for(var i=0;i<snapshot.data[index].imageurl!.length;i++)
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            image: DecorationImage(
                                              image: NetworkImage(snapshot.data[index].imageurl![i]),fit: BoxFit.cover,
                                            )
                                        ),
                                        margin: EdgeInsets.all(5),width: MediaQuery.of(context).size.width/4.5,
                                      )
                                  ],)),
                                ],
                              ),
                            )
                          ],),
                      );
                    });
                  }
                },
              )
          ),
        )
    );
  }
}
