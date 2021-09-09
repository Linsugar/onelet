
import 'package:dio/dio.dart';
import 'package:onelet/network/requests.dart';
import 'package:onelet/provider/grobleState.dart';
import 'package:onelet/until/showtoast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//反馈
class FeedBook extends StatefulWidget {
  @override
  _FeedBookState createState() => _FeedBookState();
}

class _FeedBookState extends State<FeedBook> {

  TextEditingController _editingController = TextEditingController();
  var userinfo;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    userinfo = context.watch<GlobalState>().userInfo;
    return Scaffold(
      appBar: AppBar(title: Text("反馈"),actions:[GestureDetector(onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>feedhistory(userinfo)));
      },child: Container(margin: EdgeInsets.only(right: 10),child: Center(child: Text("反馈记录"))))],),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Column(
          children: [
            PhysicalModel(
              color: Colors.blueAccent,
              child: Container(margin: EdgeInsets.all(5),decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.blueGrey,width: 1.0)),child: TextField(maxLines: 10,controller: _editingController,)),
            ),
            MaterialButton(color: Colors.blueAccent[100],onPressed: ()async{
              print('输入框：${_editingController.text}');
              if(_editingController.text.isEmpty){
                PopupUntil.showToast('你是逗比嘛？啥子都不写？反馈个什么？小心封你号!!!');
              }else{
                var fromdata = FormData.fromMap({
                  'feed_id':userinfo['user_id'],
                  'feedback_context':_editingController.text,
                });

                var result = await Request.setNetwork('feedback/',fromdata,token: userinfo['token']);
                print("结果:${result}");
                PopupUntil.showToast('反馈成功，我们工作人员将会跟进，谢谢你的配合');
                Future.delayed(Duration(seconds: 1)).then((value) => {
                  Navigator.pop(context)
                });
              }


            },child: Text("反馈"),)
          ],
        ),
      ),
    );
  }
}

//反馈记录

class feedhistory extends StatelessWidget {
  var userinfo;
  feedhistory(this.userinfo);


  @override
  Widget build(BuildContext context) {
    Future _gethistory()async{
      var result = await Request.getNetwork('feedback/',params: {
        'feed_id':userinfo['user_id']
      },token: userinfo['token']);
      print('结果：$result');
      return result;
    }
    return Scaffold(
      appBar: AppBar(flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(244, 107, 69, 1),
                Color.fromRGBO(238, 168, 73, 1),
              ],
            )
        ),
      ),title: Text("反馈记录"),),
      body: FutureBuilder(
        future:_gethistory() ,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasError){
            return Text("数据有误,请稍后再查看~");
          }
          if(snapshot.connectionState ==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          else{
            return ListView.builder(itemCount: snapshot.data.length,itemBuilder: (context,index){
              return Container(
                  height: 100,
                  child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("内容：${snapshot.data[index]['feedback_context']}"),
                          ],
                        ),
                        Divider(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("${snapshot.data[index]['feedback_time']}")
                        ],
                        ),
                    ],
              ),
              );
              });
          }
        },
      ),
    );
  }
}

