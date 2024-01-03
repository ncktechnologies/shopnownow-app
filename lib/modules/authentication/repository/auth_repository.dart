
import 'package:shopnownow/app/helpers/notifiers.dart';
import 'package:shopnownow/app/helpers/service_response.dart';
import 'package:shopnownow/app/helpers/session_manager.dart';
import 'package:shopnownow/utils/logger.dart';

class AuthRepository {
  static Future<NotifierState<void>> signUp(
      {required String email,
      required String password,
      required String fullName,
      }) async {
    return (await ApiService<void>().postCall(
            "/user/auth/register",
            ServiceRequest(
              serviceRequest: {
                "email": email,
                "password": password,
                "name": fullName,
                "password_confirmation": password,
              },
            ),
            onReturn: (response) => logResponse(response),
            getDataFromResponse: (data) {
                SessionManager.setToken(data["access_token"]);
                SessionManager.setEmail(data["user"]["email"]);
              return data;
            }))
        .toNotifierState();
  }


  static Future<NotifierState> logIn(
      {required String email, required String password}) async {
    return (await ApiService().postCall(
            "/user/auth/login",
            ServiceRequest(
              serviceRequest: {"email": email, "password": password},
            ), onReturn: (response) {
      return logResponse(response);
    }, getDataFromResponse: (data) {
              if(data["message"].toString().contains("Invalid")){

              }else{
                SessionManager.setToken(data["access_token"]);
                SessionManager.setFullName(data["user"]["name"]);
                SessionManager.setEmail(data["user"]["email"]);
                SessionManager.setUserId(data["user"]["id"]);
                SessionManager.setWallet(data["user"]["wallet"]);
                SessionManager.setLoyaltyPoints(data["user"]["loyalty_points"]);

              }
      return data;
    }))
        .toNotifierState();
  }

  static Future<NotifierState<String>> sendOtp({required String email}) async {
    return (await ApiService<String>().postCall(
            "/user/auth/send-password-reset-otp",
            ServiceRequest(
              serviceRequest: {
                "email": email,
                "password_reset_method": "email",
                "phone_number": SessionManager.getPhone()
              },
            ),
            onReturn: (response) => logResponse(response),
            getDataFromResponse: (data) {
              return data["message"];
            }))
        .toNotifierState();
  }

  static Future<NotifierState<String>> forgotVerifyOtp(
      {required String email, required String otp}) async {
    return (await ApiService<String>().postCall(
            "/user/auth/verify_otp",
            ServiceRequest(
              serviceRequest: {
                "otp": otp,
                "email" : email
              },
            ),
            onReturn: (response) => logResponse(response),
            getDataFromResponse: (data) {
              return data["message"];
            }))
        .toNotifierState();
  }

  static Future<NotifierState<String>> resendOtp(
      {required String email,}) async {
    return (await ApiService<String>().postCall(
            "/user/auth/resend_otp",
            ServiceRequest(
              serviceRequest: {
                "email" : email
              },
            ),
            onReturn: (response) => logResponse(response),
            getDataFromResponse: (data) {
              return data["message"];
            }))
        .toNotifierState();
  }

  static Future<NotifierState<String>> resetPassword({
    required String otp,
    required String password,
    required String confirmPassword,
    required String email,
  }) async {
    return (await ApiService<String>().postCall(
            "/user/auth/reset_password",
            ServiceRequest(
              serviceRequest: {
                "otp": otp,
                "email": email,
                "password": password,
                "password_confirmation": confirmPassword
              },
            ),
            onReturn: (response) => logResponse(response),
            getDataFromResponse: (data) {
              return data["message"];
            }))
        .toNotifierState();
  }


  static Future<NotifierState<String>> forgotPassword(String email) async {
    return (await ApiService<String>().postCall(
            "/user/auth/forgot_password",
            ServiceRequest(serviceRequest: {"email" : email,}),
            hasToken: true,
            onReturn: (response) => logResponse(response),
            getDataFromResponse: (data) {
              return data["message"];
            }))
        .toNotifierState();
  }
}
