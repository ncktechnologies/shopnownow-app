import 'dart:convert';

import 'package:shopnownow/app/helpers/notifiers.dart';
import 'package:shopnownow/app/helpers/service_response.dart';
import 'package:shopnownow/app/helpers/session_manager.dart';
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

  static Future<NotifierState<GetTimeSlot>> getTimeSlot(int id) async {
    return (await ApiService<GetTimeSlot>().getCall(
        "/user/delivery-time-slots/list?id$id",
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
          return data["coupon"]["value"];
        }))
        .toNotifierState();
  }

  static Future<NotifierState<Map<String, dynamic>>> getContact() async {
    return (await ApiService<Map<String, dynamic>>().getCall(
        "/user/site-data/site_data",
        onReturn: (response) => logResponse(response),
        getDataFromResponse: (data) {
          SessionManager.setPrivacy(data["privacy_policy"]);
          SessionManager.setTerms(data["terms_and_conditions"]);
          SessionManager.setFaq(data["faq"]);
          SessionManager.setInstagram(data["contact_data"].toString().split(";").first);
          SessionManager.setFacebook(data["contact_data"].toString().split(";")[1]);
          SessionManager.setTwitter(data["contact_data"].toString().split(";")[2]);
          SessionManager.setContactEmail(data["contact_data"].toString().split(";")[4]);
          SessionManager.setContactPhone(data["contact_data"].toString().split(";")[3]);
          return data;
        }))
        .toNotifierState();
  }

  static Future<NotifierState<List<GetQuickGuide>>> getQuickGuide() async {
    return (await ApiService<List<GetQuickGuide>>().getCallOnlyList(
        "/user/quickguide/list",
        onReturn: (response) => logResponse(response),
        getDataFromResponse: (data) {
          return getQuickGuideFromJson(jsonEncode(data));
        }))
        .toNotifierState();
  }




}