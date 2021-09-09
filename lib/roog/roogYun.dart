// import 'package:onelet/network/requests.dart';
// import 'package:onelet/pages/chat/model/chatmoled.dart';
// import 'package:onelet/provider/grobleState.dart';
// import 'package:provider/provider.dart';
// import 'package:rongcloud_im_plugin/rongcloud_im_plugin.dart';
//
// class Roogyun{
//
// //  初始化
// static rooginit(){
//     RongIMClient.init("p5tvi9dsplrv4");
//   }
// //  监听
// static rooglistn(context){
//   RongIMClient.onMessageReceived = (Message? msg,int? left) {
//     print("receive message messsageId:"+msg!.messageId.toString()+" left:"+left.toString()+'msg:'+msg.toString());
//     print("监听到消息：${msg.content!.conversationDigest()}");
//     print("消息发送者信息：${msg.targetId}");
//     Provider.of<GlobalState>(context,listen: false).changhistory(msg);
//
//   };
// }
//
// //检查连接状态
// static roogclientstatue(){
//   RongIMClient.onConnectionStatusChange = (int? connectionStatus) {
//     if (RCConnectionStatus.KickedByOtherClient == connectionStatus ||
//         RCConnectionStatus.TokenIncorrect == connectionStatus ||
//         RCConnectionStatus.UserBlocked == connectionStatus) {
//       // String toast = "连接状态变化 $connectionStatus, 请退出后重新登录";
//       print("连接有误");
//     } else if (RCConnectionStatus.Connected == connectionStatus) {
//       print("连接成功");
//     }
//   };
// }
//
// //获得指定会话消息
//  static getConversation(String targetId)async{
//     Conversation ?con =await RongIMClient.getConversation(RCConversationType.Private, targetId);
//     print("得到的内容1：$con");
//     if(con!=null){
//       print("得到的内容2：${con.latestMessageContent}");
//       print("得到会话3：${con.latestMessageContent!.conversationDigest()}");
//       print("得到会话4：${con.latestMessageContent!.sendUserInfo}");
//       print("得到会话5：${con.latestMessageContent!.mentionedInfo}");
//       print("得到会话6：${con.latestMessageContent!.destructDuration}");
//       return con.latestMessageContent!.conversationDigest();
//     }
//   }
//
//
// //  发送消息
// static sedMessage(String sendmsg,String pid,context)async{
//     TextMessage txtMessage = new TextMessage();
//     txtMessage.content = sendmsg;
//     Message ?msg = await RongIMClient.sendMessage(RCConversationType.Private, pid, txtMessage);
//     var st = msg!.sentStatus;
//     Provider.of<GlobalState>(context,listen: false).changhistory(msg);
//     print("发送消息状态：${st}");
//   }
//
// //  获取所有的会话
// static getallConversation()async{
//   List<chatmodel> userlist = [];
//   List ?conversationList = await RongIMClient.getConversationList([RCConversationType.Private,RCConversationType.Group,RCConversationType.System]);
//
//   if(conversationList == null){
//     return [];
//   }
//   print("获取所有的会话：${conversationList}");
// //  接收方
//   print("获取所有接收方id：${conversationList[0].targetId}");
// //  发送方
//   print("获取所有发送方id：${conversationList[0].senderUserId}");
//   for(var i=0;i<conversationList.length;i++){
//     var result = await Request.getNetwork('user/',params: {
//       'user_id':conversationList[i].targetId
//     });
//     userlist.add(chatmodel(result,conversationList[i].latestMessageContent.content));
//   }
//   print("userlis:${userlist}");
//   return userlist;
// }
//
//
// //连接融云
// static  roogclient(String ?token)async{
//     print("进入");
//     var a = await RongIMClient.getConnectionStatus();
//     if(a != 0){
//       RongIMClient.connect(token!, (code, userId) => print("状态码：${code},${userId}"));
//     }
//     print("连接状态：${a}");
//     print("退出");
//   }
// static  roogHistoryMessages(String ?userid,context) async {
//     List ?msgs = await RongIMClient.getHistoryMessage(RCConversationType.Private, userid!, -1, 100);
//     print("get history ${msgs}");
//     for(Message m in msgs!.reversed) {
//       Provider.of<GlobalState>(context,listen: false).changhistory(m);
//       print("sentTime = "+m.sentTime.toString());
//     }
//
//     return msgs;
//   }
//
// //  获取远程历史消息
// static rooghistory(String tarid){
// dynamic res =(dynamic msgList,int code) {
//   if(code == 0) {
//     for(Message ?msg in msgList) {
//       print("getRemoteHistoryMessages  success "+ msg!.messageId.toString());
//     }
//   }else {
//     print("getRemoteHistoryMessages error "+code.toString());
//   }
// };
// RongIMClient.getRemoteHistoryMessages(1, tarid, 0, 20,res);
// }
//
// }