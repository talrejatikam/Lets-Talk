import 'package:chatapp/services/auth.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/views/signin.dart';
import 'package:chatapp/widgets/color.dart';
import 'package:chatapp/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgetPassword extends StatefulWidget {
  final Function toggle;
  ForgetPassword(this.toggle);


  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final formkey = GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController emailTEC = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
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
                    ],
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


                          try{
                            if(formkey.currentState.validate()) {
                              authMethods.resetPassword(emailTEC.text);
                              Navigator.pushReplacement(
                                  context, MaterialPageRoute(
                                  builder: (context) => SignIn(widget.toggle)
                              )

                              );
                            }

                            else{
                              SnackBar(content: Text("Please enter a valid email"),);
//                              Fluttertoast.showToast(
//                                  msg: "Invalid email address",
//
//                                  toastLength: Toast.LENGTH_SHORT,
//                                  gravity: ToastGravity.SNACKBAR,
//                                  timeInSecForIosWeb: 1,
//                                  textColor: secondaryTextColor,
//                                  backgroundColor: Colors.yellow,
//
//                                  fontSize: 16.0
//                              );

                            }

                          }catch (e){
                            Fluttertoast.showToast(
                                 msg: e.toString(),

                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.SNACKBAR,
                                timeInSecForIosWeb: 1,
                                textColor: secondaryTextColor,
                                backgroundColor: Colors.yellow,

                                fontSize: 16.0
                            );
                          }


                      },
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Submit", style: buttonTextStyle(),),

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

                SizedBox(height: 50,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}