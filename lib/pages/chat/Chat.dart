import 'package:onelet/network/requests.dart';
import 'package:onelet/pages/chat/model/chatdynamic.dart';
import 'package:onelet/provider/grobleState.dart';
import 'package:onelet/until/CommonUntil.dart';
import 'package:onelet/until/showtoast.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Chat extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Chatstate();
  }
}

class Chatstate extends State<Chat>  with SingleTickerProviderStateMixin{
  String _headerimag = 'http://qr0n4nltx.hn-bkt.clouddn.com/p3.jpg';
  TabController ?_tabController;
  TextEditingController _textEditingController =TextEditingController();
  FocusNode _focusNode =FocusNode();
  int paGeIndex= 0;

  @override
  void initState() {
    _focusNode.unfocus();
    // Roogyun.rooglistn(context);
    _tabController = TabController(length: 2, vsync: this);
    _tabController!.addListener(() {
      print(_tabController!.index);
      _focusNode.unfocus();
      setState(() {
        paGeIndex = _tabController!.index;
      });

    });
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    // TODO: implement build
    return  Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize:  Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(244, 107, 69, 1),
                    Color.fromRGBO(238, 168, 73, 1),
                  ]
                )
              ),
            ),
            bottom: TabBar(
              isScrollable: false,
              labelColor: Colors.white,
              indicatorColor: Colors.orange,
              unselectedLabelColor: Colors.black,
              labelPadding: EdgeInsets.all(10),
              controller: _tabController!,

              tabs: [
                Text("动态"),
                Text("聊天"),
              ],),),
        ),
        body:Flex(
          direction: Axis.vertical,
          children: [
            paGeIndex==0?Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(flex: 8,child: homeInput(_textEditingController,_focusNode)),
                  Expanded(flex: 1,child: InkWell(onTap: (){
                    Navigator.pushNamed(context, '/mydynamic');
                  },child: FaIcon(FontAwesomeIcons.thList,color: Colors.orange,))),
                  Expanded(flex: 1,child: InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed('/updynamic');
                    },
                    child: FaIcon(FontAwesomeIcons.edit,color: Colors.orange,),
                  )),
                ],)):Container(),
            Expanded(
              flex: 9,
                child:TabBarView(
                controller: _tabController!,
                children: [
                  DynamicPage(),
                  ChatPage(_size,_headerimag,context),
              ],
            ))
          ],
        )
    );
  }
}

Widget ChatPage(size,headerimag,context){
  return SingleChildScrollView(
    child: Container(padding: EdgeInsets.only(top: 10),width: size.width,height: size.height,
      child: Column(
        children: [
          header(context),
          Expanded(
            child: FutureBuilder(
              // future: Roogyun.getallConversation(),
              builder: (BuildContext context, AsyncSnapshot snapshot){
                print("加载状态：${snapshot.data}");
                if(snapshot.connectionState ==ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator());
                }if(snapshot.hasError){
                  return Center(child: Text("您当前还未与其他人有过聊天哦~"));
                }
                else{
                  return Column(
                    children: [
                      Expanded(flex: 1,child: ListTile(
                        key: UniqueKey(),
                        subtitle: Text("在这里可以与许多不同的朋友一起畅聊生活琐事",overflow: TextOverflow.ellipsis,maxLines: 1,),
                        leading: ClipRRect(borderRadius: BorderRadius.circular(5),child: Image.network(headerimag),),
                        title: Text("聊天广场"),trailing: MaterialButton(
                          onPressed: (){
//                    print("点击");
//                    _Amc?.forward();
//                    Navigator.pushNamed(context,'/chatChild',arguments:{
//                      'userinfo': snapshot.data
//                    });
                            PopupUntil.showToast("当前功能正在开发中~");
                          },child: Icon(Icons.pan_tool,color: Colors.cyan,)),)),
                      Expanded(flex:8,child: ListView.separated(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context,index){
                          return ListTile(
                            key: UniqueKey(),
                            subtitle: Text("${snapshot.data[index].user_context}",overflow: TextOverflow.ellipsis,maxLines: 1,),
                            leading: CircleAvatar(backgroundImage: NetworkImage(snapshot.data[index].avator_image),),
                            title: Text(snapshot.data[index].name),trailing: MaterialButton(onPressed: (){
                            print("点击$index");
                            Navigator.pushNamed(context,'/chatChild',arguments:{
                              'userinfo': snapshot.data[index]
                            });
                          },child: FaIcon(FontAwesomeIcons.commentDots)),);
                        },separatorBuilder: (context,index){
                        return Divider();
                      },))
                    ],
                  );
                }
              },
            ),
          )
        ],
      ),),
  );
}


