import 'dart:async';
import 'dart:io';

import 'package:http/http.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();

void logResponse(Response response) {
  logger.i("${response.request!.url}\n"
      "${response.headers}\n"
      "${response.statusCode} : ${response.reasonPhrase}"
      "${response.body}\n");
}

void log(Object object) {
  logger.i(object);
}

void logSocketException(SocketException error) {
  logger.wtf("${error.address} \t ${error.port}\n"
      "${error.message}");
}

void logTimeoutException(TimeoutException error) {
  logger.e("${error.duration} \t ${error.message}");
}
