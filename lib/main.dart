import 'package:chatapp/helper/helperfunction.dart';
import 'package:chatapp/views/chatroomscreens.dart';
import 'package:chatapp/views/signin.dart';
import 'package:chatapp/views/signup.dart';
import 'package:chatapp/widgets/color.dart';
import 'package:flutter/material.dart';

import 'helper/authenticate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn = false;
  @override
  void initState() {
getLockedInState();
super.initState();
  }

  getLockedInState() async{
    await HelperFunction.getUserLoggedIn().then((value) {
      setState(() {
        userIsLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Let\'s talk',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: appBarColor,
        scaffoldBackgroundColor: backgroundColor,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:   authenticate(),
    );
  }
}


