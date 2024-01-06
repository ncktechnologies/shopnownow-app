import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static late SharedPreferences prefs;

  static Future initSharedPreference() async {
    prefs = await SharedPreferences.getInstance();
  }

  ///User setters
  static String userId = "user_id";
  static String email = "email";
  static String contactEmail = "contactEmail";
  static String contactPhone = "contactPhone";
  static String fullName = "fullName";
  static String phoneNumber = "phoneNo";
  static String dateOfBirth = "dateOfBirth";
  static String token = "token";
  static String gender = "gender";
  static String profilePhoto = "profilePhoto";
  static String logOut = "logOut";
  // static String expiry = "expiry";
  static String wallet = "wallet";
  static String loyaltyPoints = "loyaltyPoints";
  static String terms = "terms_and_conditions";
  static String privacy = "privacy_policy";
  static String instagram = "instagram";
  static String facebook = "facebook";
  static String twitter = "x";
  static String faq = "faq";

  /// Sessions
  static String sessionToken = "session_token";

  /// SETTERS
  static void setUserId(int value) {
    SessionManager.prefs.setInt(userId, value);
  }

  static void setWallet(String value) {
    SessionManager.prefs.setString(wallet, value);
  }

  static void setTerms(String value) {
    SessionManager.prefs.setString(terms, value);
  }

  static void setTwitter(String value) {
    SessionManager.prefs.setString(twitter, value);
  }

  static void setFacebook(String value) {
    SessionManager.prefs.setString(facebook, value);
  }

  static void setPrivacy(String value) {
    SessionManager.prefs.setString(privacy, value);
  }

  static void setInstagram(String value) {
    SessionManager.prefs.setString(instagram, value);
  }

  static void setLoyaltyPoints(int value) {
    SessionManager.prefs.setInt(loyaltyPoints, value);
  }

  static void setLogOut(bool value) {
    SessionManager.prefs.setBool(logOut, value);
  }

  static void setEmail(String value) {
    SessionManager.prefs.setString(email, value);
  }

  static void setContactPhone(String value) {
    SessionManager.prefs.setString(contactPhone, value);
  }

  static void setFullName(String value) {
    SessionManager.prefs.setString(fullName, value);
  }

  static void setPhone(String value) {
    SessionManager.prefs.setString(phoneNumber, value);
  }

  static void setToken(String value) {
    SessionManager.prefs.setString(token, value);
  }

  static void setContactEmail(String value) {
    SessionManager.prefs.setString(contactEmail, value);
  }

  static void setFaq(String value) {
    SessionManager.prefs.setString(faq, value);
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

  static String? getInstagram() {
    return SessionManager.prefs.getString(instagram);
  }

  static String? getFacebook() {
    return SessionManager.prefs.getString(facebook);
  }

  static String? getTwitter() {
    return SessionManager.prefs.getString(twitter);
  }

  static String? getTerms() {
    return SessionManager.prefs.getString(terms);
  }

  static String? getPrivacy() {
    return SessionManager.prefs.getString(privacy);
  }

  static int? getLoyaltyPoints() {
    return SessionManager.prefs.getInt(loyaltyPoints);
  }

  static String? getWallet() {
    return SessionManager.prefs.getString(wallet);
  }

  static String? getProfilePhoto() {
    return SessionManager.prefs.getString(profilePhoto);
  }

  static String? getDateOfBirth() {
    return SessionManager.prefs.getString(dateOfBirth);
  }

  static String? getContactEmail() {
    return SessionManager.prefs.getString(contactEmail);
  }

  static String? getFullName() {
    return SessionManager.prefs.getString(fullName);
  }

  static String? getContactPhone() {
    return SessionManager.prefs.getString(contactPhone);
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
  static String? getFaq() {
    return SessionManager.prefs.getString(faq);
  }

  static void clear() async {
    await prefs.clear();
  }

  static clearToken() async {
    await prefs.remove(token);
    await prefs.remove(userId);
    await prefs.remove(fullName);
    await prefs.remove(email);
    await prefs.remove(wallet);
    await prefs.remove(loyaltyPoints);
    await prefs.remove(phoneNumber);
  }
}
