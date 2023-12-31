import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopnownow/app/helpers/notifiers.dart';
import 'package:shopnownow/modules/authentication/repository/auth_repository.dart';

final signUpProvider =
    StateNotifierProvider.autoDispose<SignUpNotifier, NotifierState<void>>(
        (ref) {
  return SignUpNotifier();
});

final logInProvider =
    StateNotifierProvider.autoDispose<LogInNotifier, NotifierState>((ref) {
  return LogInNotifier();
});

final sendOtpProvider =
    StateNotifierProvider.autoDispose<SendOtpNotifier, NotifierState<String>>(
        (ref) {
  return SendOtpNotifier();
});

final forgotVerifyOtpProvider = StateNotifierProvider.autoDispose<
    ForgotVerifyOtpNotifier, NotifierState<void>>((ref) {
  return ForgotVerifyOtpNotifier();
});

final resendOtpProvider =
    StateNotifierProvider.autoDispose<ResendOtpNotifier, NotifierState<void>>(
        (ref) {
  return ResendOtpNotifier();
});

final resetPasswordProvider = StateNotifierProvider.autoDispose<
    ResetPasswordNotifier, NotifierState<String>>((ref) {
  return ResetPasswordNotifier();
});

final forgotPasswordProvider =
    StateNotifierProvider<ForgotPasswordNotifier, NotifierState<String>>((ref) {
  return ForgotPasswordNotifier();
});

class SignUpNotifier extends StateNotifier<NotifierState<void>> {
  SignUpNotifier() : super(const NotifierState());

  void signUp(
      {required String email,
      required String password,
      required String fullName,
      Function()? then,
      Function(String?)? error}) async {
    logAnalyticsEvent('sign_up');
    state = notifyLoading();
    state = await AuthRepository.signUp(
      email: email,
      password: password,
      fullName: fullName,
    );
    if (state.status == NotifierStatus.done) {
      if (then != null) then();
    } else if (state.status == NotifierStatus.error) {
      if (error != null) error(state.message);
    }
  }
}

class LogInNotifier extends StateNotifier<NotifierState> {
  LogInNotifier() : super(const NotifierState());

  void logIn(
      {required String email,
      required String password,
      Function()? then,
      Function(String?)? error}) async {
    state = notifyLoading();
    state = await AuthRepository.logIn(email: email, password: password);
    if (state.status == NotifierStatus.done) {
      if (then != null) then();
    } else if (state.status == NotifierStatus.error) {
      if (error != null) error(state.message);
    }
  }
}

class SendOtpNotifier extends StateNotifier<NotifierState<String>> {
  SendOtpNotifier() : super(const NotifierState());

  void sendOtp(
      {required String email,
      Function(String?)? then,
      Function(String?)? error}) async {
    state = notifyLoading();
    state = await AuthRepository.sendOtp(
      email: email,
    );
    if (state.status == NotifierStatus.done) {
      if (then != null) then(state.data ?? state.message ?? "");
    } else if (state.status == NotifierStatus.error) {
      if (error != null) error(state.message);
    }
  }
}

class ForgotVerifyOtpNotifier extends StateNotifier<NotifierState<String>> {
  ForgotVerifyOtpNotifier() : super(const NotifierState());

  void forgotVerifyOtp(
      {required String email,
      required String otp,
      Function()? then,
      Function(String?)? error}) async {
    state = notifyLoading();
    state = await AuthRepository.forgotVerifyOtp(otp: otp, email: email);
    if (state.status == NotifierStatus.done) {
      if (then != null) then();
    } else if (state.status == NotifierStatus.error) {
      if (error != null) error(state.message);
    }
  }
}

class ResendOtpNotifier extends StateNotifier<NotifierState<String>> {
  ResendOtpNotifier() : super(const NotifierState());

  void resendOtp(
      {required String email,
      Function()? then,
      Function(String?)? error}) async {
    state = notifyLoading();
    state = await AuthRepository.resendOtp(email: email);
    if (state.status == NotifierStatus.done) {
      if (then != null) then();
    } else if (state.status == NotifierStatus.error) {
      if (error != null) error(state.message);
    }
  }
}

class ResetPasswordNotifier extends StateNotifier<NotifierState<String>> {
  ResetPasswordNotifier() : super(const NotifierState());

  void resetPassword(
      {required String otp,
      required String password,
      required String confirmPassword,
      required String email,
      Function()? then,
      Function(String?)? error}) async {
    state = notifyLoading();
    state = await AuthRepository.resetPassword(
        otp: otp,
        password: password,
        confirmPassword: confirmPassword,
        email: email);
    if (state.status == NotifierStatus.done) {
      if (then != null) then();
    } else if (state.status == NotifierStatus.error) {
      if (error != null) error(state.message);
    }
  }
}

class ForgotPasswordNotifier extends StateNotifier<NotifierState<String>> {
  ForgotPasswordNotifier() : super(const NotifierState());

  void forgotPassword(
      {required String email,
      Function()? then,
      Function(String?)? error}) async {
    state = notifyLoading();
    state = await AuthRepository.forgotPassword(email);
    if (state.status == NotifierStatus.done) {
      if (then != null) then();
    } else if (state.status == NotifierStatus.error) {
      if (error != null) {
        error(state.message);
      }
    }
  }
}

Future<void> logAnalyticsEvent(String eventName) async {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  await analytics.logEvent(
    name: eventName,
    parameters: <String, dynamic>{
      'string': 'string',
      'int': 42,
      'long': 12345678910,
      'double': 42.0,
      'bool': true.toString(),
    },
  );
}
