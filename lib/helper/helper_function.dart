import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  //keys
  static String userLoggedInKey = "LOGGEDINKEY";
  static String userNameKey = 'USERNAMEKEY';
  static String userEmailKey = 'USEREMAILKEY';
  static String userChatIdKey = 'USERCHATID';
  static String userPhoneNumberKey = 'USERPHONENUMBERKEY';
  static String userSignedUpUsingEmailOnlyKey = 'USERSIGNEDUPUSINGEMAILONLY';
  static String yesOrNoKey = 'YESORNO';
  static String userDoneWithChatbotKey = 'USERDONEWITHCHATBOT';

  static String adminLoggedInKey = "ADMINLOGGEDINKEY";

  // saving the data to Shared Preferences

  static Future<bool> saveAdminLoggedInStatus(bool isAdminLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(adminLoggedInKey, isAdminLoggedIn);
  }

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

  static Future<bool> saveUserSignedUpUsingEmailOnly(
      bool isSignedUpUsingEmailOnly) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(
        userSignedUpUsingEmailOnlyKey, isSignedUpUsingEmailOnly);
  }

  static Future<bool> saveYesOrNo(String yesOrNo) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(yesOrNo, yesOrNo);
  }

  static Future<bool> saveUserDoneWithChatbot(bool isDoneWithChatbot) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userDoneWithChatbotKey, isDoneWithChatbot);
  }

  // getting the data from Shared Preferences

  static Future<bool?> getAdminLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(adminLoggedInKey);
  }

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

  static Future<bool?> getUserSignedUpUsingEmailOnly() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userSignedUpUsingEmailOnlyKey);
  }

  static Future<String?> getYesOrNo() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(yesOrNoKey);
  }

  static Future<bool?> getUserDoneWithChatbot() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userDoneWithChatbotKey);
  }
}
