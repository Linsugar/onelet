import 'package:shared_preferences/shared_preferences.dart';

class Shared{

  static setStringData(key,value)async{
    var preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, value);
  }

  static setIntData(key,value)async{
    var preferences = await SharedPreferences.getInstance();
    await preferences.setInt(key, value);
  }

  static clearPreferences()async{
//    清空缓存
  var preferences = await SharedPreferences.getInstance();
  await preferences.clear();
  }


}