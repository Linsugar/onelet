
//病历档案
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Archives extends StatefulWidget {
  @override
  _ArchivesState createState() => _ArchivesState();
}

class _ArchivesState extends State<Archives> {
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
      ),title: Text("病历档案")),
    body: Container(
      child: Column(
        children: [
          Expanded(flex: 3,child:archivesBanner()),
          Expanded(flex: 1,child:dataClearUp()),
          Expanded(flex: 6,child: Container(
          child: classClearUp(),)),
        ],
      ),
    ),
    );
  }
}


//病历banner
Widget archivesBanner(){
  return Stack(children: [
    Container(margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color:  Colors.orange[200],
          image: DecorationImage(
              image:  AssetImage('images/achiverbaner.jpg'),fit: BoxFit.cover
          ),
          borderRadius: BorderRadius.circular(5)
      ),
    ),
    Positioned(top: 20,left: 20,child:Text("我的记事本",style: TextStyle(fontSize: 20,color: Colors.orange,fontWeight: FontWeight.w900,letterSpacing: 3.0),),),
    Positioned(bottom: 40,left: 20,child:ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.orange),
          shape: MaterialStateProperty.all(StadiumBorder(side: BorderSide(
              style: BorderStyle.solid,
              color: Colors.orange
          )))
      ),
      onPressed: (){},child: Text("点击查看"),),),
  ],);
}


//数据整理
Widget dataClearUp(){
  return Container(
    decoration: BoxDecoration(
        color: Colors.orange[200],
        borderRadius: BorderRadius.circular(5)
    ),
    margin: EdgeInsets.only(left: 5,right: 5,top: 8,bottom: 8),
    padding: EdgeInsets.only(left: 10,right: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("重要数据整合",style: TextStyle(color: Colors.orange,fontWeight: FontWeight.w900),),
        FaIcon(FontAwesomeIcons.caretRight)
      ],),);
}

//分类整理
Widget classClearUp(){
  return  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: Row(children: [
        SizedBox(width: 10,),
        Text("分类整理",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900),)
      ],)),
      Expanded(flex: 9,child:
      GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),itemCount: 10, itemBuilder: (context,index){
        return Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              boxShadow: [BoxShadow(color: Colors.red,blurRadius: 1.0,offset: Offset(0.0,1.0),spreadRadius: -0.8)],
              color: Colors.white
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FaIcon(FontAwesomeIcons.print),
              Text("化验")
            ],),
        );
      }))
    ],);
}