import 'package:flutter/material.dart';

class AllServices extends StatefulWidget {
  @override
  _AllServicesState createState() => _AllServicesState();
}

class _AllServicesState extends State<AllServices> {
  double size = 1.0;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: GestureDetector(
        onScaleEnd: (ScaleEndDetails details){
          print("结束缩放值：$details");
        },
        onScaleUpdate:(ScaleUpdateDetails details){
          double floatsize = details.scale.clamp(.1,1);
          print("缩放值：$floatsize");
          if(floatsize>=1){
            setState(() {
              size = 0.1;
            });
          }else{
            setState(() {
              size = floatsize;
            });
          }
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 100,
              snap: true,
              floating: true,
              title: Text("所有服务"),
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network("https://cn.bing.com/th?id=OIP.xq1C2fmnSw5DEoRMC86vJwD6D6&pid=Api&rs=1",fit: BoxFit.cover,),
              ),),
            SliverGrid(delegate: SliverChildBuilderDelegate(
                (context,index){
                  return Container(
                    color: Colors.blue,
                    child: Image.network("https://cn.bing.com/th?id=OIP.xq1C2fmnSw5DEoRMC86vJwD6D6&pid=Api&rs=1",fit: BoxFit.cover,),);
                },
              childCount: 100
            ), gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: width/(size==1?1:(size*10)),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.0
            )
            )
          ],
        ),
      ),
    );
  }
}
