

import 'package:chatapp/helper/helperfunction.dart';
import 'package:chatapp/services/auth.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/widgets/color.dart';
import 'package:chatapp/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'chatroomscreens.dart';
import 'forgetpassword.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formkey = GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController emailTEC = new TextEditingController();
  TextEditingController passwordTEC = new TextEditingController();
  bool isLoading = false;

  signIn() async {
    if (formkey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      await authMethods
          .signInWithEmailPassword(
          emailTEC.text, passwordTEC.text)
          .then((result) async {
        if (result != null)  {
          QuerySnapshot userInfoSnapshot =
          await DatabaseMethods().getUserByEmail(emailTEC.text);

          HelperFunction.saveUserLoggedIn(true);
          HelperFunction.saveUserName(
              userInfoSnapshot.documents[0].data["name"]);
          HelperFunction.saveUserEmail(
              userInfoSnapshot.documents[0].data["email"]);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatRoom()));
        } else {
          setState(() {
            isLoading = false;
            SnackBar(content: Text("Invalid credentials"),);
          });
        }
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  isLoading
          ? Container(
        child: Center(child: CircularProgressIndicator()),
      )
          :Container(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                Image.asset("assets/images/logo.png"),
                SizedBox(height: 16,),
                Form(
                  key: formkey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        validator: (val){
                          return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ?
                          null : "please provide valid email";
                        },
                        controller: emailTEC,
                        style: textStyle(),
                        decoration: textFiled("email"),
                      ),
                      TextFormField(
                        obscureText: true,
                        validator: (val){
                          return val.length >6 ?null : "please provide 6+ character";
                        },
                        controller: passwordTEC,
                        style: textStyle(),
                        decoration: textFiled("password"),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8,),
                Container(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context)=> ForgetPassword(widget.toggle)
                      ));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text("Forget Password?",
                      style: TextStyle(color: Color(0xff7694c2),
                      fontSize: 17),),
                    ),
                  ),
                ),
                SizedBox(height: 16,),
                Container(
                  alignment: Alignment.centerRight,
                  child: Container(

                    padding: EdgeInsets.symmetric(vertical :16),
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: hintColor
                  ),

                    width: MediaQuery.of(context).size.width*.3,
                     child: InkWell(
                       onTap: (){
                         signIn();
                       },
                       child: Row(
                       // crossAxisAlignment: CrossAxisAlignment.center,
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: <Widget>[
                           Text("Sign in", style: buttonTextStyle(),),
                           SizedBox(width: 4,),
                           Icon(Icons.arrow_forward,color: borderFocusedColor,)
                         ],
                       ),
                     ) ,
                  ),
                ),
                SizedBox(height: 16,),
//                Container(
//                  padding: EdgeInsets.symmetric(vertical: 16),
//                  decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(24),
//                    color: buttonSecondary
//                  ),
//                  alignment: Alignment.center,
//                  width: MediaQuery.of(context).size.width,
//                  child: Text("Sign in with Google", style: TextStyle(fontSize: 17, color: secondaryTextColor,fontWeight: FontWeight.w500),),
//                ),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Don\'t have a account? ", style: TextStyle(fontSize: 17, color: secondaryTextColor,fontWeight: FontWeight.w400,)),
                    InkWell(
                      onTap: (){
                        widget.toggle();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text("Register now", style: TextStyle(fontSize: 17, color: buttonSecondary,fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline
                        ),),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}


