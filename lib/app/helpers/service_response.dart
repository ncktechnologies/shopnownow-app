

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shopnownow/app/helpers/notifiers.dart';
import 'package:shopnownow/app/helpers/service_constants.dart';
import 'package:shopnownow/app/helpers/session_manager.dart';
import 'package:shopnownow/utils/constants.dart';
import 'package:shopnownow/utils/extras.dart';
import 'package:shopnownow/utils/logger.dart';


class ServiceRequest<T> {
  late final T serviceRequest;
  final String? sessionToken;

  ServiceRequest({required this.serviceRequest, this.sessionToken});

  @override
  String toString() {
    return 'ServiceRequest{serviceRequest: $serviceRequest, sessionToken: $sessionToken}';
  }
}

class ServiceResponse<T> {
  late bool status;
  final T? data;
  final String? message;
  final bool notAuthenticated;

  ServiceResponse(
      {this.data,
      this.message,
      required this.status,
      this.notAuthenticated = false});

  NotifierState<T> toNotifierState() {
    return status
        ? notifyRight<T>(data: data, message: message)
        : notifyError<T>(
            error: message ?? "Something went wrong",
            noAuth: notAuthenticated,
          );
  }

  @override
  String toString() {
    return 'ServiceResponse{status: $status, data: $data, message: $message}';
  }
}

ServiceResponse<T> serveSuccess<T>({required T? data, String? message}) {
  return ServiceResponse<T>(
    status: true,
    message: message,
    data: data,
  );
}

ServiceResponse<T> noMessageServeSuccess<T>({
  required T? data,
}) {
  return ServiceResponse<T>(
    status: true,
    data: data,
  );
}

ServiceResponse<T> serveError<T>(
    {required String error, T? data, bool notAuthenticated = false}) {
  return ServiceResponse<T>(
    status: false,
    message: error,
    data: data,
    notAuthenticated: notAuthenticated,
  );
}

class ApiService<T> {
  Future<ServiceResponse<T>> getCall(String url,
      {required T Function(dynamic) getDataFromResponse,
        Function(http.Response)? onReturn,
        bool hasToken = false,  bool urlChange = false,}) async {
    log(url);
    try {
      http.Response response = await http
          .get(Uri.parse(urlChange ? url : "${baseUrl()}$url"),
          headers: ApiHeaders.getHeadersForRequest(hasToken: hasToken))
          .timeout(requestDuration);
      if (onReturn != null) onReturn(response);
      if (response.statusCode >= 300 && response.statusCode <= 520) {
        throw Error.fromJson(jsonDecode(response.body));
      } else {
        var responseBody = jsonDecode(response.body);
        return serveSuccess<T>(
            data: getDataFromResponse(responseBody),
            message: responseBody?["message"] ?? "Successful");
      }
    } catch (error, stack) {
      return processServiceError<T>(error, stack);
    }
  }

  // Future<ServiceResponse<T>> addPicture(
  //     String url, String req, {required T Function(dynamic) getDataFromResponse,
  //       Function(http.Response)? onReturn,
  //       bool hasToken = false,
  //       required XFile image,
  //       }) async {
  //
  //   try {
  //     var request = await http.MultipartRequest("POST", Uri.parse("${baseUrl()}$url"));
  //     request.headers.addAll(ApiHeaders.getHeadersForRequest(isFormData: true));
  //
  //
  //       request.files.add(await http.MultipartFile.fromBytes(
  //           req, await image.readAsBytes(),
  //           contentType: MediaType('image', image.path.split(".").last),
  //           filename: image.name));
  //
  //     http.StreamedResponse res = await request.send().timeout(requestDuration);
  //     Map<String, dynamic> responseBody = {};
  //     await res.stream.transform(utf8.decoder).listen((value) {
  //       responseBody = jsonDecode(value);
  //       log(responseBody);
  //     });
  //     if (res.statusCode >= 300 && res.statusCode <= 520) {
  //       throw responseBody["message"] ?? "Error, Please try again later";
  //     } else {
  //       return serveSuccess<T>(
  //           data: getDataFromResponse(responseBody), message: res.reasonPhrase);
  //     }
  //   } catch (error, stack) {
  //     return processServiceError<T>(error, stack);
  //   }
  // }

  Future<ServiceResponse<T>> postCall(
      String url, ServiceRequest<Map<String, dynamic>> req,

      {required T Function(dynamic) getDataFromResponse,
        Function(http.Response)? onReturn,

        bool hasToken = false}) async {
    log("${baseUrl()}$url\n${req.serviceRequest}");
    try {
      http.Response response = await http
          .post(Uri.parse( "${baseUrl()}$url"),
          body: req.serviceRequest,
          headers: ApiHeaders.getHeadersForRequest(hasToken: hasToken))
          .timeout(requestDuration);
      if (onReturn != null) onReturn(response);
      if (response.statusCode >= 300 && response.statusCode <= 520) {
        throw Error.fromJson(jsonDecode(response.body));
      } else {
        var responseBody = jsonDecode(response.body);
        return serveSuccess<T>(
            data: getDataFromResponse(responseBody),
            message: responseBody?["message"] ?? "Successful");
      }
    } catch (error, stack) {
      return processServiceError<T>(error, stack);
    }
  }

