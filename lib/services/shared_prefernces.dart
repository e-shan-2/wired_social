import 'package:shared_preferences/shared_preferences.dart';
import 'package:wired_social/utils/app_string.dart';

class SharedPrefernceClass {
  static final SharedPrefernceClass _instance =
      SharedPrefernceClass._internal();
  factory SharedPrefernceClass() {
    return _instance;
  }
  SharedPrefernceClass._internal();

  Future<String> getUserId(String id) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(id) ?? AppStrings.unableToFindUSerId;
  }

  Future<void> setUserId(String id, String value) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString(id, value);
  }

  // Future<void>setChatonce(String user,bool value)async{
  //    SharedPreferences _prefs = await SharedPreferences.getInstance();
  //    _prefs.s

  // }
}
