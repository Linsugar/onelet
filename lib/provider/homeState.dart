import 'package:flutter/material.dart';
class homeState with ChangeNotifier {
String ?hometitle ="哈喽";
List homelist = [];
List reviewlist = [];
int carIndex = 0;
List videoList = [];


changeVideo(value){
  videoList = value;
  notifyListeners();
}


changindex(value){
  carIndex = value;
  notifyListeners();
}
changereview(value){
  reviewlist.add(value);
  notifyListeners();
}

changelist(value){
  homelist.add(value);
  notifyListeners();
}
}