import 'dart:async';
import 'dart:convert';
import 'package:onelet/provider/grobleState.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onelet/roog/roogYun.dart';

class ChatChild extends StatefulWidget{
  Map ?arguments;
  ChatChild(this.arguments);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ChatChildState();
  }
}

class ChatChildState extends State<ChatChild>{
  var _streamController = StreamController<String>();
  var _textController = TextEditingController();
  var userInfo;
  FocusNode focusNode = FocusNode();
  ScrollController _controller = ScrollController();
  bool inputBool = false;
  bool emjStatue = true;

  @override
  void initState() {
    userInfo = widget.arguments!['userinfo'];
    // Roogyun.getConversation(userInfo.userid);
    getallmeg();
    getlistn();
    checkfoucde();
    _getemijdata();
    super.initState();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }
//获取emjo
  _getemijdata()async{
    var _data = await rootBundle.loadString('data/emij.json');

    var result = jsonDecode(_data);
    print("长度：${result.runtimeType}");
   for(var i=0;i<100;i++){
     Provider.of<GlobalState>(context,listen: false).changeemij(result[i]);
   }
  }

  checkfoucde(){
    focusNode.addListener(() {
      if(focusNode.hasFocus){
        print("焦点");
      }else{
        print("失去焦点");
      }
    });
  }
//获取融云历史消息
  getallmeg()async{
    // await Roogyun.roogHistoryMessages(userInfo.userid,context);
  }
//  对融云进行监听
  getlistn()async{
    // await Roogyun.rooglistn(context);
  }

  @override
  Widget build(BuildContext context) {
    var state =context.watch<GlobalState>();
    return Scaffold(
      appBar: AppBar(title: Text(userInfo.name),actions: [CircleAvatar(backgroundImage: NetworkImage(userInfo.avator_image)),SizedBox(width: 10,)],),
      body:WillPopScope(
        onWillPop: ()async{
          Provider.of<GlobalState>(context,listen: false).clearhistory();
          return true;
        },
        child: Column(
          children: [
            Flexible(child:
              Container(
              width: double.infinity,
              height: double.infinity,
              child: ListView.separated(
                  controller: _controller,
                  itemBuilder: (context,index){
                    var data = state.historylist![index];
                    return state.historylist![index].senderUserId==userInfo.userid?talkLeft(userInfo,data):talkRight(state,data);
                  }, separatorBuilder: (context,index){
                return Divider();
              }, itemCount: state.historylist!.length),
            )),
            Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    border:Border.all(color: Colors.blue,width: 1)
                ),
                child:Flex(
                  direction: Axis.horizontal,
                  children: [
                    FaIcon(FontAwesomeIcons.microphoneAlt),
                    SizedBox(width: 10,),
                    Expanded(
                        flex: 7,child: Container(
                        child: TextField(
                          onChanged: (value){
                            if(value.isEmpty){
                              setState(() {
                                inputBool = false;
                              });
                            }else{
                              setState(() {
                                inputBool = true;
                                emjStatue =true;
                              });
                            }
                          },
                          focusNode: focusNode,
                          controller: _textController,
                          minLines: 1,
                          maxLines: 2,decoration: InputDecoration(
                          isCollapsed: true,
                          hintText: "请输入内容",
                          hintMaxLines: 20,
                          border: InputBorder.none,
                        ),)
                    )),
                    Expanded(
                        flex:3,child:Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
                        Icon(Icons.add_circle),
                        inputBool?
                        Container(
                          width: 50,
                          child: Material(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.blue,
                              child:InkWell(
                                onTap: (){
                                  Fluttertoast.showToast(msg: "该功能暂时不开放");
//                                  if(_textController.text.isEmpty){
//                                    Fluttertoast.showToast(msg: "你输入的内容为空");
//                                    return;
//                                  }
//                                  print("当前输入内容：${_textController.text},当前userid:${userInfo.userid}");
//                                  Roogyun.sedMessage(_textController.text,userInfo.userid,context);
//                                  _textController.clear();
//                                  setState(() {
//                                    inputBool =false;
//                                    emjStatue =true;
//                                  });
                                },
                                child: Container(
                                  child: Center(child: Text("发送")),
                                ),
                              )
                          ),
                        ): GestureDetector(onTap: (){

                          setState(() {
                            emjStatue =!emjStatue;
                          });
                        },child: FaIcon(FontAwesomeIcons.smileWink))
                      ],),
                    ))
                  ],
                )),
            emjStatue?Container():emjContainer(_textController,state)
          ],
        ),
      ),
    );
  }
}

//聊天表情
Widget emjContainer(text,state){
  return Container(
    height: 140,
    color: Colors.blueGrey,
    child: PageView(
      children: [
        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 10,
          ), itemBuilder: (context,index){
          return GestureDetector(
              onTap: (){
                text.text = "${text.text}" + "${String.fromCharCode(state.emij![index]['unicode'])}";
              },
              child: Text("${String.fromCharCode(state.emij![index]['unicode'])}"));
        },itemCount: 40,),
      ],
    ),
  );
}

//左
Widget talkLeft(userInfo,data){
  return ListTile(
    leading: CircleAvatar(backgroundImage: NetworkImage(userInfo.avator_image),),
//      title: Text("${Data.senderUserId}"),
    subtitle: Text("${data.content.content}"),
  );
}

//右
Widget talkRight(state,data){
  return ListTile(
    subtitle: Text("${data.content.content}",textAlign: TextAlign.right,style: TextStyle(),),
    trailing: CircleAvatar(backgroundImage: NetworkImage(state.avator!),),
  );
}

