import 'package:shopnownow/app/helpers/notifiers.dart';
import 'package:shopnownow/app/helpers/service_response.dart';
import 'package:shopnownow/modules/orders/model/order_model.dart';
import 'package:shopnownow/utils/logger.dart';

class OrderRepository{
  static Future<NotifierState<OrderResponse>> getOrders() async {
    return (await ApiService<OrderResponse>().getCall(
        "/user/orders/orders",
        hasToken: true,
        onReturn: (response) => logResponse(response),
        getDataFromResponse: (data) {
          return OrderResponse.fromJson(data);
        }))
        .toNotifierState();
  }

  static Future<NotifierState<String>> reOrder({required String id}) async {
    return (await ApiService<String>().postCall(
        "/user/orders/reorder/$id",
        ServiceRequest(serviceRequest: {}),
        hasToken: true,
        onReturn: (response) => logResponse(response),
        getDataFromResponse: (data) {
          return data["message"];
        }))
        .toNotifierState();
  }

}