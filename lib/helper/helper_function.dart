import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  //keys
  static String userLoggedInKey = "LOGGEDINKEY";
  static String userNameKey = 'USERNAMEKEY';
  static String userEmailKey = 'USEREMAILKEY';
  static String userChatIdKey = 'USERCHATID';
  static String userPhoneNumberKey = 'USERPHONENUMBERKEY';
  static String userSignedUpUsingEmail = 'USERSIGNEDUPUSINGEMAIL';

  // saving the data to Shared Preferences

  static Future<bool> saveUserLoggedInStatus(bool isUserLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameSF(String userName) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userNameKey, userName);
  }

  static Future<bool> saveUserEmailSF(String userEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailKey, userEmail);
  }

  static Future<bool> saveUserPhoneNumberSF(String userPhoneNumber) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userPhoneNumberKey, userPhoneNumber);
  }

  static Future<bool> saveUserSignedUpUsingEmail(
      bool isSignedUpUsingEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userSignedUpUsingEmail, isSignedUpUsingEmail);
  }

  // getting the data from Shared Preferences

  static Future<bool?> getUserLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInKey);
  }

  static Future<String?> getUserEmailFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userEmailKey);
  }

  static Future<String?> getUserNameFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userNameKey);
  }

  static Future<String?> getUserPhoneNumberFromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userPhoneNumberKey);
  }

  static Future<bool?> getUserSignedUpUsingEmail() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userSignedUpUsingEmail);
  }
}
