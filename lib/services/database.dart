import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{

  getUserByUserName(String username) async{
    return await
Firestore.instance.collection("users").where("name" , isEqualTo: username).getDocuments();
  }

  getUserByEmail(String useremail) async{
    return await
    Firestore.instance.collection("users").where("email" , isEqualTo: useremail).getDocuments();
  }
  uploadUserInfo(userMap){
    Firestore.instance.collection("users").add(userMap);
  }

  CreateChatRoom(String chatRoomId, chatRoomMap){
    Firestore.instance.collection("ChatRoom").document(chatRoomId).setData(chatRoomMap).catchError((e){
      print(e.toString());
    });
  }
  addConservationMessage(String chatRoomId, messageMap){
    Firestore.instance.collection("ChatRoom").document(chatRoomId).collection("chats")
        .add(messageMap).catchError((e){print(e.toString());});
  }

  getConservationMessage(String chatRoomId) async{
   return await Firestore.instance.collection("ChatRoom").document(chatRoomId).collection("chats").orderBy("time",descending: false)
        .snapshots();
  }

  getChatRooms(String userName) async{
    return await Firestore.instance.collection("ChatRoom").where("users",arrayContains: userName).snapshots();
  }
}
