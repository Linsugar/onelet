import 'package:onelet/cmmmpns/allservices.dart';
import 'package:onelet/cmmmpns/group.dart';
import 'package:onelet/cmmmpns/servesetting.dart';
import 'package:onelet/cmmmpns/seviceorder.dart';
import 'package:onelet/main.dart';
import 'package:onelet/pages/ToPic/childcpns/topiccpns.dart';
import 'package:onelet/pages/chat/Chatchild.dart';
import 'package:onelet/pages/chat/cpn/reviewcpn.dart';
import 'package:onelet/pages/home/Home.dart';
import 'package:onelet/pages/home/childcps/archives.dart';
import 'package:onelet/pages/home/childcps/finddoctor.dart';
import 'package:onelet/pages/home/childcps/videocnps.dart';
import 'package:onelet/pages/home/childcps/webviewcps.dart';
import 'package:onelet/pages/login/login.dart';
import 'package:onelet/pages/login/register.dart';
import 'package:onelet/pages/mine/childcpns/mydynamic.dart';
import 'package:onelet/pages/mine/childcpns/dynamicUp.dart';
import 'package:onelet/pages/mine/childcpns/MyPhoto.dart';
import 'package:onelet/pages/mine/childcpns/feedback.dart';
import 'package:onelet/pages/mine/childcpns/intergcpn.dart';
import 'package:onelet/pages/mine/childcpns/mysetting.dart';
import 'package:onelet/pages/mine/childcpns/taskcpn.dart';
import 'package:flutter/material.dart';

class RoutePage{
 static final routeName = {
    '/task':(context,{argument})=>Task(),
    '/Photos':(context,{argument})=>Photos(),
    '/mysetting':(context,{argument})=>MySetting(),
    '/mydynamic':(context,{argument})=>MyDynamic(),
    '/chatChild':(context,{argument})=>ChatChild(argument),
    '/Home':(context,{argument})=>Home(),
    '/feedbook':(context,{argument})=>FeedBook(),
    '/interg':(context,{argument})=>interg(),
    '/topiccpn':(context,{argument})=>ToPiCpn(),
    '/Regitser':(context,{argument})=>Regitser(),
    '/updynamic':(context,{argument})=>UpDynamic(),
    '/videoWidget':(context,{argument})=>videoWidget(argument),
    '/webviewcpns':(context,{argument})=>webviewcpns(argument),
    '/MyHomePage':(context,{argument})=>MyHomePage(),
    '/reviewCpn':(context,{argument})=>ReviewCpn(argument),
    '/createGroup':(context,{argument})=>CreateGroup(),
    '/MainHome':(context,{argument})=>MainHome(),
    '/doctor':(context,{argument})=>FindDoctor(),
    '/archives':(context,{argument})=>Archives(),
    '/services':(context,{argument})=>AllServices(),
    '/servesetting':(context,{argument})=>ServiceSetting(),
    '/order':(context,{argument})=>ServiceOrder(),
  };

// ignore: missing_return, top_level_function_literal_block
 static var onGenerateRoute = (RouteSettings settings) {
    print("获取到的setting：${settings.name}");
    final String ?name = settings.name;
    final Function ?pageContentBuilder = routeName[name];
    if (pageContentBuilder != null) {
      //能寻找到对应的路由
      if (settings.arguments != null) {
        //页面跳转前有传参
        final Route route = MaterialPageRoute(builder: (context) => pageContentBuilder(context, argument: settings.arguments));
        return route;
      } else {
        //页面跳转前没有传参
        final Route route = MaterialPageRoute(builder: (context) => pageContentBuilder(context));
        return route;
      }
    }
  };

}



