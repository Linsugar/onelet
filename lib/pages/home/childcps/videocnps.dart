import 'package:onelet/network/requests.dart';
import 'package:onelet/provider/grobleState.dart';
import 'package:onelet/until/showtoast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
class videoWidget extends StatefulWidget {
  var value;
  videoWidget(this.value);
  @override
  _videoWidgetState createState() => _videoWidgetState();
}
class _videoWidgetState extends State<videoWidget> with WidgetsBindingObserver{
  String ?videoUrl;
  VideoPlayerController ?_videoPlayerController;
  TextEditingController ?_textEditingController;
  ScrollController _scrollController = ScrollController();
  FocusNode _focusNode  =FocusNode();
  int focusIndex =0;
  int playState= 0;
  bool inputbool = false;
  bool emjstatue = true;
  Future ?videoLoading;
  var argumentValue;
  var videoid;
  List? _messageList = [];
  @override
  void initState() {
    _focusNode.unfocus();
    WidgetsBinding.instance!.addObserver(this);
    // TODO: implement initState
    argumentValue = widget.value['value'];
    videoUrl = argumentValue.videoUrl;
    videoid = argumentValue.video_id;
    _textEditingController =TextEditingController();
    _videoPlayerController = VideoPlayerController.network(videoUrl!);
    videoLoading = _videoPlayerController!.initialize();
    getVideoReviews();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _videoPlayerController!.dispose();
    super.dispose();
  }

  getVideoReviews()async{
//    获取当前视频的评论
    List _res = await Request.getNetwork('vifl/',params: {
      'Review_id':videoid
    },token: context.read<GlobalState>().userInfo['token']);
    _messageList = _res;
    setState(() {
    });
    return _messageList;
  }
  sendVideoReview()async{
//    对当前视频进行评论
 var userInfo = context.read<GlobalState>().userInfo;
    var res = await Request.setNetwork('vifl/',{
      "Review_id":videoid,
      "Review_name":userInfo['user_name'],
      "Review_User":userInfo['user_id'],
      "Review_photo":userInfo['avator_image'],
      "Review_Content":_textEditingController!.text
    },token: userInfo['token']);
       print("是否成功：$res");
       if(res["msg"]=="评论成功" &&res["code"]==200){
         PopupUntil.showToast(res["msg"]);
         getVideoReviews();
         setState(() {
           _focusNode.unfocus();
           _textEditingController!.text = "";
         });
         _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
       }else{
         PopupUntil.showToast(res["msg"]);
       }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        title: Text(argumentValue.videoTitle),
        actions: [
          IconButton(icon: Icon(Icons.play_arrow), onPressed: (){
            _videoPlayerController!.play();
          }),
          IconButton(icon: Icon(Icons.height), onPressed: (){})
        ],
      ),
      body:GestureDetector(
        onTap: (){
          _focusNode.unfocus();
        },
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white10,
              child: Column(
                children: [
                  Expanded(flex: 5,child: videoView()),
                  Expanded(flex: 4,child:videoReviews()),
                  SizedBox(height: 50,)
                ],
              ),
            ),
            Positioned(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 8,
                        child: Card(
                          child: Center(
                            child: TextField(
                              controller: _textEditingController,
                              focusNode: _focusNode,
                              decoration: InputDecoration(
                                  prefixIcon:Icon(Icons.search),
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(flex: 2,child: Padding(padding: EdgeInsets.all(3),child: SizedBox(width: double.infinity,height: double.infinity,child: MaterialButton(color: Colors.blue,child: Text("发送"),onPressed: (){
                        sendVideoReview();
                      },))))
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }


Widget videoReviews(){
//    评论组件
    return  ListView.builder(
      controller: _scrollController,
      itemBuilder: (context,index){
        return Container(
          width: double.infinity,
          height: 80,
          child:
          Card(
            child: Row(
              children: [
                Expanded(flex: 2,child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(radius: 25,backgroundImage: NetworkImage("${_messageList![index]["Review_photo"]}"),),
                    Text("${_messageList![index]["Review_name"]}"),
                  ],
                )),
                Expanded(flex: 8,child:  Container(
                  child: Column(
                    children: [
                      Expanded(flex: 7,child: Container(
                          alignment: Alignment.centerLeft,
                          width: double.infinity,height: double.infinity,child:Text("${_messageList![index]["Review_Content"]}"))),
                      Expanded(flex: 3,child: Container(
                          alignment: Alignment.centerRight,
                          width: double.infinity,height: double.infinity,
                          child: Text("${_messageList![index]["Review_time"]}"))),
                    ],
                  ),
                )),
              ],
            ),
          ),
        );
      },itemCount: _messageList!.length,);
}

  Widget videoView(){
    //  视频组件
    return FutureBuilder(
      future: videoLoading!,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.connectionState  == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }if(snapshot.hasError){
          return Text("数据有误,请稍后再试");
        }else{
          return Padding(padding: EdgeInsets.all(3),child: AspectRatio(aspectRatio: _videoPlayerController!.value.aspectRatio,child: VideoPlayer(_videoPlayerController!)));
        }

      },);
  }

  @override
  void didChangeMetrics() {
    // TODO: implement didChangeMetrics
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      print("d当前结果：$focusIndex");
    });
    super.didChangeMetrics();
  }

}




