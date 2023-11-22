import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopnownow/app/helpers/notifiers.dart';
import 'package:shopnownow/app/helpers/session_manager.dart';
import 'package:shopnownow/modules/profile/model/profile_model.dart';
import 'package:shopnownow/modules/profile/repository/profile_repository.dart';

final updatePasswordProvider = StateNotifierProvider.autoDispose<
    UpdatePasswordNotifier, NotifierState<String>>((ref) {
  return UpdatePasswordNotifier();
});

final getProfileProvider = StateNotifierProvider<
    GetProfileNotifier, NotifierState<GetProfile>>((ref) {
  return GetProfileNotifier();
});

final updateProfileProvider = StateNotifierProvider<
    UpdateProfileNotifier, NotifierState<GetProfile>>((ref) {
  return UpdateProfileNotifier();
});

class UpdatePasswordNotifier extends StateNotifier<NotifierState<String>> {
  UpdatePasswordNotifier() : super(NotifierState());

  void updatePassword(
      {required String currentPassword,
      required String newPassword,
      Function(String)? then,
      Function(String?)? error}) async {
    state = notifyLoading();
    state = await ProfileRepository.updatePassword(
        currentPassword: currentPassword, newPassword: newPassword);
    if (state.status == NotifierStatus.done) {
      if (then != null) then(state.data!);
    } else if (state.status == NotifierStatus.error) {
      if (error != null) error(state.message);
    }
  }
}

class GetProfileNotifier extends StateNotifier<NotifierState<GetProfile>> {
  GetProfileNotifier() : super(NotifierState());

  void getProfile(
      {
      Function()? then,
      Function(String?)? error}) async {
    state = notifyLoading();
    state = await ProfileRepository.getProfile();
    if (state.status == NotifierStatus.done) {
      SessionManager.setFullName(state.data!.user!.name ?? "");
      SessionManager.setEmail(state.data!.user!.email ?? "");
      SessionManager.setPhone(state.data!.user!.phoneNumber ?? "");
      SessionManager.setWallet(state.data!.user!.wallet ?? "");
      SessionManager.setLoyaltyPoints(state.data!.user!.loyaltyPoints ?? 0);
      if (then != null) then();
    } else if (state.status == NotifierStatus.error) {
      if (error != null) error(state.message);
    }
  }
}

class UpdateProfileNotifier extends StateNotifier<NotifierState<GetProfile>> {
  UpdateProfileNotifier() : super(NotifierState());

  void updateProfile(
      {
        required String name,
        String? phone,
      Function()? then,
      Function(String?)? error}) async {
    state = notifyLoading();
    state = await ProfileRepository.updateProfile(name: name, phone: phone);
    if (state.status == NotifierStatus.done) {
      SessionManager.setFullName(state.data!.user!.name ?? "");
      SessionManager.setEmail(state.data!.user!.email ?? "");
      SessionManager.setPhone(state.data!.user!.phoneNumber ?? "");
      SessionManager.setWallet(state.data!.user!.wallet ?? "");
      SessionManager.setLoyaltyPoints(state.data!.user!.loyaltyPoints ?? 0);
      if (then != null) then();
    } else if (state.status == NotifierStatus.error) {
      if (error != null) error(state.message);
    }
  }
}
