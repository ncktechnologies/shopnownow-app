import 'dart:convert';

import 'package:shopnownow/app/helpers/notifiers.dart';
import 'package:shopnownow/app/helpers/service_response.dart';
import 'package:shopnownow/modules/homepage/model/homepage_model.dart';
import 'package:shopnownow/utils/logger.dart';

class HomePageRepository {
  static Future<NotifierState<List<GetCategories>>> getCategories() async {
    return (await ApiService<List<GetCategories>>().getCallOnlyList(
        "/user/category/list",
        // hasToken: true,
        onReturn: (response) => logResponse(response),
        getDataFromResponse: (data) {
          return getCategoriesFromJson(jsonEncode(data));
        }))
        .toNotifierState();
  }

  static Future<NotifierState<GetProductsBySearch>> getProductsBySearch({required String query, required String categoryId }) async {
    return (await ApiService<GetProductsBySearch>().getCall(
        "/user/product/search/$query/$categoryId",
        onReturn: (response) => logResponse(response),
        getDataFromResponse: (data) {
          return GetProductsBySearch.fromJson(data);
        }))
        .toNotifierState();
  }

  static Future<NotifierState<GetProductsBySearch>> getSavedList({required String query, required String categoryId }) async {
    return (await ApiService<GetProductsBySearch>().getCall(
        "/user/shopping_list/lists",
        onReturn: (response) => logResponse(response),
        getDataFromResponse: (data) {
          return GetProductsBySearch.fromJson(data);
        }))
        .toNotifierState();
  }

  static Future<NotifierState<String>> addToList({required AddProductRequest request }) async {
    return (await ApiService<String>().postCallNoForm(
        "/user/shopping_list/save_list",
        ServiceRequest(serviceRequest: request.toJson()),
        hasToken: true,
        onReturn: (response) => logResponse(response),
        getDataFromResponse: (data) {
          return data["message"];
        }))
        .toNotifierState();
  }

  static Future<NotifierState<GetLocation>> getLocations() async {
    return (await ApiService<GetLocation>().getCall(
        "/user/delivery-locations",
        // hasToken: true,
        onReturn: (response) => logResponse(response),
        getDataFromResponse: (data) {
          return GetLocation.fromJson(data);
        }))
        .toNotifierState();
  }

  static Future<NotifierState<GetTimeSlot>> getTimeSlot() async {
    return (await ApiService<GetTimeSlot>().getCall(
        "/user/delivery-time-slots/list",
        // hasToken: true,
        onReturn: (response) => logResponse(response),
        getDataFromResponse: (data) {
          return GetTimeSlot.fromJson(data);
        }))
        .toNotifierState();
  }

  static Future<NotifierState<Map<String, dynamic>>> createOrder({required CreateOrderRequest orderRequest}) async {
    return (await ApiService<Map<String, dynamic>>().postCallNoForm(
        "/user/order-noauth/orders",
        ServiceRequest(serviceRequest: orderRequest.toJson()),
        // hasToken: true,
        onReturn: (response) => logResponse(response),
        getDataFromResponse: (data) {
          Map<String, dynamic> myResult = {
            "message" : data["message"],
            "orderId" : data["order"]["id"]
          };
          return myResult;
        }))
        .toNotifierState();
  }

  static Future<NotifierState<String>> processPayment({bool noToken = false, required ProcessPaymentRequest paymentRequest}) async {
    return (await ApiService<String>().postCall(
      noToken ? "/user/payment/process-payment-non-auth" :  "/user/payment/process",
        ServiceRequest(serviceRequest: paymentRequest.toJson()),
        // hasToken: true,
        onReturn: (response) => logResponse(response),
        getDataFromResponse: (data) {
          return data["message"];
        }))
        .toNotifierState();
  }

  static Future<NotifierState<String>> loadCoupon({required String coupon}) async {
    return (await ApiService<String>().postCall(
        "/user/coupons/load",
        ServiceRequest(serviceRequest: {
          "code" : coupon
        }),
        // hasToken: true,
        onReturn: (response) => logResponse(response),
        getDataFromResponse: (data) {
          return data["message"];
        }))
        .toNotifierState();
  }
}