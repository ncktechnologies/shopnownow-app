

import 'package:shopnownow/app/helpers/notifiers.dart';
import 'package:shopnownow/app/helpers/service_response.dart';
import 'package:shopnownow/app/helpers/session_manager.dart';
import 'package:shopnownow/modules/profile/model/profile_model.dart';
import 'package:shopnownow/utils/logger.dart';

class ProfileRepository {
  static Future<NotifierState<String>> updatePassword({required String currentPassword,
    required String newPassword,
  }) async {
    return (await ApiService<String>().postCall(
        "/user/profile/change_password",
        ServiceRequest(
          serviceRequest: {
            "current_password": currentPassword,
            "new_password": newPassword,
            "new_password_confirmation" : newPassword
          },
        ),
        hasToken: true,
        onReturn: (response) => logResponse(response),
        getDataFromResponse: (data) {
          return data["message"];
        }))
        .toNotifierState();
  }

  static Future<NotifierState<GetProfile>> getProfile() async {
    return (await ApiService<GetProfile>().getCall(
        "/user/profile/show",
        hasToken: true,
        onReturn: (response) => logResponse(response),
        getDataFromResponse: (data) {
          return GetProfile.fromJson(data);
        }))
        .toNotifierState();
  }

  static Future<NotifierState<GetProfile>> updateProfile({required String name,
     String? phone,
  }) async {
    return (await ApiService<GetProfile>().postCall(
        "/user/profile/user/${SessionManager.getUserId()}",
        ServiceRequest(
          serviceRequest: {
            "name": name,
            "phone_number": phone,
          },
        ),
        hasToken: true,
        onReturn: (response) => logResponse(response),
        getDataFromResponse: (data) {
          return GetProfile.fromJson(data);
        }))
        .toNotifierState();
  }
}