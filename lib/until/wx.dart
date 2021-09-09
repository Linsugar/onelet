import 'package:onelet/until/showtoast.dart';
import 'package:fluwx/fluwx.dart';

class Wx{

 static initwx()async{
    print("链接微信");
    await registerWxApi(
        appId: "wx1c5dc5540564df37",
        doOnAndroid: true,
        doOnIOS: true,
        universalLink: "https://your.univerallink.com/link/");
    print("链接微信结束");
  }

 static checkwx()async{
    print("检测微信是否安装");
   var result =  await isWeChatInstalled;
   if(result ==false){
     PopupUntil.showToast("请下载微信");
   }
    print("检测微信安装完成：$result");
  }

  static wxlogin()async{

  var login =  await sendWeChatAuth(
      scope: "snsapi_userinfo",
      state: "wechat_sdk_demo");
   print("微信登录");
  print("微信登录数据:${login}");
 }

}