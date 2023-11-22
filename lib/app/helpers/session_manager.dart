
import 'package:shared_preferences/shared_preferences.dart';


class SessionManager {
  static late SharedPreferences prefs;

  static Future initSharedPreference() async {
    prefs = await SharedPreferences.getInstance();
  }

  ///User setters
  static String userId = "user_id";
  static String email = "email";
  static String userName = "username";
  static String firstName = "firstName";
  static String lastName = "lastName";
  static String fullName = "fullName";
  static String phoneNumber = "phoneNo";
  static String dateOfBirth = "dateOfBirth";
  static String token = "token";
  static String gender = "gender";
  static String profilePhoto = "profilePhoto";
  static String logOut = "logOut";
  static String expiry = "expiry";
  static String wallet = "wallet";
  static String loyaltyPoints = "loyaltyPoints";



  /// Sessions
  static String sessionToken = "session_token";

  /// SETTERS
  static void setUserId(int value) {
    SessionManager.prefs.setInt(userId, value);
  }

  static void setWallet(String value) {
    SessionManager.prefs.setString(wallet, value);
  }

  static void setLoyaltyPoints(int value) {
    SessionManager.prefs.setInt(loyaltyPoints, value);
  }

  static void setExpiry(String value) {
    SessionManager.prefs.setString(expiry, value);
  }

  static void setLogOut(bool value) {
    SessionManager.prefs.setBool(logOut, value);
  }

  static void setEmail(String value) {
    SessionManager.prefs.setString(email, value);
  }

  static void setUserName(String value) {
    SessionManager.prefs.setString(userName, value);
  }

  static void setLastName(String value) {
    SessionManager.prefs.setString(lastName, value);
  }

  static void setFullName(String value) {
    SessionManager.prefs.setString(fullName, value);
  }

  static void setPhone(String value) {
    SessionManager.prefs.setString(phoneNumber, value);
  }

  static void setDateOfBirth(DateTime value) {
    SessionManager.prefs.setString(dateOfBirth, value.toString());
  }

  static void setToken(String value) {
    SessionManager.prefs.setString(token, value);
  }

  static void setFirstName(String value) {
    SessionManager.prefs.setString(firstName, value);
  }

  static void setProfilePhoto(String value) {
    SessionManager.prefs.setString(profilePhoto, value);
  }

  static void setGender(String value) {
    SessionManager.prefs.setString(gender, value);
  }


  /// GETTERS
  static int? getUserId() {
    return SessionManager.prefs.getInt(userId);
  }

  static bool? getLogOutStatus() {
    return SessionManager.prefs.getBool(logOut);
  }

  static String? getEmail() {
    return SessionManager.prefs.getString(email);
  }

  static int? getLoyaltyPoints() {
    return SessionManager.prefs.getInt(loyaltyPoints);
  }

  static String? getWallet() {
    return SessionManager.prefs.getString(wallet);
  }

  static String? getExpiry() {
    return SessionManager.prefs.getString(expiry);
  }

  static String? getProfilePhoto() {
    return SessionManager.prefs.getString(profilePhoto);
  }

  static String? getUserName() {
    return SessionManager.prefs.getString(userName);
  }

  static String? getDateOfBirth() {
    return SessionManager.prefs.getString(dateOfBirth);
  }


  static String? getFirstName() {
    return SessionManager.prefs.getString(firstName);
  }

  static String? getFullName() {
    return SessionManager.prefs.getString(fullName);
  }

  static String? getLastName() {
    return SessionManager.prefs.getString(lastName);
  }

  static String? getPhone() {
    return SessionManager.prefs.getString(phoneNumber);
  }

  static String? getToken() {
    return SessionManager.prefs.getString(token);
  }

  static String? getGender() {
    return SessionManager.prefs.getString(gender);
  }

  static void clear() async{
    await prefs.clear();
  }
}
