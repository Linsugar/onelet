import 'dart:ui';

import 'package:onelet/until/CommonUntil.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//找医生
class FindDoctor extends StatefulWidget {
  @override
  _FindDoctorState createState() => _FindDoctorState();
}

class _FindDoctorState extends State<FindDoctor> {

  TextEditingController _textEditingController =TextEditingController();
  FocusNode _focusNode =FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    _focusNode.unfocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      ),title: Text("找医生",),backgroundColor: Colors.white,),
      body: Container(
        padding: EdgeInsets.only(left: 10,right: 10,top: 5),
        child:Column(
        children: [
          homeInput(_textEditingController,_focusNode),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            Row(
              children: [
                Text("全国"),
                SizedBox(width: 5,),
                FaIcon(FontAwesomeIcons.caretDown),
                Text("|"),
              ],
            ),
              Row(
                children: [
                  Text("擅长"),
                  SizedBox(width: 5,),
                  FaIcon(FontAwesomeIcons.caretDown),
                  Text("|"),
                ],
              ),
              Row(
                children: [
                  Text("排序"),
                  SizedBox(width: 5,),
                  FaIcon(FontAwesomeIcons.caretDown),
                  Text("|"),
                ],
              ),
              Row(
                children: [
                  Text("筛选"),
                  SizedBox(width: 5,),
                  FaIcon(FontAwesomeIcons.caretDown),
                  Text("|"),
                ],
              ),
          ],),
          Expanded(child: doctorList())
        ],
      ),),
    );
  }
}

Widget doctorList(){
  return ListView.separated(itemBuilder: (context,index){
    return ListTile(
      leading: Container(
        width: 80,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage('http://qtwribo4e.hn-bkt.clouddn.com/16223583194327848.jpg')
            )
        ),
      ),
      title: Text("徐达民(副主任医生)"),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("目前就职医院，岗位"),
          Row(children: [Text("好评率：99%"),Text("咨询次数：1576")],),
          Row(children: [Text("平均回复时长：6小时内")],),
          Wrap(children: [Text("擅长领域：IgA肾病，膜性肾病，慢性肾功能不全")],),
          Row(
            children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.orange,width: 1)
              ),
              child: Text("图文咨询",style: TextStyle(color: Colors.orange),),
            ),
            SizedBox(width: 5,),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.orange,width: 1)
              ),
              child: Text("私人医生",style: TextStyle(color: Colors.orange),),
            )
          ],)
        ],
      ),
    );
  }, separatorBuilder:  (context,index){
    return Divider();
  }, itemCount: 20);
}