//聊天
//class ChatPage extends StatelessWidget {
//  const ChatPage({
//    Key? key,
//    required Size size,
//    required String headerimag,
//  }) : _size = size, _headerimag = headerimag,super(key: key);
//
//  final Size _size;
//  final String _headerimag;
//
//  @override
//  Widget build(BuildContext context) {
//    return SingleChildScrollView(
//      child: Container(padding: EdgeInsets.only(top: 10),width: _size.width,height: _size.height,
//        child: Column(
//          children: [
//            Header(),
//            Expanded(
//              child: FutureBuilder(
//                future: Roogyun.getallConversation(),
//                builder: (BuildContext context, AsyncSnapshot snapshot){
//                  print("加载状态：${snapshot.data}");
//                  if(snapshot.connectionState ==ConnectionState.waiting){
//                    return Center(child: CircularProgressIndicator());
//                  }if(snapshot.hasError){
//                    return Center(child: Text("您当前还未与其他人有过聊天哦~"));
//                  }
//                  else{
//                    return Column(
//                      children: [
//                        Expanded(flex: 1,child: ListTile(
//                          key: UniqueKey(),
//                          subtitle: Text("在这里可以与许多不同的朋友一起畅聊生活琐事",overflow: TextOverflow.ellipsis,maxLines: 1,),
//                          leading: ClipRRect(borderRadius: BorderRadius.circular(5),child: Image.network(_headerimag),),
//                          title: Text("聊天广场"),trailing: MaterialButton(
//                            onPressed: (){
////                    print("点击");
////                    _Amc?.forward();
////                    Navigator.pushNamed(context,'/chatChild',arguments:{
////                      'userinfo': snapshot.data
////                    });
//                              PopupUntil.showToast("当前功能正在开发中~");
//                            },child: Icon(Icons.pan_tool,color: Colors.cyan,)),)),
//                        Expanded(flex:8,child: ListView.separated(
//                          itemCount: snapshot.data.length,
//                          itemBuilder: (context,index){
//                            return ListTile(
//                              key: UniqueKey(),
//                              subtitle: Text("${snapshot.data[index].user_context}",overflow: TextOverflow.ellipsis,maxLines: 1,),
//                              leading: CircleAvatar(backgroundImage: NetworkImage(snapshot.data[index].avator_image),),
//                              title: Text(snapshot.data[index].name),trailing: MaterialButton(onPressed: (){
//                              print("点击$index");
//                              Navigator.pushNamed(context,'/chatChild',arguments:{
//                                'userinfo': snapshot.data[index]
//                              });
//                            },child: FaIcon(FontAwesomeIcons.commentDots)),);
//                          },separatorBuilder: (context,index){
//                          return Divider();
//                        },))
//                      ],
//                    );
//                  }
//                },
//              ),
//            )
//          ],
//        ),),
//    );
//  }
//}

//动态页
class DynamicPage extends StatefulWidget {

  @override
  _DynamicPageState createState() => _DynamicPageState();
}

class _DynamicPageState extends State<DynamicPage>{
  List<chatdynamic> dylist = [];
  FocusNode _focusNode = FocusNode();
  ScrollController _scrollController =ScrollController();

  //  获取动态
  _getDynamic()async{
    List dynamciList = [];
    var result = await Request.getNetwork('DyImage/',token:context.read<GlobalState>().userInfo['token']);
    result.forEach((value){
      dynamciList.add(chatdynamic(value));
    });
    if(mounted){
      context.read<GlobalState>().changeDynamicList(dynamciList);
    }
    return dynamciList;
  }

  @override
  void initState() {
    _focusNode.unfocus();
    _scrollController.addListener(() {
      _focusNode.unfocus();
    });
    _getDynamic();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List dataList = context.watch<GlobalState>().dynamicList;
    return RefreshIndicator(
      onRefresh: (){
        return _getDynamic();
      },
      child:dynamicList(dataList),
    );
  }
  Widget dynamicList(List snapshot){
    print("dongtai:$snapshot");
    if(snapshot ==null){
      return Center(child: Text("请等待数据加载"));
    }
    return ListView.separated(
      physics: AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        itemBuilder: (context,index){
          return  Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: CircleAvatar(backgroundImage: NetworkImage(snapshot[index].avator),),
                  title: Text("${snapshot[index].title}"),
                  subtitle:  Text("发布时间:${snapshot[index].time}"),
                ),
                Container(
                    margin: EdgeInsets.only(left: 5),
                    constraints: BoxConstraints(
                      maxHeight: 100,
                      minHeight: 10,
                    ),
                    child:  Text("${snapshot[index].con}",textAlign: TextAlign.start,maxLines: 3,overflow:TextOverflow.ellipsis)
                ),
                SizedBox(height: 10),
                Container(
                  constraints: BoxConstraints(
                    minHeight:50,
                    maxHeight: 120,
                  ),
                  child:Column(
                    children: [
                      Expanded(flex: 3,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context,im){
                              return Container(
                                margin: EdgeInsets.only(left: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        image: NetworkImage(snapshot[index].imagelist[im]),
                                        fit: BoxFit.cover
                                    )
                                ),
                                width: MediaQuery.of(context).size.width/4.5,
                              );
                            }, separatorBuilder: (context,im){
                          return SizedBox(width: 5,height: 5,);
                        }, itemCount: snapshot[index].imagelist.length),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            MaterialButton(child: Text("点赞"),onPressed: (){}),
                            MaterialButton(child: Text("评论"),onPressed: (){
                              Navigator.pushNamed(context,'/reviewCpn',arguments:{'data':snapshot[index]} );
                            }),
                          ],),
                      ),
                    ],
                  ) ,
                )
              ],
            ),
          );
        }, separatorBuilder: (context,index){
      return  Divider();
    }, itemCount: snapshot.length);
  }

}

//聊天头部展示所有用户
Widget header(context){
  var sPDate =Provider.of<GlobalState>(context,listen: false).overuser;
  return Container(
      height: 80,
      padding: EdgeInsets.all(5),child:
  ListView.separated(scrollDirection: Axis.horizontal,itemBuilder: (context,index){
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context,'/chatChild',arguments:{
          "userinfo":sPDate![index]
        });
      },
      child: Container(
          height: 50,
          width: 50,
          margin: EdgeInsets.all(5),decoration: BoxDecoration(border: Border.all(color: Colors.white,width: 2.0),shape:BoxShape.circle ,
          boxShadow: [BoxShadow(color: Colors.blue,offset: Offset(0.0,1.0))],image: DecorationImage(image: NetworkImage(sPDate![index].avator_image),fit: BoxFit.cover)
      )),
    );
  },itemCount: sPDate!.length,separatorBuilder: (context,index){
    return SizedBox(width: 10,);
  },)
  );
}

