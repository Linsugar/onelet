import 'package:carousel_slider/carousel_slider.dart';
import 'package:onelet/network/requests.dart';
import 'package:onelet/pages/chat/model/chatdynamic.dart';
import 'package:onelet/pages/home/model/model.dart';
import 'package:onelet/provider/grobleState.dart';
import 'package:onelet/provider/homeState.dart';
import 'package:onelet/until/CommonUntil.dart';
import 'package:onelet/until/showtoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Topic extends StatefulWidget{
//  话题
  @override
  State<StatefulWidget> createState() =>TopicState();
}

class TopicState extends State<Topic> with SingleTickerProviderStateMixin{

  final List<Widget> _tabList = [Text("全部"),Text("娱乐"),Text("电竞"),Text("科技"),Text("奇文"),Text("健康"),Text("萌宠")];
  TabController ?_tabController;
  FocusNode _focusNode = FocusNode();
  ScrollController _scrollController = ScrollController();
  List ? wx;

  @override
  void initState() {
    // TODO: implement initState
    _getDynamic();
    _focusNode.unfocus();
    _getVideoContext();
    _tabController = TabController(length: _tabList.length, vsync: this);
    super.initState();
    _scrollController.addListener(() {
      _focusNode.unfocus();
    });
  }

//获取视频热点
  _getVideoContext()async{
    var videoState = Provider.of<homeState>(context,listen: false);
    List<VideoInfo> videoList= [];
    List _res = await Request.getNetwork('videolist/');
    _res.forEach((element) {
      videoList.add(VideoInfo(element));
    });
    videoState.changeVideo(videoList);
  }
  //  获取动态
  _getDynamic()async{
    print("进入获取动态");
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
  Widget build(BuildContext context) {
    wx = context.watch<GlobalState>().wxlist;
    List dataList = context.watch<GlobalState>().dynamicList;
    // TODO: implement build
//     Color.alphaBlend(foreground, background), Color.lerp(a, b, t),Color.getAlphaFromOpacity(opacity), Color.fromARGB(a, r, g, b)
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
        title: Text("话题",)),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            videoContent(),
            TabBar(
              labelPadding: EdgeInsets.all(5),
              labelColor: Colors.black,
              tabs: _tabList,
              controller: _tabController,
            ),
            Expanded(
              flex: 7,
              child: TabBarView(
                controller: _tabController,
                children: [
                  for(var i=0;i<7;i++)
                    AnimatedContainer(
                      curve: Curves.easeInQuint,
                      duration: Duration(milliseconds: 500),
                        child: titleCdk(dataList,i))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  //头部内容
  Widget videoContent(){
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      child:Column(children: [
        SizedBox(height: 5,),
        VideoCarousel(context),
        SizedBox(height: 5,),
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for(var i=0;i<4;i++)
              Container(
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: i==context.watch<homeState>().carIndex?Colors.orange:Colors.blueGrey,
                    borderRadius: BorderRadius.circular(5)
                ),
                width: 10,height: 10,),
          ],)
      ],),
    );
  }

  //首页视频轮播组件
  Widget VideoCarousel(context){
    List listVideo = Provider.of<homeState>(context).videoList;
    return  CarouselSlider(
      options: CarouselOptions(
        onPageChanged: (int index, CarouselPageChangedReason reason){
          Provider.of<homeState>(context,listen: false).changindex(index);
        },
        aspectRatio: 2.9,
        viewportFraction: 1.0,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
        autoPlay: true,
      ),
      items: listVideo.map((value) {
        return Builder(
          builder: (BuildContext context) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: (){
                  Navigator.pushNamed(context, "/videoWidget",arguments: {'value':value});
                },
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                        boxShadow: [BoxShadow(color: Colors.black,spreadRadius: 0.5,blurRadius: 0.9,)],
                        color: Colors.amber
                    ),
                    child: Image(image: NetworkImage(value.videoCover),fit: BoxFit.cover,)
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }



//话题文章
  Widget titleCdk(dataList,index){
    if(dataList == null){
      return Center(child: CircularProgressIndicator(),);
    }
    if(index == 0){
      return ListView.separated(
          controller: _scrollController,
          padding: EdgeInsets.only(top: 10),
          itemBuilder: (context,index){
            return InkWell(
              onTap: (){
                Navigator.pushNamed(context,'/reviewCpn',arguments:{'data':dataList[index]} );
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 5,child: Container(
                      margin: EdgeInsets.only(left: 10),
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(image: NetworkImage(dataList[index].imagelist[0]),fit: BoxFit.cover))
                  )),
                  SizedBox(width: 10,),
                  Expanded(flex: 5,child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${dataList[index].title}",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.w800),),
                      SizedBox(height:10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${dataList[index].con}",maxLines: 2,overflow: TextOverflow.ellipsis),
                          Text("${dataList[index].username}"),
                        ],),
                      SizedBox(height:10,),
                      Row(children: [
                        Icon(Icons.play_arrow),
                        Text("${551*index}"),
                        SizedBox(width: 20,),
                        Icon(Icons.star_border),
                        Text("${13*index*1+13}"),
                      ],)
                    ],
                  )),
                ],
              ),
            );
          }, separatorBuilder: (context,index){
        return Divider();
      }, itemCount: dataList.length);
    }
    else{
      index = index -1;
      var newData = dataList.where((value)=>value.Dynamic_Type == index).toList();
      return ListView.separated(
          controller: _scrollController,
          padding: EdgeInsets.only(top: 10),
          itemBuilder: (context,index){
            return InkWell(
              onTap: (){
                Navigator.pushNamed(context,'/reviewCpn',arguments:{'data':newData[index]} );
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 5,child: Container(
                      margin: EdgeInsets.only(left: 10),
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(image: NetworkImage(newData[index].imagelist[0]),fit: BoxFit.cover))
                  )),
                  SizedBox(width: 10,),
                  Expanded(flex: 5,child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${newData[index].title}",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.w800),),
                      SizedBox(height:10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${newData[index].con}",maxLines: 2,overflow: TextOverflow.ellipsis),
                          Text("${newData[index].username}"),
                        ],),
                      SizedBox(height:10,),
                      Row(children: [
                        Icon(Icons.play_arrow),
                        Text("${551*index}"),
                        SizedBox(width: 20,),
                        Icon(Icons.star_border),
                        Text("${13*index*1+13}"),
                      ],)
                    ],
                  )),
                ],
              ),
            );
          }, separatorBuilder: (context,index){
        return Divider();
      }, itemCount: newData.length);
    }
  }


}


