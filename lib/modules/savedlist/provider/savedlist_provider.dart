import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopnownow/app/helpers/notifiers.dart';
import 'package:shopnownow/modules/savedlist/model/savedlist_model.dart';
import 'package:shopnownow/modules/savedlist/repository/savedlist_repository.dart';

final savedListProvider = StateNotifierProvider<SavedListNotifier,
    NotifierState<GetSavedList>>((ref) {
  return SavedListNotifier();
});

class SavedListNotifier extends StateNotifier<NotifierState<GetSavedList>> {
  SavedListNotifier() : super(NotifierState());

  void getSavedList(
      {Function()? then,
        bool noToken = false,
        Function(String?)? error}) async {
    state = notifyLoading();
    state =
    await SavedListRepository.getSavedList();
    if (state.status == NotifierStatus.done) {
      if (then != null) then();
    } else if (state.status == NotifierStatus.error) {
      if (error != null) error(state.message);
    }
  }
}
