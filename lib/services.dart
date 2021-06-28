import 'package:shared_preferences/shared_preferences.dart';

//this class will be used to save the level the user has gotten to in  the game
class SharedPrefs{
// this static function will be used to save the image in the the local system
  static Future<bool> setUserLevel(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('level', token);
  }
  //this function will be used to get the data saved in the local system
  static Future<String> getUserLevel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Future(() => prefs.getString('level'));
  }
  // this fuction will be used to remove the level data that is saved if the need arise
  static Future<bool> removeUserLevel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove('level');
  }
}