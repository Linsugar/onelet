import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


//上传病例情况
class UpDiseaseCase extends StatefulWidget {
  @override
  _UpDiseaseCaseState createState() => _UpDiseaseCaseState();
}

class _UpDiseaseCaseState extends State<UpDiseaseCase> {

  List<String> _strList = [
    '血压','脉搏','用药','化验','症状','饮食记录','用药处方证明','出院记录拍照上传','门诊病历拍照上传','腹透透析日记拍照上传'
  ];
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
      ),title: Text("上传数据",)),
      body: Container(
        color: Colors.white,
        child: ListView.separated(
          padding: EdgeInsets.only(top: 10),
            itemBuilder: (context,index){
            if(index==3){
              return Container(
                margin: EdgeInsets.only(left: 10,right: 10),
                decoration: BoxDecoration(
                    color: Colors.blueGrey[50],
                    borderRadius: BorderRadius.circular(5)
                ),
                child: ListTile(
                  leading: Text(_strList[index]),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [Text("手动输入",style: TextStyle(color: Colors.orange),),SizedBox(width: 10,),Text("|"),SizedBox(width: 10,),Text("上传照片",style: TextStyle(color: Colors.orange))],),),
              );
            }
          return   Container(
            margin: EdgeInsets.only(left: 10,right: 10),
            decoration: BoxDecoration(
              color: Colors.blueGrey[50],
              borderRadius: BorderRadius.circular(5)
            ),
            child: ListTile(
              leading: Text(_strList[index]),
              trailing: FaIcon(FontAwesomeIcons.angleRight,size: 30,color: Colors.black45,),),
          );
        }, separatorBuilder: (context,index){
          return SizedBox(height: 10,);
        }, itemCount: _strList.length),
      ),
    );
  }
}
