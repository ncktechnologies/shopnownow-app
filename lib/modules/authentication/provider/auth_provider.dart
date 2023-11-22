import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopnownow/app/helpers/notifiers.dart';
import 'package:shopnownow/modules/authentication/repository/auth_repository.dart';

final signUpProvider =
StateNotifierProvider.autoDispose<SignUpNotifier, NotifierState<void>>(
        (ref) {
      return SignUpNotifier();
    });

final logInProvider =
StateNotifierProvider.autoDispose<LogInNotifier, NotifierState<void>>(
        (ref) {
      return LogInNotifier();
    });

final sendOtpProvider =
StateNotifierProvider.autoDispose<SendOtpNotifier, NotifierState<String>>(
        (ref) {
      return SendOtpNotifier();
    });

final forgotVerifyOtpProvider = StateNotifierProvider.autoDispose<
    ForgotVerifyOtpNotifier,
    NotifierState<void>>((ref) {
  return ForgotVerifyOtpNotifier();
});

final resetPasswordProvider = StateNotifierProvider.autoDispose<
    ResetPasswordNotifier,
    NotifierState<String>>((ref) {
  return ResetPasswordNotifier();
});

final checkOutPaymentProvider = StateNotifierProvider.autoDispose<
    CheckOutPaymentNotifier,
    NotifierState<String>>((ref) {
  return CheckOutPaymentNotifier();
});

final validateCodeProvider = StateNotifierProvider<
    ValidateCodeNotifier,
    NotifierState<String>>((ref) {
  return ValidateCodeNotifier();
});

class SignUpNotifier extends StateNotifier<NotifierState<void>> {
  SignUpNotifier() : super(NotifierState());

  void signUp({required String email,
    required String password,
    required String fullName,
    Function()? then,
    Function(String?)? error}) async {
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

class LogInNotifier extends StateNotifier<NotifierState<void>> {
  LogInNotifier() : super(NotifierState());

  void logIn({required String email,
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
  SendOtpNotifier() : super(NotifierState());

  void sendOtp({required String email,
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

class ForgotVerifyOtpNotifier extends StateNotifier<NotifierState<void>> {
  ForgotVerifyOtpNotifier() : super(NotifierState());

  void forgotVerifyOtp(
      {required String otp, Function()? then, Function(String?)? error}) async {
    state = notifyLoading();
    state = await AuthRepository.forgotVerifyOtp(
      otp: otp,
    );
    if (state.status == NotifierStatus.done) {
      if (then != null) then();
    } else if (state.status == NotifierStatus.error) {
      if (error != null) error(state.message);
    }
  }
}

class ResetPasswordNotifier extends StateNotifier<NotifierState<String>> {
  ResetPasswordNotifier() : super(NotifierState());

  void resetPassword({required String otp,
    required String password,
    required String confirmPassword,
    Function()? then,
    Function(String?)? error}) async {
    state = notifyLoading();
    state = await AuthRepository.resetPassword(
        otp: otp, password: password, confirmPassword: confirmPassword);
    if (state.status == NotifierStatus.done) {
      if (then != null) then();
    } else if (state.status == NotifierStatus.error) {
      if (error != null) error(state.message);
    }
  }
}

class CheckOutPaymentNotifier extends StateNotifier<NotifierState<String>> {
  CheckOutPaymentNotifier() : super(NotifierState());

  void checkOutPayment({required String planId,
    required String paymentRef,
    Function()? then,
    Function(String?)? error}) async {
    state = notifyLoading();
    state = await AuthRepository.checkOutPayment(
      paymentRef: paymentRef, planId: planId,);
    if (state.status == NotifierStatus.done) {
      if (then != null) then();
    } else if (state.status == NotifierStatus.error) {
      if (error != null) error(state.message);
    }
  }
}



class ValidateCodeNotifier extends StateNotifier<NotifierState<String>> {
  ValidateCodeNotifier() : super(NotifierState());

  void validateCode({required String code, required String id, Function()? then, Function(String?)? error}) async {
    state = notifyLoading();
    state = await AuthRepository.validateCode(code, id);
    if (state.status == NotifierStatus.done) {

      if (then != null) then();
    } else if (state.status == NotifierStatus.error) {
      if (error != null) {
        error(state.message);
      }
    }
  }
}
