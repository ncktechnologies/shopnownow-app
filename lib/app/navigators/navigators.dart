import 'package:flutter/material.dart';
import 'package:shopnownow/utils/constants.dart';

Future<T?> pushTo<T>(
  Widget page, {
  RouteSettings? settings,
}) async {
  return await Navigator.push<T>(
    navigatorKey.currentState!.context,
    MaterialPageRoute(
      builder: (context) => page,
      settings: settings,
    ),
  );
}

Future<T> pushReplacementTo<T>(
  Widget page,
) async {
  return await Navigator.pushReplacement(
    navigatorKey.currentState!.context,
    MaterialPageRoute(builder: (context) => page),
  );
}

Future<T?> pushToAndClearStack<T>(Widget page) {
  return Navigator.of(navigatorKey.currentState!.context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => page),
    (route) => false,
  );
}
