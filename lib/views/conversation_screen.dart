import 'package:chatapp/helper/constants.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/widgets/color.dart';
import 'package:chatapp/widgets/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class ConsversationScreen extends StatefulWidget {
  final String chatRoomId;
  final String username;
  ConsversationScreen(this.chatRoomId, this.username);
  @override
  _ConsversationScreenState createState() => _ConsversationScreenState();
}

class _ConsversationScreenState extends State<ConsversationScreen> {
 TextEditingController messageController = new TextEditingController();

 DatabaseMethods databaseMethods = new DatabaseMethods();
 Stream chatMessageStream;

  Widget ChatMessageList(){
    return StreamBuilder(
      stream: chatMessageStream,
      builder: (context,snapshot){
        return snapshot.hasData ?ListView.builder(

            itemCount: snapshot.data.documents.length,
            itemBuilder: (context,index){
              return MessageTile(snapshot.data.documents[index].data["message"],snapshot.data.documents[index].data["sendBy"]==Constants.myName);
            }) : Container();

      },
    );
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": messageController.text,
        "sendBy": Constants.myName,
        "time" : DateTime.now().millisecondsSinceEpoch
      };
      databaseMethods.addConservationMessage(widget.chatRoomId, messageMap);
      messageController.text = "";
    }
  }
  @override
  void initState() {
      databaseMethods.getConservationMessage(widget.chatRoomId).then((value){
      setState(() {
        chatMessageStream = value;
      });
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
        title: Text(widget.username.substring(0,1).toUpperCase() + widget.username.substring(1)),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.white70,
                padding: EdgeInsets.only(bottom: 50),
                child: ChatMessageList()),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                 // borderRadius: BorderRadius.circular(8.0),
                  color: Color(0xff3b4473),

                  border: Border(
                    top: BorderSide(color: Colors.blueAccent[200],)
                  )
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                          controller: messageController,
                          style:TextStyle(color: Colors.white70, fontSize: 17),
                          decoration:  InputDecoration(
                            border: InputBorder.none,
                            hintText: "Type a message",
                            hintStyle: TextStyle(
                              color: Colors.indigo[100],
                            ),
                          ),
                        )),
                    InkWell(
                        onTap: (){
                         sendMessage();
                        },
                        child: Icon(Icons.send, color: Colors.white,))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;
  MessageTile(this.message,this.isSendByMe);
  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.only(left: isSendByMe ?0 :16, right: isSendByMe ?16 :0),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight:Alignment.centerLeft,
      margin: EdgeInsets.symmetric(vertical: 2),
      child: Container(
        decoration: BoxDecoration(
            color: isSendByMe? Color(0xff7590f0) : Color(0xff3b4473),
            borderRadius: isSendByMe? BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight:  Radius.circular(16),
                bottomLeft:  Radius.circular(16)) :
            BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight:  Radius.circular(16),
                bottomRight:  Radius.circular(16))
        ),
        padding: EdgeInsets.symmetric(horizontal:20, vertical: 12),
        child: Text(message, style:TextStyle(
          fontSize :17, color: isSendByMe ? Colors.black87 : Colors.white,
        ) ),
      ),
    );
  }
}
