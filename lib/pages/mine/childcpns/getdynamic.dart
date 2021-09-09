import 'dart:convert';
class dynamicdata{
  String ?title;
  String ?context;
  List ?imageurl;
  String ?id;
  String ?avator;
  String ?time;

  dynamicdata(value){
    print(value);
    this.title = value['Up_Title'];
    this.context = value['Up_Context'];
    this.imageurl = jsonDecode(value['Up_ImageUrl']);
    this.id = value['user_id'];
    this.avator = value['Up_avator'];
    this.time = value['Up_Time'];
  }
}