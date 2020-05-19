

import 'package:chatapp/helper/authenticate.dart';
import 'package:chatapp/helper/constants.dart';
import 'package:chatapp/helper/helperfunction.dart';
import 'package:chatapp/services/auth.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/views/search.dart';
import 'package:chatapp/views/signin.dart';
import 'package:chatapp/widgets/color.dart';
import 'package:chatapp/widgets/widget.dart';
import 'package:flutter/material.dart';

import 'conversation_screen.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream chatRoomStream;
  Widget chatRoomList(){
    return StreamBuilder(
      stream: chatRoomStream,
      builder: (context,snapshot){
        return snapshot.hasData ? ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (conext,index){
              return ChatRoomTile(
                snapshot.data.documents[index].data["chatroomId"].toString().replaceAll("_", "").replaceAll(Constants.myName, ""),
                  snapshot.data.documents[index].data["chatroomId"]
              );
            }) : Container();
      },
    );
  }
  @override
  void initState() {
    getUserInfo();

    super.initState();
  }

  getUserInfo() async{
    Constants.myName = await HelperFunction.getUserName();
    databaseMethods.getChatRooms(Constants.myName).then((value){
      setState(() {
        chatRoomStream = value;
      });
    });
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appName(),
        centerTitle: true,
        actions: <Widget>[
          InkWell(
            onTap: (){
              authMethods.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context)=> authenticate()
              ));
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.exit_to_app)),
          )
        ],
      ),
      body: chatRoomList(),
      floatingActionButton: FloatingActionButton(

        backgroundColor: borderFocusedColor,
        foregroundColor: borderEnabledColor,
        splashColor: buttonSecondary,
        hoverColor: appBarColor,
        child: Icon(Icons.search),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (context)=> SearchScreen()
          ));
        },
      ),

    );
  }
}

class ChatRoomTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;
  ChatRoomTile(this.userName, this.chatRoomId);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ConsversationScreen(chatRoomId,userName)
        ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children:[
            Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: buttonMain,
                borderRadius: BorderRadius.circular(40)
              ),
              child: Text("${userName.substring(0,1).toUpperCase()}"),),
            SizedBox(width: 8,),
            Text(userName, style: textStyle(),),
          ]
        ),
      ),
    );
  }
}
