
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopnownow/app/helpers/notifiers.dart';
import 'package:shopnownow/modules/specialrequest/repository/special_repo.dart';

final specialRequestProvider =
StateNotifierProvider.autoDispose<SpecialRequestNotifier, NotifierState<String>>(
        (ref) {
      return SpecialRequestNotifier();
    });

class SpecialRequestNotifier extends StateNotifier<NotifierState<String>> {
  SpecialRequestNotifier() : super(NotifierState());

  void specialRequest({required String request,
    required String comment,
    Function(String)? then,
    Function(String?)? error}) async {
    state = notifyLoading();
    state = await SpecialRepository.makeSpecialRequest(comment: comment, request: request);
    if (state.status == NotifierStatus.done) {
      if (then != null) then(state.data!);
    } else if (state.status == NotifierStatus.error) {
      if (error != null) error(state.message);
    }
  }
}