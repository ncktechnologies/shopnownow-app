import 'package:shopnownow/app/helpers/notifiers.dart';
import 'package:shopnownow/app/helpers/service_response.dart';
import 'package:shopnownow/utils/logger.dart';

class SpecialRepository {
  static Future<NotifierState<String>> makeSpecialRequest({required String comment,
    required String request,
  }) async {
    return (await ApiService<String>().postCall(
        "/user/special_request/create",
        ServiceRequest(
          serviceRequest: {
            "request": request,
            "comment": comment,
          },
        ),
        hasToken: true,
        onReturn: (response) => logResponse(response),
        getDataFromResponse: (data) {
          return data["message"];
        }))
        .toNotifierState();
  }
}