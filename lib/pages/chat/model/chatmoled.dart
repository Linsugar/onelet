class chatmodel{
  String ?name;
  String ?userid;
  String ?avator_image;
  String ?user_context;
  chatmodel(value,context){
    name = value['username'];
    userid = value['user_id'];
    avator_image = value['avator_image'];
    user_context = context;
  }
}