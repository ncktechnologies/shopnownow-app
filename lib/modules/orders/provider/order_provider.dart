import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopnownow/app/helpers/notifiers.dart';
import 'package:shopnownow/modules/orders/model/order_model.dart';
import 'package:shopnownow/modules/orders/repository/order_repository.dart';

final orderProvider = StateNotifierProvider<OrderProviderNotifier,
    NotifierState<OrderResponse>>((ref) {
  return OrderProviderNotifier();
});

final reorderProvider = StateNotifierProvider.family<ReOrderProviderNotifier,
    NotifierState<String>, int>((ref, id) {
  return ReOrderProviderNotifier();
});

class OrderProviderNotifier extends StateNotifier<NotifierState<OrderResponse>> {
  OrderProviderNotifier() : super(NotifierState());

  void getOrder(

      { bool? loading = true,Function()? then,
        bool noToken = false,
        Function(String?)? error}) async {
   loading! ?  state = notifyLoading() : null;
    state =
    await OrderRepository.getOrders();
    if (state.status == NotifierStatus.done) {
      if (then != null) then();
    } else if (state.status == NotifierStatus.error) {
      if (error != null) error(state.message);
    }
  }
}

class ReOrderProviderNotifier extends StateNotifier<NotifierState<String>> {
  ReOrderProviderNotifier() : super(NotifierState());

  void reOrder(
      {required String id,Function(String)? then,
        bool noToken = false,
        Function(String?)? error}) async {
    state = notifyLoading();
    state =
    await OrderRepository.reOrder(id: id);
    if (state.status == NotifierStatus.done) {
      if (then != null) then(state.data ?? "");
    } else if (state.status == NotifierStatus.error) {
      if (error != null) error(state.message);
    }
  }
}
