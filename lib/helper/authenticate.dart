import 'package:chatapp/views/signin.dart';
import 'package:chatapp/views/signup.dart';
import 'package:flutter/material.dart';

class authenticate extends StatefulWidget {
  @override
  _authenticateState createState() => _authenticateState();
}

class _authenticateState extends State<authenticate> {

  bool showSignIn = true;
  void toggleView(){
    setState(() {
      showSignIn =!showSignIn;
    });
  }
  @override
  Widget build(BuildContext context) {
     if(showSignIn)
       {
         return SignIn(toggleView);
       }
     else
       {
       return SignUp(toggleView);
       }
  }
}
