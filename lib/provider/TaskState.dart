import 'package:flutter/material.dart';

class taskState extends ChangeNotifier{

List tasklist = [];
List  reciveTask = [];

changeTask(value){
  tasklist = value;
  notifyListeners();
}

clearTask(){
  tasklist.clear();
  notifyListeners();
}



}