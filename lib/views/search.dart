import 'package:chatapp/helper/constants.dart';
import 'package:chatapp/helper/helperfunction.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/widgets/color.dart';
import 'package:chatapp/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'conversation_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}
String _myName;

class _SearchScreenState extends State<SearchScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchTEC = new TextEditingController();

  QuerySnapshot searchSnapshot;

  Widget searchList(){
    return searchSnapshot != null ?ListView.builder(
        shrinkWrap: true,
        itemCount: searchSnapshot.documents.length,
        itemBuilder: (context,index){
          return SearchTile(
            username: searchSnapshot.documents[index].data["name"],
            email: searchSnapshot.documents[index].data["email"],
          );
        }): Container();
  }
  initateSearch(){
    databaseMethods.getUserByUserName(searchTEC.text).then((val){
    setState(() {
      searchSnapshot = val;

    });
    });
  }

  createChatRoomStartCon({ String userName}){
   if(userName !=Constants.myName){
     String chatRoomId =  getChatRoomId(userName,Constants.myName);
     List<String> users = [userName, Constants.myName];
     Map<String, dynamic> chatRoomMap = {
       "users" : users,
       'chatroomId' :chatRoomId
     };

     DatabaseMethods().CreateChatRoom(chatRoomId, chatRoomMap);
     Navigator.push(context, MaterialPageRoute(
         builder: (Context)=> ConsversationScreen(
           chatRoomId, userName
         )
     ));
   }else{
     print("sorry both the are you only");
   }
  }

Widget SearchTile({String email, String username}){
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(username ,style: textStyle(),),

              Text(email , style: textStyle(),),
            ],
          ),
          Spacer(),
          InkWell(
            onTap: (){
                createChatRoomStartCon(userName: username);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal:16 ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: buttonSecondary
              ),
              child: Text("Message", style: mediumTextStyle(),),
            ),
          )

        ],
      ),
    );
}

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appName(),
        centerTitle: true,
        elevation: 0.5,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: buttonMain,
              blurRadius: 2.0,
              spreadRadius: 1.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
          )
        ],
      ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                          controller: searchTEC,
                            style:textStyle(),
                          decoration:  InputDecoration(
                            border: InputBorder.none,
                             hintText: "Search Username",
                             hintStyle: TextStyle(
                                 color: hintColor,

                             ),

                         ),
                        )),
                    InkWell(
                        onTap: (){
                          initateSearch();
                        },
                        child: Icon(Icons.search, color: borderFocusedColor,))
                  ],
                ),
              ),
            ),
            searchList()
          ],
        ),
      ),
    );
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}