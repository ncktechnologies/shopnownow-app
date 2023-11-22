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
}