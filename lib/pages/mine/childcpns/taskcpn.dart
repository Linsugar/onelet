
import 'package:onelet/network/requests.dart';
import 'package:onelet/provider/TaskState.dart';
import 'package:onelet/provider/grobleState.dart';
import 'package:onelet/until/showtoast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



_taskHistory(int ?statue,context)async{
  var result = await Request.getNetwork('/taskonly/',params: {
    'taststatue':statue,
    'taskid':context.read<GlobalState>().userInfo['userid']
  });
  Provider.of<taskState>(context,listen: false).clearTask();
  Provider.of<taskState>(context,listen: false).changeTask(result);
  return result;
}

class Task extends StatefulWidget{
  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> with SingleTickerProviderStateMixin{

  TabController ?_tabController;
  TextStyle _textStyle = TextStyle(color: Colors.black,fontSize: 15);
  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 3, vsync:this);
    _tabController?.addListener(() {
      print("当前下标：${_tabController?.index}");
    });
    super.initState();
  }
  @override
  void dispose() {
    _tabController?.dispose();
    // TODO: implement dispose
    super.dispose();
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
        ),title: Text("服务套餐"),actions: [MaterialButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>GetManger()));
        },child: Text("领取记录"),)],),
        body:Container(
            constraints: BoxConstraints.expand(),
            child: Flex(direction: Axis.vertical,children: [
              Flexible(flex: 0,child: Container(
                child: TabBar(
                    controller: _tabController,
                    tabs: [
                      Text("初级套餐",style: _textStyle),
                      Text("中级套餐",style: _textStyle),
                      Text("高级套餐",style:_textStyle),
                    ] ),
              )),
              Flexible(flex: 9,child: Container(child:
                TabBarView(
                  controller: _tabController,
                  children: [
                    Container(
                      child: Center(
                        child: Futurwiget(1),
                      ),
                    ),
                    Container(
                        child:
                        Center(
                          child: Futurwiget(2),
                        ) ,
                      ),
                    Futurwiget(3),
                  ]),
              )),
            ],)
        )
    );
  }

}


class Futurwiget extends StatefulWidget {
  var data;
  Futurwiget(this.data);

  @override
  _FuturwigetState createState() => _FuturwigetState();
}

class _FuturwigetState extends State<Futurwiget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }



  _reciveTask(var _task,int _taststatue)async{
    await Request.setNetwork('/taskonly/', {
      'taskid':context.read<GlobalState>().userInfo['user_id'],
      'task':_task,
      'taststatue':_taststatue
    });
  }

  _getTaskcls(int taskcls,int taststatu)async{
    var result = await Request.getNetwork('/sendtask/',params: {
      'taskcls':taskcls,
      'taststatue':taststatu
    });
    return result;
  }

  @override
  void didUpdateWidget(covariant Futurwiget oldWidget) {
    // TODO: implement didUpdateWidget
    print("进入该页面重绘");
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:_getTaskcls(widget.data,1),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.connectionState ==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }
        if (snapshot.connectionState == ConnectionState.done) {
          print("当前状态：${snapshot.data}");
          if(snapshot.hasData){
            print("当前状态1：${snapshot.data}");
            List snda = snapshot.data;
            if(snda.isEmpty){
              return Center(child: Text("当前暂无任务,请等待任务发布"),);
            }
            return ListView.separated( itemCount:snda.length,itemBuilder: (context,index){
              return GestureDetector(
                onTap: (){
                  print("进入任务详细");
                },
                  child: ListTile(
                    leading: Text("${index+1}"),title: Text("${snda[index]['tasktitle']}"),
                    subtitle: Text("${snda[index]['taskcontent']}"),
                    trailing: MaterialButton(child: Text(snda[index]['taststatue']==1?'领取':(snda[index]['taststatue']==2?'已领取':'已完成')),onPressed: ()async{
                      print("我点击了领取按钮${snda[index]['task']}");
                      var task = snda[index]['task'];
                      PopupUntil.showToast("领取成功~");
                      await _reciveTask(task,2);
                      setState(() {
                      });
                    },),
                ),
              );
            }, separatorBuilder: (context,index){
              return Divider();
            });
          }
          else{
            return Text("Error:1");
          }
        }
        else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
//领取记录
class GetManger extends StatefulWidget {
  var data;

  @override
  _GetMangerState createState() => _GetMangerState();
}

class _GetMangerState extends State<GetManger> {
  int ?_statue;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("领取记录"),actions: [PopupMenuButton(
      padding: EdgeInsets.all(8),
        offset: Offset(0,5.0),
        onSelected: (value){
          int statue = int.parse(value.toString());
          setState(() {
            _statue =statue;
          });
        },
        itemBuilder:(BuildContext context) => <PopupMenuItem<String>>[
          PopupMenuItem<String>(
              value: "2",
              child: Row(mainAxisSize: MainAxisSize.min,children: [Icon(Icons.account_circle,color: Colors.lightBlue,),Text("仅看未完成")],)
          ),
          PopupMenuItem<String>(
              value: "3",
              child: Row(mainAxisSize: MainAxisSize.min,children: [Icon(Icons.search,color: Colors.lightBlue,),Text("仅看已完成")],)
          )
        ]
    )],),
      body: Container(
        child: Center(
          child: FutureBuilder(
            future:_taskHistory(_statue, context),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(snapshot.connectionState ==ConnectionState.waiting){
                return CircularProgressIndicator();
              }
              if (snapshot.connectionState == ConnectionState.done) {
                print("当前状态：${snapshot.data}");
                var tasks = context.watch<taskState>().tasklist;
                print("当前状态数据：${tasks}");
                if(snapshot.hasData){
                  return ListView.separated( itemCount:tasks.length,itemBuilder: (context,index){
                    return GestureDetector(
                      onTap: (){
                      },
                      child: Dismissible(
                        key: ValueKey(index),
                        child: ListTile(
                          leading: Text("${index+1}"),title: Text("${tasks[index]['tasktitle']}"),
                          subtitle: Text("${tasks[index]['taskcontent']}"),
                          trailing: MaterialButton(child: Text(tasks[index]['taststatue']==1?'领取':(tasks[index]['taststatue']==2?'已领取':'已完成')),onPressed: (){},),
                        ),
                      ),
                    );
                  }, separatorBuilder: (context,index){
                    return Divider();
                  });
                }
                else{
                  return Text("Error:1");
                }
              }
              else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}


