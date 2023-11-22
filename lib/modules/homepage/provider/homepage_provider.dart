import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopnownow/app/helpers/notifiers.dart';
import 'package:shopnownow/modules/homepage/model/homepage_model.dart';
import 'package:shopnownow/modules/homepage/repository/homepage_repository.dart';

final getCategoriesProvider = StateNotifierProvider<GetCategoriesNotifier,
    NotifierState<List<GetCategories>>>((ref) {
  return GetCategoriesNotifier();
});

final getProductsBySearchProvider = StateNotifierProvider<GetProductsBySearchNotifier,
    NotifierState<GetProductsBySearch>>((ref) {
  return GetProductsBySearchNotifier();
});

final addToListProvider = StateNotifierProvider.family<AddToListNotifier,
    NotifierState<String>, String>((ref, id) {
  return AddToListNotifier();
});

class GetCategoriesNotifier
    extends StateNotifier<NotifierState<List<GetCategories>>> {
  GetCategoriesNotifier() : super(NotifierState());

  void getCategories(
      {Function(List<GetCategories>)? then, Function(String?)? error}) async {
    state = notifyLoading();
    state = await HomePageRepository.getCategories();
    if (state.status == NotifierStatus.done) {
      if (then != null) then(state.data!);
    } else if (state.status == NotifierStatus.error) {
      if (error != null) error(state.message);
    }
  }
}

class GetProductsBySearchNotifier
    extends StateNotifier<NotifierState<GetProductsBySearch>> {
  GetProductsBySearchNotifier() : super(NotifierState());

  void getProductsBySearch(
      {required String query,
      required String categoryId,
      Function(List<Product>)? then,
      Function(String?)? error}) async {
    state = notifyLoading();
    state = await HomePageRepository.getProductsBySearch(
        query: query, categoryId: categoryId);
    if (state.status == NotifierStatus.done) {
      if (then != null) then(state.data!.products!);
    } else if (state.status == NotifierStatus.error) {
      if (error != null) error(state.message);
    }
  }
}

class AddToListNotifier
    extends StateNotifier<NotifierState<String>> {
  AddToListNotifier() : super(NotifierState());

  void addToList(
      {required AddProductRequest request,
      Function(String)? then,
      Function(String?)? error}) async {
    state = notifyLoading();
    state = await HomePageRepository.addToList(request: request);
    if (state.status == NotifierStatus.done) {
      if (then != null) then(state.data!);
    } else if (state.status == NotifierStatus.error) {
      if (error != null) error(state.message);
    }
  }
}
