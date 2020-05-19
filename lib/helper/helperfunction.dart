import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction{
  static String userLoggedInKey = "ISLOGGEDIN";
  static String userNameKey  = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";

  // saving data to shared preferences
  static Future<bool> saveUserLoggedIn(bool isUserLoggedIn) async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    return await prefs.setBool(userLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserName(String userName) async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    return await prefs.setString(userNameKey, userName);
  }

  static Future<bool> saveUserEmail(String userEmail) async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    return await prefs.setString(userEmailKey, userEmail);
  }


  //getting data from shared preferences
  static Future<bool> getUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return  prefs.getBool(userLoggedInKey);
  }

  static Future<String> getUserName() async {
    SharedPreferences prefs  = await SharedPreferences.getInstance();
    return  prefs.getString(userNameKey);
  }

  static Future<String> getUserEmail() async {
    SharedPreferences prefs  = await SharedPreferences.getInstance();
    return  prefs.getString(userEmailKey);
  }
}