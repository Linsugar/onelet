import 'package:onelet/provider/grobleState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MyUi extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyUiState();
  }
}


class MyUiState extends State<MyUi>{

@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var userInfo = context.watch<GlobalState>().userInfo;
    return Scaffold(
        body: Container(
          child: Flex(
            direction: Axis.vertical,
            children: [
              Expanded(flex: 1,child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('images/my.png')
                    )
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                        left: 30,
                        bottom: 5,
                        child: Container(width: 100,height: 100,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              image: DecorationImage(
                                  image: NetworkImage(userInfo["avator_image"]),
                                  fit: BoxFit.cover
                              ),
                              borderRadius: BorderRadius.circular(50)
                          ),
                        ))
                  ],
                ),
              )),
              Expanded(flex: 3,child: Flex(
                direction: Axis.vertical,
                children: [
                  Expanded(flex: 1,child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 20,right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${userInfo["user_name"]}",style: TextStyle(
                                fontSize: 20,
                                fontWeight:FontWeight.w800 ),),
                            Text("身高-cm;体重-kg"),
                          ],
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.pushNamed(context,'/mysetting');
                          },
                          child: Container(width: 50,height: 50,decoration: BoxDecoration(
                              color: Colors.orange[700],
                              boxShadow: [BoxShadow(color: Colors.redAccent,blurRadius: 2.2,)],
                              borderRadius: BorderRadius.circular(50)),
                            child: Center(child: FaIcon(FontAwesomeIcons.edit,color: Colors.white,)),
                          ),
                        )
                      ],
                    ),
                  )),
                  Expanded(flex:6,child: Container(
                    color: Colors.white,
                    child: ListView(
                      padding: EdgeInsets.all(5),
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [BoxShadow(color: Colors.black45,blurRadius: 1.2,offset: Offset(0.0,1.0))]
                          ),
                          child: Column(
                            children: [
                              ListTile(leading: FaIcon(FontAwesomeIcons.ticketAlt),title: Text("优惠卷"),trailing: FaIcon(FontAwesomeIcons.angleRight),),
                              Divider(indent: 20,endIndent: 20,),
                              ListTile(
                                leading: FaIcon(FontAwesomeIcons.yenSign),title: Text("我的积分"),trailing: FaIcon(FontAwesomeIcons.angleRight),
                                onTap: (){
                                  Navigator.pushNamed(context, '/interg');
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [BoxShadow(color: Colors.black45,blurRadius: 1.2,offset: Offset(0.0,1.0))]
                          ),
                          child: Column(
                            children: [
                              ListTile(onTap: (){
                                Navigator.pushNamed(context, '/services');
                              },leading: FaIcon(FontAwesomeIcons.heartbeat),title: Text("所有服务"),trailing: FaIcon(FontAwesomeIcons.angleRight),),
                              Divider(indent: 20,endIndent: 20,),
                              ListTile(
                                leading: FaIcon(FontAwesomeIcons.shoppingCart),title: Text("购买服务套餐"),trailing: FaIcon(FontAwesomeIcons.angleRight),
                                onTap: (){
                                  Navigator.pushNamed(context, '/task');
                                },),
                              Divider(indent: 20,endIndent: 20,),
                              ListTile(onTap: (){
                                Navigator.pushNamed(context, "/order");
                              },
                                leading: FaIcon(FontAwesomeIcons.clipboard),title: Text("服务订单"),
                                trailing: FaIcon(FontAwesomeIcons.angleRight),),
                              Divider(indent: 20,endIndent: 20,),
                              ListTile(leading: FaIcon(FontAwesomeIcons.clipboardList),title: Text("我的相册"),trailing: FaIcon(FontAwesomeIcons.angleRight),onTap: (){
                                Navigator.pushNamed(context, "/Photos");
                              },),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [BoxShadow(color: Colors.black45,blurRadius: 1.2,offset: Offset(0.0,1.0))]
                          ),
                          child: Column(
                            children: [
                              ListTile(leading: FaIcon(FontAwesomeIcons.cogs),title: Text("设置"),trailing: FaIcon(FontAwesomeIcons.angleRight),onTap: (){
                                Navigator.of(context).pushNamed('/servesetting');
                              },),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [BoxShadow(color: Colors.black45,blurRadius: 1.2,offset: Offset(0.0,1.0))]
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                onTap: (){
                                  sharePage(context);
                                },
                                leading: FaIcon(FontAwesomeIcons.shareAlt),title: Text("分享"),
                                trailing: FaIcon(FontAwesomeIcons.angleRight),),
                              Divider(indent: 20,endIndent: 20,),
                              ListTile(leading: FaIcon(FontAwesomeIcons.globeAsia),title: Text("肾上线"),trailing: FaIcon(FontAwesomeIcons.angleRight),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ))
                ],
              )),
            ],
          ),
        )
    );
  }
}



//渠道分享
void sharePage(context){
  showDialog(context: context, builder: (_){
    return Dialog(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
               Column(
                 children: [
                   FaIcon(FontAwesomeIcons.weixin,color: Colors.green,),
                   Text("微信好友")
                 ],
               ),
                Column(
                  children: [
                    FaIcon(FontAwesomeIcons.users,color: Colors.greenAccent,),
                    Text("朋友圈")
                  ],
                ),
                Column(
                  children: [
                    FaIcon(FontAwesomeIcons.shower,color: Colors.blue[200],),
                    Text("收藏到微信")
                  ],
                ),
                Column(
                  children: [
                    FaIcon(FontAwesomeIcons.link,color: Colors.deepOrange,),
                    Text("复制链接")
                  ],
                ),
              ],
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.orange),
              ),
              child: Text("取消"),onPressed: (){
              Navigator.pop(context);
            },)
          ],
        ),
        height: 120,
      ),
    );
  });
}