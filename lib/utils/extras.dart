// import 'dart:async';
// import 'dart:io';
// import 'package:Resuss/app/helpers/service_response.dart';
// import 'package:Resuss/app/helpers/session_manager.dart';
// import 'package:Resuss/utils/logger.dart';
// import 'package:http/http.dart';
//
// bool noAuth(Failure error) {
//   if ((error.code == 403 || error.code == 401)) {
//     return true;
//   }
//   return false;
// }
//
// ServiceResponse<T> processServiceError<T>(error, [StackTrace? stack]) {
//   log("$error\n$stack");
//   if (error is Error) {
//     return serveError<T>(
//       error: error.message?.split(".").first ?? "Something went wrong",
//       // notAuthenticated: noAuth(error),
//     );
//   } else if (error is Exception) {
//
//     return serveError<T>(error: handleException(error));
//   } else {
//
//     return serveError<T>(error: error.toString());
//   }
// }
//
// String handleException(Exception e) {
//   if (e is SocketException || e is HandshakeException) {
//     log(e);
//     // if (e.message.contains("Failed host lookup")) {
//     return "Please check your Internet connection and try again later";
//     // }
//     // return "Request failed, please try again";
//   } else if (e is TimeoutException) {
//     logTimeoutException(e);
//     return "Request timed out, please try again";
//   } else if (e is FormatException || e is ClientException) {
//     log(e);
//     return "Something went wrong, please try again";
//   } else {
//     return e.toString();
//   }
// }
//
// class Failure {
//   Failure({
//     required this.status,
//     required this.code,
//     required this.message,
//   });
//
//   String status;
//   int code;
//   String message;
//
//   factory Failure.fromJson(Map<String, dynamic> json) => Failure(
//         status: json["status"],
//         code: json["code"],
//         message: json["message"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "code": code,
//         "message": message,
//       };
// }
//
// class Error {
//   String? message;
//   Errors? errors;
//
//   Error({
//       this.message,
//       this.errors,
//   });
//
//   factory Error.fromJson(Map<String, dynamic> json) => Error(
//         message: json["message"],
//         errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "message": message,
//         "errors": errors!.toJson(),
//       };
// }
//
// class Errors {
//   List<String>? email;
//   List<String>? phoneNumber;
//
//   Errors({
//      this.email,
//      this.phoneNumber,
//   });
//
//   factory Errors.fromJson(Map<String, dynamic> json) => Errors(
//         email: json["email"] == null ? []
//             : List<String>.from(json["email"].map((x) => x)),
//         phoneNumber: json["phone_number"] == null ? []
//             : List<String>.from(json["phone_number"].map((x) => x)),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "email": List<dynamic>.from(email!.map((x) => x)),
//         "phone_number": List<dynamic>.from(phoneNumber!.map((x) => x)),
//       };
//
//   String getErrorMessage() {
//     String message = "";
//     if (email!.isNotEmpty) message += "${email!.first}\n";
//     if (phoneNumber!.isNotEmpty) message += "${phoneNumber!.first}\n";
//     return message;
//   }
// }
//
// class ApiHeaders {
//   static Map<String, String> headersNoAuth() => {
//         HttpHeaders.acceptHeader: "application/json",
//         HttpHeaders.connectionHeader: "keep-alive",
//       };
//
//   static Map<String, String> headersSessionAuth(String? token) => {
//         HttpHeaders.acceptHeader: "application/json",
//         HttpHeaders.connectionHeader: "keep-alive",
//         HttpHeaders.authorizationHeader: "Bearer $token"
//       };
//
//   static Map<String, String> headersSessionAuthNoForm(String? token) => {
//         HttpHeaders.contentTypeHeader: "application/json",
//         HttpHeaders.connectionHeader: "keep-alive",
//         HttpHeaders.authorizationHeader: "Bearer $token",
//     HttpHeaders.acceptHeader: "application/json",
//
//   };
//
//   static Map<String, String> headersSessionImageAuth(String? token) => {
//         HttpHeaders.acceptHeader: "application/json",
//         HttpHeaders.connectionHeader: "keep-alive",
//         HttpHeaders.authorizationHeader: "Bearer $token",
//     // HttpHeaders.contentTypeHeader: "application/json",
//       };
//
//   static Map<String, String> getHeadersForRequest(
//       {bool isFormData = false, bool hasToken = false}) {
//     if (hasToken) {
//       return headersSessionAuth(SessionManager.getToken());
//     } else {
//
//       log(headersNoAuth());
//       if(isFormData){
//         return headersSessionImageAuth(SessionManager.getToken());
//       }else return headersNoAuth();
//     }
//   }
// }
