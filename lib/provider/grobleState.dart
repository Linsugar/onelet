import 'package:flutter/material.dart';
class GlobalState with ChangeNotifier{
  List imageList = [];
  String city ='成都';
  String ?deviceid;
  String ?platform;
  List ?historylist= [];
  List ?overuser = [];
  List ?emij = [];
  bool loadstatue =false;
  List wxlist = [];
  List upImageList = [];
  String qiNiuToken ="";
  var userInfo;
  var dynamicList = [];


  changeDynamicList(value){
    dynamicList =value;

    notifyListeners();
  }

  changeUserInfo(value){
    userInfo = value;
    notifyListeners();
  }

  changeQiNiu(value){
    qiNiuToken =value;
    notifyListeners();
  }

  changeUpImage(value){
    upImageList.add(value);
    notifyListeners();
  }


  changewxlist(value){
    wxlist.add(value);
    notifyListeners();
  }

  changeloads(value){
    loadstatue = value;
    notifyListeners();
  }


  changeemij(value){
    emij!.add(value);
    notifyListeners();
  }

  changealluser(value){
    overuser!.add(value);
    notifyListeners();
  }


  changhistory(value){
    historylist!.add(value);
    notifyListeners();
  }
  clearhistory(){
    historylist=[];
    notifyListeners();
  }


  changdeviceid(value){
    deviceid = value;
    notifyListeners();
  }

  changplatform(value){
    platform = value;
    notifyListeners();
  }

  changlist(value){
    imageList.add(value);
    notifyListeners();
  }
}