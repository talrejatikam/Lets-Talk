import 'package:chatapp/helper/helperfunction.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/views/chatroomscreens.dart';
import 'package:chatapp/widgets/color.dart';
import 'package:chatapp/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/services/auth.dart';


class SignUp extends StatefulWidget {

  final Function toggle;
  SignUp(this.toggle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool isLoading = false;

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  final formKey = GlobalKey<FormState>();
  TextEditingController userNameTEC = new TextEditingController();
  TextEditingController emailTEC = new TextEditingController();
  TextEditingController passwordTEC = new TextEditingController();

  signMeUp(){
    if(formKey.currentState.validate()){
      Map<String, String> userInfoMap = {
        "name" : userNameTEC.text,
        "email" : emailTEC.text
      };
      HelperFunction.saveUserEmail(emailTEC.text);
      HelperFunction.saveUserName(userNameTEC.text);


      setState(() {
      isLoading = true;
    });
     authMethods.signUpWithEmailPassword(emailTEC.text, passwordTEC.text).then((val){



       databaseMethods.uploadUserInfo(userInfoMap);
       HelperFunction.saveUserLoggedIn(true);

       Navigator.pushReplacement(context, MaterialPageRoute(
         builder: (context)=> ChatRoom()
       ));
     });
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: isLoading?Container(child: Center(child: CircularProgressIndicator(),),): Container(
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
                key: formKey,
                child:   Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (val){
                        return val.isEmpty || val.length < 4 ? "please provide valid  username" : null;
                      },
                      controller: userNameTEC,
                      style: textStyle(),
                      decoration: textFiled("username"),
                    ),
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
              )
                ,SizedBox(height: 16,),
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
                        signMeUp();
                      },
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Sign up", style: buttonTextStyle()),
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
//                      color: buttonSecondary
//                  ),
//                  alignment: Alignment.center,
//                  width: MediaQuery.of(context).size.width,
//                  child: Text("Sign up with Google", style: TextStyle(fontSize: 17, color: secondaryTextColor,fontWeight: FontWeight.w500),),
//                ),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Already have a account? ", style: TextStyle(fontSize: 17, color: secondaryTextColor,fontWeight: FontWeight.w400,)),
                    InkWell(

                      onTap: (){
                        widget.toggle();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text("Sign in", style: TextStyle(fontSize: 17, color: buttonSecondary,fontWeight: FontWeight.w600,
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


