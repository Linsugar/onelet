import 'dart:io';
import 'package:onelet/provider/grobleState.dart';
import 'package:onelet/until/CreamUntil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Photos extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PhotsState();
  }
}
class PhotsState extends State<Photos>{
  var ImageUrl ="https://img3.doubanio.com/view/photo/m_ratio_poster/public/p2629413230.jpg";
  var imageList = [];
  @override
  Widget build(BuildContext context) {
    var PhoneSize = MediaQuery.of(context).size;
    // TODO: implement build

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
      ),title: Text("我的相册"),),
      body: Container(
        margin: EdgeInsets.all(10),
        width: PhoneSize.width,
        height: PhoneSize.height,
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(flex: 2,child: Container(width:PhoneSize.width ,child: ClipRRect(borderRadius: BorderRadius.circular(5),child: Image.network(ImageUrl,fit: BoxFit.cover))),),
            SizedBox(height: 10,),
            Expanded(flex: 2,child: Container(width:PhoneSize.width ,child: Row(
              children: [
                context.watch<GlobalState>().imageList.length ==0?Text(''):ClipRRect(borderRadius: BorderRadius.circular(10),
                    child:Image.file(File(context.watch<GlobalState>().imageList[0]),fit: BoxFit.cover,)),
                MaterialButton(
                  onPressed: ()async{
                    await createPhotsWige();
                  },child: Icon(Icons.add),)
              ],
            )),),
            SizedBox(height: 10,),
            Expanded(flex:2,child:Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(flex: 2,child:ClipRRect(borderRadius: BorderRadius.circular(5),child: Image.network(ImageUrl,fit: BoxFit.cover,)),),
                SizedBox(width: 10,),
                Expanded(flex: 7,child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                  Text("1.请上传本人照片,勿上传色情图片",overflow:TextOverflow.ellipsis ,style: TextStyle(fontSize: 10),),
                  Text("2.请上传本人照片,勿上传色情图片",overflow:TextOverflow.ellipsis ,style: TextStyle(fontSize: 10),),
                  Text("3.请上传本人照片,勿上传色情图片",overflow:TextOverflow.ellipsis ,style: TextStyle(fontSize: 10),),
                  Text("4.请上传本人照片,勿上传色情图片",overflow:TextOverflow.ellipsis ,style: TextStyle(fontSize: 10),),
                ],),),
              ],
            )),
            Expanded(flex: 5,child:Container()),
          ],
        ),
      ),
    );
  }
 Future createPhotsWige()async{

    var rsult = await Creamer.GetCramer();
    if (rsult !=null){
      context.read<GlobalState>().changlist(rsult);
    }

  }
}