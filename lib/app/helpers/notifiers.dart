import 'package:flutter/material.dart';

enum NotifierStatus { loading, idle, done, error }

class NotifierState<T> {
  final T? data;
  final NotifierStatus status;
  final String? message;
  final bool noAuth;
  const NotifierState({
    this.data,
    this.status = NotifierStatus.idle,
    this.message,
    this.noAuth = false,
  });

  Widget when({
    required Widget Function(T? data) done,
    Widget Function(String? message)? error,
    Widget Function()? loading,
    Widget Function()? idle,
  }) {
    switch (status) {
      case NotifierStatus.loading:
        {
          if (loading == null) {
            return done(data);
          }
          return loading();
        }
      case NotifierStatus.idle:
        {
          if (idle == null) {
            return done(data);
          }
          return idle();
        }
      case NotifierStatus.done:
        {
          return done(data);
        }
      case NotifierStatus.error:
        {
          if (error == null) {
            return done(data);
          }
          return error(message);
        }
    }
  }
}

NotifierState<T> notifyRight<T>({required T? data, String? message}) {
  return NotifierState<T>(
    status: NotifierStatus.done,
    message: message,
    data: data,
  );
}

NotifierState<T> notifyError<T>({required String error, bool noAuth = false}) {
  return NotifierState<T>(
    status: NotifierStatus.error,
    message: error,
    noAuth: noAuth,
  );
}

NotifierState<T> notifyLoading<T>() {
  return const NotifierState(
    status: NotifierStatus.loading,
  );
}
