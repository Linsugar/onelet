import 'package:onelet/network/requests.dart';
import 'package:onelet/provider/homeState.dart';
import 'package:onelet/until/showtoast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:onelet/provider/grobleState.dart';

class ReviewCpn extends StatefulWidget {
  Map ?arguments;
  ReviewCpn(this.arguments);
  @override
  _ReviewCpnState createState() => _ReviewCpnState();
}

class _ReviewCpnState extends State<ReviewCpn> {
  var argdata;
  TextEditingController _textEditingController = TextEditingController();
  ScrollController  _scrollController = ScrollController();
  FocusNode _focusNode = FocusNode();
  List ?_imagelist = [];
  @override
  void initState() {
    // TODO: implement initState
    argdata = widget.arguments!['data'];
    print("argdata   :${argdata.Dynamic_Id}");
    _imagelist = argdata.imagelist!;
    _getreview();

    super.initState();
  }

  _getreview()async{
    var userInfo = context.read<GlobalState>().userInfo;
//    获取所有评论
    Provider.of<homeState>(context,listen: false).reviewlist.clear();
    var _result = await Request.getNetwork('review/',
        params: {
          "review_dynamic":argdata.Dynamic_Id
        },
        token: userInfo['token']);
    _result.forEach((value){
      Provider.of<homeState>(context,listen: false).changereview(value);
    });
    return _result;
  }

  _postreview()async{
//    发布评论
    var userInfo = context.read<GlobalState>().userInfo;
    var _result = await Request.setNetwork('review/',{
      'review_userid':userInfo['user_id'],
      'recview_avator':userInfo['avator_image'],
      'review_content':_textEditingController.text,
      'review_name':userInfo['user_name'],
      'review_bool':1,
      'review_dynamicid':argdata.Dynamic_Id,
    },token: userInfo['token']);
    if(_result['msg'] == "成功" && _result['code']==200){
      PopupUntil.showToast(_result['msg']);
      _focusNode.unfocus();
      _getreview();
    }else{
      PopupUntil.showToast(_result['msg']);
      return;
    }
  }

  @override
  void didUpdateWidget(covariant ReviewCpn oldWidget) {
    // TODO: implement didUpdateWidget
    print("旧的：$oldWidget");
    super.didUpdateWidget(oldWidget);
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    print("节点改变");
    super.didChangeDependencies();
  }



  @override
  Widget build(BuildContext context) {
    List snda = context.watch<homeState>().reviewlist;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(  flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(244, 107, 69, 1),
                  Color.fromRGBO(238, 168, 73, 1),
                ],
              )
          ),
        ),title: Text("详情"),),
        body: RefreshIndicator(
          onRefresh: (){
            return  _getreview();
          },
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleContent(),
                  Row(children: [
                    SizedBox(width: 5,),Text("评论",textAlign:TextAlign.start,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),],),
                  Expanded(flex: 5,child:snda.isEmpty?Center(child: Text("暂无评论，快来做第一个吧")):ListView.separated(
                      physics: AlwaysScrollableScrollPhysics(),
                      controller: _scrollController,
                      itemBuilder: (context,index){
                        return ListTile(
                          leading: CircleAvatar(backgroundImage: NetworkImage(snda[index]['recview_avator']),),
                          title: Text("${snda[index]['review_name']}"),
                          subtitle: Text("${snda[index]['review_content']}"),
                          trailing: Text("${snda[index]['review_time']}"),
                        );
                      }, separatorBuilder: (context,index){
                    return Divider();
                  }, itemCount: snda.length)),
                  Row(
                    children: [
                      Expanded(flex: 7,child:  Container(

                        child: TextField(
                          focusNode: _focusNode,
                          controller: _textEditingController,maxLines: 1,
                          decoration: InputDecoration(

                            hintText: "请输入评论内容",
                          ),),
                      )),
                      Expanded(flex: 3,child: MaterialButton(child: Text("发送"),onPressed: ()async{
                        if(_textEditingController.text.isNotEmpty){
                          await _postreview();
                          _textEditingController.clear();
                        }
                      },))
                    ],
                  )
                ],
              ),
            ),
          ),
        )
    );
  }

  Widget titleContent(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: CircleAvatar(backgroundImage: NetworkImage(argdata.avator),),
          title: Text("${argdata.title}"),
          subtitle:  Text("发布时间:${argdata.time}"),
        ),
        Container(
            margin: EdgeInsets.only(left: 5),
            constraints: BoxConstraints(
              maxHeight: 100,
              minHeight: 30,
            ),
            child:  Text("${argdata.con}",textAlign: TextAlign.start,maxLines: 3,overflow:TextOverflow.ellipsis)
        ),
        SizedBox(height: 10),
        Container(
          height: 100,
          child:ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,im){
                return Container(
                  margin: EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          image: NetworkImage(_imagelist![im]),
                          fit: BoxFit.cover
                      )
                  ),
                  width: 80,
                );
              }, separatorBuilder: (context,im){
            return SizedBox(width: 5,height: 5,);
          }, itemCount:_imagelist!.length),
        ),
      ],
    );
  }

}