  Future<ServiceResponse<T>> postCallNoForm(
      String url, ServiceRequest<Map<String, dynamic>> req,

      {required T Function(dynamic) getDataFromResponse,
        Function(http.Response)? onReturn,
        bool hasToken = false, bool urlChange = false,}) async {
    log("${baseUrl()}$url\n${req.serviceRequest}");
    try {
      http.Response response = await http
          .post(Uri.parse( urlChange ? url : "${baseUrl()}$url"),
          body: jsonEncode(req.serviceRequest),
          headers: ApiHeaders.headersSessionAuthNoForm(SessionManager.getToken()))
          .timeout(requestDuration);
      if (onReturn != null) onReturn(response);
      if (response.statusCode >= 300 && response.statusCode <= 520) {
        throw Error.fromJson(jsonDecode(response.body));
      } else {
        var responseBody = jsonDecode(response.body);
        return serveSuccess<T>(
            data: getDataFromResponse(responseBody),
            message: responseBody?["message"] ?? "Successful");
      }
    } catch (error, stack) {
      return processServiceError<T>(error, stack);
    }
  }

  Future<ServiceResponse<T>> patchCall(
      String url, ServiceRequest<Map<String, dynamic>> req,
      {required T Function(dynamic) getDataFromResponse,
        Function(http.Response)? onReturn,
        bool hasToken = false}) async {
    log("${baseUrl()}$url\n${req.serviceRequest}");
    try {
      http.Response response = await http
          .patch(Uri.parse("${baseUrl()}$url"),
          body: req.serviceRequest,
          headers: ApiHeaders.getHeadersForRequest(hasToken: hasToken))          .timeout(requestDuration);
      if (onReturn != null) onReturn(response);
      if (response.statusCode >= 300 && response.statusCode <= 520) {
        throw Error.fromJson(jsonDecode(response.body));
      } else {
        var responseBody = jsonDecode(response.body);
        return serveSuccess<T>(
            data: getDataFromResponse(responseBody),
            message: responseBody?["message"] ?? "Successful");
      }
    } catch (error, stack) {
      return processServiceError<T>(error, stack);
    }
  }

  Future<ServiceResponse<T>> putCall(
      String url, ServiceRequest<Map<String, dynamic>> req,
      {required T Function(dynamic) getDataFromResponse,
        bool hasToken = false,
        Function(http.Response)? onReturn}) async {
    log("$url\n${req.serviceRequest}");
    try {
      http.Response response = await http
          .put(
          Uri.parse(
            "${baseUrl()}$url",
          ),
          body: req.serviceRequest,
          headers: ApiHeaders.getHeadersForRequest(hasToken: hasToken))
          .timeout(requestDuration);
      if (onReturn != null) onReturn(response);
      if (response.statusCode >= 300 && response.statusCode <= 520) {
        throw Error.fromJson(jsonDecode(response.body));
      } else {
        var responseBody = jsonDecode(response.body);
        return serveSuccess<T>(
            data: getDataFromResponse(responseBody),
            message: responseBody?["message"] ?? "Successful");
      }
    } catch (error, stack) {
      return processServiceError<T>(error, stack);
    }
  }

  Future<ServiceResponse<T>> deleteCall(String url,
      {required T Function(dynamic) getDataFromResponse,
        Function(http.Response)? onReturn,
        bool hasToken = false}) async {
    log("${baseUrl()}$url\n");
    try {
      http.Response response = await http
          .delete(Uri.parse("${baseUrl()}$url"),
          headers: ApiHeaders.getHeadersForRequest(hasToken: hasToken))
          .timeout(requestDuration);
      if (onReturn != null) onReturn(response);
      if (response.statusCode >= 300 && response.statusCode <= 520) {
        throw Error.fromJson(jsonDecode(response.body));
      } else {
        var responseBody = jsonDecode(response.body);
        return serveSuccess<T>(
            data: getDataFromResponse(responseBody),
            message: responseBody?["message"] ?? "Successful");
      }
    } catch (error, stack) {
      return processServiceError<T>(error, stack);
    }
  }

  Future<ServiceResponse<T>> getCallOnlyList(
      String url, {
        required T Function(dynamic) getDataFromResponse,
        Function(http.Response)? onReturn,
        bool hasToken = false,
        bool urlChange = false,
      }) async {
    log(url);
    try {
      http.Response response = await http
          .get(Uri.parse(urlChange ? url : "${baseUrl()}$url"),
          headers: ApiHeaders.getHeadersForRequest(hasToken: hasToken))
          .timeout(requestDuration);
      if (onReturn != null) onReturn(response);
      if (response.statusCode >= 300 && response.statusCode <= 520) {
        throw Error.fromJson(jsonDecode(response.body));
      } else {
        var responseBody = jsonDecode(response.body);
        return noMessageServeSuccess<T>(
          data: getDataFromResponse(responseBody),
        );
      }
    } catch (error, stack) {
      return processServiceError<T>(error, stack);
    }
  }
}
