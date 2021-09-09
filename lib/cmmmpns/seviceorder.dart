//服务订单

import 'package:flutter/material.dart';

class ServiceOrder extends StatefulWidget {
  @override
  _ServiceOrderState createState() => _ServiceOrderState();
}

class _ServiceOrderState extends State<ServiceOrder> {


 Future orderData()async{
 var or = await Future.delayed(Duration(seconds: 2));
 return or;
 }


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
      ),title: Text("服务订单",)),
      body: FutureBuilder(
        future: orderData(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }else{
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                fit: BoxFit.cover,
                  image: AssetImage('images/order.png')
                )
              ),
            );
          }
        },
      ),
    );
  }
}
